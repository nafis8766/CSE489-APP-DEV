import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/landmark_provider.dart';
import '../widgets/landmark_card.dart';

class LandmarkListScreen extends StatefulWidget {
  @override
  _LandmarkListScreenState createState() => _LandmarkListScreenState();
}

class _LandmarkListScreenState extends State<LandmarkListScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<LandmarkProvider>(context, listen: false)
        .fetchLandmarks();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LandmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Landmarks")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.landmarks.length,
              itemBuilder: (context, index) {
                return LandmarkCard(provider.landmarks[index]);
              },
            ),
    );
  }
}