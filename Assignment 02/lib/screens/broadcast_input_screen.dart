import 'package:flutter/material.dart';
import 'broadcast_result_screen.dart';

class BroadcastInputScreen extends StatelessWidget {

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Message")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Enter text"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        BroadcastResultScreen(message: controller.text),
                  ),
                );
              },
              child: Text("Send"),
            )
          ],
        ),
      ),
    );
  }
}