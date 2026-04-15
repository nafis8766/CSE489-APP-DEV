import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/landmark_provider.dart';
import '../widgets/landmark_card.dart';
import '../models/landmark.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LandmarkProvider>(context);
    
    final visitedLandmarks = provider.visitedIds
        .map((id) {
          try {
            return provider.landmarks.firstWhere((l) => l.id == id);
          } catch (e) {
            return null;
          }
        })
        .whereType<Landmark>()
        .toList();


    return Scaffold(
      appBar: AppBar(title: Text("Activity / Visited")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : visitedLandmarks.isEmpty
              ? Center(child: Text("No visited landmarks yet. Go explore!"))
              : ListView.builder(
                  itemCount: visitedLandmarks.length,
                  itemBuilder: (context, index) {
                    return LandmarkCard(visitedLandmarks[index]);
                  },
                ),
    );
  }
}
