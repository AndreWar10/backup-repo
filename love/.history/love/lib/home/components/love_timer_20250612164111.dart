import 'dart:async';
import 'package:flutter/material.dart';

class LoveTimer extends StatefulWidget {
  const LoveTimer({super.key});

  @override
  State<LoveTimer> createState() => _LoveTimerState();
}

class _LoveTimerState extends State<LoveTimer> {
  late Timer _timer;
  late Duration _duration;

  final DateTime _startDate = DateTime(2022, 10, 7, 22, 0, 0); // 7 de outubro de 2022 às 22h

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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Estamos juntos há:',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _formatDuration(_duration),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
