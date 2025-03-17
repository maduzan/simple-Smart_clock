import 'dart:async';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {

  late String time ="";
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startClock();
  }



  void startClock() {
     
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {

      setState(() {
         final now = DateTime.now();
        time= _formatTime(now);
        
      });

       

    }); 
  }
  String _formatTime(DateTime time) {
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
            SizedBox(height: 60,),
           // Center(child: Text("World Clock " ,style: TextStyle(fontSize: 50,color: Colors.white))),
            
            SizedBox(height: 250,),


            Center(child: Text("$time",style: TextStyle(color: Colors.white ,fontSize: 80),))
          ],

        
        )


        );
  }
}
