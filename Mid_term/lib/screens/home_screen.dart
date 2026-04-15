import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../providers/landmark_provider.dart';
import 'map_screen.dart';
import 'landmark_list_screen.dart';
import 'add_landmark_screen.dart';
import 'activity_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      Provider.of<LandmarkProvider>(context, listen: false).fetchLandmarks()
    );
    checkAndSync();
    screens = [
      MapScreen(),
      LandmarkListScreen(),
      ActivityScreen(),
      AddLandmarkScreen(),
    ];
  }

  void checkAndSync() async {
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity != ConnectivityResult.none) {
      await syncVisits();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Landmarks"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
        ],
      ),
    );
  }
}