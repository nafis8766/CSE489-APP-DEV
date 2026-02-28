import 'package:flutter/material.dart';
import 'screens/broadcast_screen.dart';
import 'screens/image_scale_screen.dart';
import 'screens/video_screen.dart';
import 'screens/audio_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget selectedScreen = BroadcastScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CSE 489 Assignment 2")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),

            ListTile(
              title: Text("Broadcast Receiver"),
              onTap: () {
                setState(() {
                  selectedScreen = BroadcastScreen();
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text("Image Scale"),
              onTap: () {
                setState(() {
                  selectedScreen = ImageScaleScreen();
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text("Video"),
              onTap: () {
                setState(() {
                  selectedScreen = VideoScreen();
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: Text("Audio"),
              onTap: () {
                setState(() {
                  selectedScreen = AudioScreen();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: selectedScreen,
    );
  }
}