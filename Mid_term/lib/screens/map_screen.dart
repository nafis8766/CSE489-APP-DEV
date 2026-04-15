import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/landmark_provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final landmarks =
        Provider.of<LandmarkProvider>(context).landmarks;

    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(23.6850, 90.3563), // Bangladesh
          initialZoom: 6,
        ),
        children: [
          // Map tiles
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.lab_exam',
          ),

          // Markers
          MarkerLayer(
            markers: landmarks.map((l) {
              return Marker(
                point: LatLng(l.lat, l.lon),
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(l.title),
                        content: Text("Score: ${l.score}"),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.location_on,
                    size: 40,
                    color: getMarkerColor(l.score),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color getMarkerColor(double score) {
    if (score < 0) {
      return Colors.red;
    } else if (score == 0) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}