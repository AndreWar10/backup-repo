import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class BackgroundMusicPlayer extends StatefulWidget {
  const BackgroundMusicPlayer({super.key});

  @override
  State<BackgroundMusicPlayer> createState() => _BackgroundMusicPlayerState();
}

class _BackgroundMusicPlayerState extends State<BackgroundMusicPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playMusic();
  }

  Future<void> _playMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('songs/those-eyes.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // Oculto
  }
}
