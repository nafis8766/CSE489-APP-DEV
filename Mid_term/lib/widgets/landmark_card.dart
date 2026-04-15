import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/landmark.dart';
import 'package:provider/provider.dart';
import '../providers/landmark_provider.dart';
import '../services/location_service.dart';

class LandmarkCard extends StatelessWidget {
  final Landmark landmark;

  const LandmarkCard(this.landmark, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: landmark.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ElevatedButton(
            onPressed: () async {
              final provider =
                  Provider.of<LandmarkProvider>(context, listen: false);

              String result = await provider.deleteLandmark(landmark.id);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result)),
              );
            },
            child: Text("Delete"),
          ),
          ElevatedButton(
            onPressed: () async {
                try {
                final position = await LocationService.getCurrentLocation();

                final provider =
                    Provider.of<LandmarkProvider>(context, listen: false);

                String result = await provider.visitLandmark(
                    landmark.id,
                    position.latitude,
                    position.longitude,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                );
                } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                );
                }
            },
            child: Text("Visit"),
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              landmark.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Score: ${landmark.score}"),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}