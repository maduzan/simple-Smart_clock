
import 'package:flutter/material.dart';
import 'package:smallclock/alarm.dart';
import 'package:smallclock/page.dart';
import 'package:smallclock/stopwatch.dart';

void main() {
  runApp(const ClockApp());
}
class ClockApp extends StatefulWidget {
  const ClockApp({super.key});

  @override
  State<ClockApp> createState() => _ClockState();
}

class _ClockState extends State<ClockApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:const Clock() ,
      routes: {
         '/alarm': (context) => const Alarm(),
         '/home':(context)=>const Clock(),
         '/stop':(context)=> const Staopwatch()
      },

    );
  }
}
