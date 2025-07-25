import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class HeartRain extends StatefulWidget {
  const HeartRain({super.key});

  @override
  State<HeartRain> createState() => _HeartRainState();
}

class _HeartRainState extends State<HeartRain> with TickerProviderStateMixin {
  final int numberOfHearts = 30;
  final List<_HeartModel> hearts = [];
  final Random random = Random();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _playing = false;
  final List<String> phrases = [
    "Você é o meu mundo 💫",
    "Te amo mais que ontem ❤️",
    "Com você, tudo é melhor 💜",
    "Meu coração é seu 💘",
  ];
  int _phraseIndex = 0;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < numberOfHearts; i++) {
      hearts.add(_createHeart());
    }

    Future.delayed(Duration.zero, () {
      setState(() {});
    });

    // Alterna as frases a cada 3 segundos
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return false;
      setState(() {
        _phraseIndex = (_phraseIndex + 1) % phrases.length;
      });
      return true;
    });
  }

  _HeartModel _createHeart() {
    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000 + random.nextInt(3000)),
    )..repeat();

    final fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    final animation = Tween<double>(
      begin: -50,
      end: MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height + 50,
    ).animate(controller);

    final rotation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    return _HeartModel(
      animation: animation,
      controller: controller,
      rotation: rotation,
      fade: fadeController,
      left: random.nextDouble(),
      size: 15.0 + random.nextDouble() * 30,
      color: Colors.pinkAccent.withOpacity(0.8),
    );
  }

  void _playOrPause() async {
    if (_playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource('romantic.mp3'), volume: 0.5);
    }
    setState(() => _playing = !_playing);
  }

  void _explodeHeart(Offset offset) {
    setState(() {
      hearts.add(
        _HeartModel(
          animation: AlwaysStoppedAnimation(offset.dy),
          controller: AnimationController(vsync: this),
          rotation: AlwaysStoppedAnimation(0),
          fade: AnimationController(vsync: this),
          left: offset.dx / MediaQuery.of(context).size.width,
          size: 20 + random.nextDouble() * 20,
          color: Colors.pink.withOpacity(0.9),
        ),
      );
    });
  }

  @override
  void dispose() {
    for (var h in hearts) {
      h.controller.dispose();
      h.fade.dispose();
    }
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _explodeHeart(details.localPosition),
      child: Stack(
        children: [
          // Corações caindo
          ...hearts.map((heart) {
            return AnimatedBuilder(
              animation: Listenable.merge([heart.controller, heart.fade]),
              builder: (_, __) {
                return Positioned(
                  top: heart.animation.value,
                  left: heart.left * MediaQuery.of(context).size.width,
                  child: Opacity(
                    opacity: (sin(heart.fade.value * pi) * 0.5 + 0.5),
                    child: Transform.rotate(
                      angle: heart.rotation.value,
                      child: Icon(
                        Icons.favorite,
                        color: heart.color,
                        size: heart.size,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),

          // Mensagem principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'I love you baby',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Be my valentine?',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  '~Andre 💛 Juliana',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Text(
                  phrases[_phraseIndex],
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: _playOrPause,
                  icon: Icon(
                    _playing ? Icons.pause_circle : Icons.play_circle,
                    color: Colors.white,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeartModel {
  final Animation<double> animation;
  final AnimationController controller;
  final Animation<double> rotation;
  final AnimationController fade;
  final double left;
  final double size;
  final Color color;

  _HeartModel({
    required this.animation,
    required this.controller,
    required this.rotation,
    required this.fade,
    required this.left,
    required this.size,
    required this.color,
  });
}