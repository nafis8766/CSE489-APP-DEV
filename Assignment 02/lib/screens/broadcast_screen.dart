import 'package:flutter/material.dart';
import 'broadcast_input_screen.dart';
import 'package:battery_plus/battery_plus.dart';

class BroadcastScreen extends StatefulWidget {
  @override
  _BroadcastScreenState createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {

  String selectedOption = "Custom Broadcast Receiver";
  final battery = Battery();
  String batteryLevel = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [

          DropdownButton<String>(
            value: selectedOption,
            items: [
              "Custom Broadcast Receiver",
              "System Battery Notification Receiver"
            ].map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
              });
            },
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {

              if (selectedOption == "Custom Broadcast Receiver") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BroadcastInputScreen()),
                );
              } else {
                final level = await battery.batteryLevel;
                setState(() {
                  batteryLevel = "Battery: $level%";
                });
              }
            },
            child: Text("Proceed"),
          ),

          SizedBox(height: 20),
          Text(batteryLevel),
        ],
      ),
    );
  }
}