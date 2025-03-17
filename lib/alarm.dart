import 'package:flutter/material.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  bool showSlider = false;
  int selectedHour = 0;
  int selectedMinute = 0;

  List<String> savedAlarms = [];

  // Function to build the hour and minute pickers
  Widget buildTimePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
          width: 100,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                int displayIndex = (index % 24); // 1 to 12 (12-hour format)
                return Text(
                  displayIndex.toString().padLeft(2, '0'),
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                );
              },
              childCount: 100, // Limit to 12-hour format
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedHour = (index % 24) ; // Fixes incorrect hour values
              });
            },
          ),
        ),
        const Text(":", style: TextStyle(color: Colors.white, fontSize: 40)),
        SizedBox(
          height: 150,
          width: 100,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                int displayIndex = (index * 1) % 60; // Show minutes in 5-minute steps
                return Text(
                  displayIndex.toString().padLeft(2, '0'),
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                );
              },
              childCount: 1000, // 12 x 5 = 60 minutes
            ),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedMinute = (index * 1) % 60;
              });
            },
          ),
        ),
      ],
    );
  }

  // Function to save alarm
  void saveAlarm() {
    String alarmTime = '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}';
    
    setState(() {
      savedAlarms.add(alarmTime);
      showSlider = false; // Close slider after saving
    });
  }

  // Function to build the bottom slider
  Widget buildBottomSlider() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 350,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 46, 43, 43),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      showSlider = false;
                    });
                  },
                  child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: saveAlarm, // Save button
                  child: const Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildTimePicker(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Alarm")),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showSlider = true;
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: savedAlarms.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color.fromARGB(255, 96, 103, 116),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          savedAlarms[index],
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          if (showSlider) buildBottomSlider(),
        ],
      ),
    );
  }
}
