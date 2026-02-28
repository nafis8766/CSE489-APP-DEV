import 'package:flutter/material.dart';

class BroadcastResultScreen extends StatelessWidget {

  final String message;

  BroadcastResultScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Broadcast Receiver")),
      body: Center(
        child: Text(
          "Received Message:\n$message",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}