import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  String time ="" ;
  late Timer timer;
   DateTime now =DateTime.now();

  @override
  void initState() {
    super.initState();
    startClock();
  }



  void startClock() {
     
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {

      setState(() {
        now = DateTime.now(); 
        time = _formatTime(now);
        
      });

       

    }); 
  }
  String _formatTime(time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[700], 
          shape: const CircularNotchedRectangle(), // Adds a small notch effect
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center the icon
              children: [
               
                 IconButton(
                  onPressed: () {

                    Navigator.of(context).pushNamed('/stop');
                  }, 
                  icon: const Icon(Icons.timer, color: Colors.white,size: 40,),
                ),
                  SizedBox(height: 20,),
                 IconButton(
                  onPressed: () {
                      Navigator.of(context).pushNamed('/alarm');

                  }, 
                  icon: const Icon(Icons.alarm, color: Colors.white,size: 40,),
                ),
              ],
            ),
          ),
        ),
        body:Column(
          children: [
           // Center(child: Text("World Clock " ,style: TextStyle(fontSize: 50,color: Colors.white))),
            
            SizedBox(height: 180,),


            Center(child: Text("$time",style: TextStyle(color: Colors.white ,fontSize: 80),)),


            SizedBox(height: 50,),
            CustomPaint(
              size: Size(350, 350),
                painter: ClockPainter(now),
            )
          ],

        
        )


        );
  }

  
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter(this.dateTime);




  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paintCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final paintDot = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, 5, paintDot);

    drawNumbers(canvas, size);

    // Draw hour, minute, second hands
    drawHand(canvas, center, radius * 0.5, dateTime.hour * 30 + dateTime.minute * 0.5, Colors.white, 8);
    drawHand(canvas, center, radius * 0.7, dateTime.minute * 6, Colors.blue, 5);
    drawHand(canvas, center, radius * 0.9, dateTime.second * 6, Colors.red, 2);
  }

  void drawHand(Canvas canvas, Offset center, double length, double angle, Color color, double strokeWidth) {
    final radians = (angle - 90) * pi / 180;
    final handPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final handEnd = Offset(center.dx + length * cos(radians), center.dy + length * sin(radians));
    canvas.drawLine(center, handEnd, handPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;


  void drawNumbers(Canvas canvas, Size size) {
  final center = Offset(size.width / 2, size.height / 2);
  final radius = size.width / 2 - 20; // Adjust for padding
  final textStyle = TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold);

  for (int i = 1; i <= 12; i++) {
    double angle = (i * 30 - 90) * pi / 180; // Convert degrees to radians
    final textSpan = TextSpan(text: i.toString(), style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();

    // Calculate text position
    final offset = Offset(
      center.dx + radius * cos(angle) - textPainter.width / 2,
      center.dy + radius * sin(angle) - textPainter.height / 2,
    );

    textPainter.paint(canvas, offset);
  }
}

}

