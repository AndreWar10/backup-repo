import 'dart:async';
import 'package:flutter/material.dart';
import 'package:love/core/fonts/app_fonts.dart';

class LoveTimer extends StatefulWidget {
  const LoveTimer({super.key});

  @override
  State<LoveTimer> createState() => _LoveTimerState();
}

class _LoveTimerState extends State<LoveTimer> {
  late Timer _timer;
  late Duration _duration;

  final DateTime _startDate = DateTime(2022, 10, 7, 22, 0, 0);

  @override
  void initState() {
    super.initState();
    _duration = DateTime.now().difference(_startDate);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _duration = DateTime.now().difference(_startDate);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    int totalDays = duration.inDays;
    int years = totalDays ~/ 365;
    int months = (totalDays % 365) ~/ 30;
    int days = (totalDays % 365) % 30;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;

    return "$years anos, $months meses, $days dias,\n"
        "$hours horas, $minutes minutos e $seconds segundos 💕";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 244, 128, 255), Color.fromARGB(255, 220, 82, 255)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.25),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.white70,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'Estamos juntos há:',
              style: TextStyle(
                fontSize: 26,
                fontFamily: AppFonts.poppins600,
                color: Colors.white,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _formatDuration(_duration),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: AppFonts.poppins600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
