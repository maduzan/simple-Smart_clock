import 'dart:async';

import 'package:flutter/material.dart';

class Staopwatch extends StatefulWidget {
  const Staopwatch({super.key});

  @override
  State<Staopwatch> createState() => _StaopwatchState();
}

class _StaopwatchState extends State<Staopwatch> {

 Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
        setState(() {
          _elapsedSeconds++;
        });
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    setState(() {
      _elapsedSeconds = 0;
      _isRunning = false;
    });
  }

String formatTime(int totalMilliseconds) {
  int minutes = (totalMilliseconds % 3600000) ~/ 60000;
  int seconds = (totalMilliseconds % 60000) ~/ 1000;
  int milliseconds = totalMilliseconds % 1000;

  return 
      '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}.'
      '${milliseconds.toString().padLeft(3, '0')}';
}



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(formatTime(_elapsedSeconds),style: TextStyle(fontSize: 60),),
                      SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  child: Text('Start'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: pauseTimer,
                  child: Text('Pause'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
    );
  }
}