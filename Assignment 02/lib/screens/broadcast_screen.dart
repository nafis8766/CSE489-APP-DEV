import 'package:flutter/material.dart';
import 'broadcast_input_screen.dart';
import 'package:battery_plus/battery_plus.dart';

class BroadcastScreen extends StatefulWidget {
  const BroadcastScreen({super.key});

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {

  String selectedOption = "Custom Broadcast Receiver";
  final Battery battery = Battery();
  String batteryLevel = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SizedBox(
              width: constraints.maxWidth > 600 ? 400 : 300,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    DropdownButton<String>(
                      isExpanded: true,
                      value: selectedOption,
                      items: [
                        "Custom Broadcast Receiver",
                        "System Battery Notification Receiver"
                      ].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () async {

                        if (selectedOption ==
                            "Custom Broadcast Receiver") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BroadcastInputScreen(),
                            ),
                          );
                        } else {
                          final level =
                          await battery.batteryLevel;
                          setState(() {
                            batteryLevel =
                            "Battery: $level%";
                          });
                        }
                      },
                      child: const Text("Proceed"),
                    ),

                    const SizedBox(height: 20),

                    if (batteryLevel.isNotEmpty)
                      Text(
                        batteryLevel,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
