import 'package:flutter/material.dart';
import '../models/landmark.dart';
import '../services/api_service.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';

class LandmarkProvider with ChangeNotifier {
  List<Landmark> _landmarks = [];
  bool isLoading = false;
  List<int> _visitedIds = [];

  LandmarkProvider() {
    if (Hive.isBoxOpen('visitedBox')) {
      final box = Hive.box('visitedBox');
      var entries = box.toMap().entries.toList();
      
      // Sort descending by timestamp
      entries.sort((a, b) {
        int timeA = a.value is int ? a.value as int : 0;
        int timeB = b.value is int ? b.value as int : 0;
        return timeB.compareTo(timeA);
      });
      
      _visitedIds = entries.map((e) => e.key as int).toList();
    }
  }

  List<Landmark> get landmarks => _landmarks;
  Iterable<int> get visitedIds => _visitedIds;
  bool hasVisited(int id) => _visitedIds.contains(id);

  void _markVisited(int id) {
    _visitedIds.remove(id); // remove it so we can push it strictly to the top
    _visitedIds.insert(0, id); 

    if (Hive.isBoxOpen('visitedBox')) {
      Hive.box('visitedBox').put(id, DateTime.now().millisecondsSinceEpoch);
    }
    notifyListeners();
  }
   
    Future<String> deleteLandmark(int id) async {
    try {
        return await ApiService.deleteLandmark(id);
    } catch (e) {
        return "Error deleting landmark";
    }
    }
    Future<String> addLandmark(
    String title,
    double lat,
    double lon,
    File image,
    ) async {
    try {
        return await ApiService.createLandmark(
            title, lat, lon, image);
    } catch (e) {
        return "Error adding landmark";
    }
    }

    Future<String> visitLandmark(int id, double lat, double lon) async {
    var connectivity = await Connectivity().checkConnectivity();
    final queueBox = Hive.box('visitQueue');

    if (connectivity == ConnectivityResult.none) {
        // Save offline request
        queueBox.add({
        "id": id,
        "lat": lat,
        "lon": lon,
        });

        _markVisited(id);
        return "Saved offline. Will sync later.";
    }

    try {
        final result = await ApiService.visitLandmark(id, lat, lon);
        _markVisited(id);
        return "Distance: ${result['distance']} m";
    } catch (e) {
        return "Visit failed";
    }
    }
    Future<void> fetchLandmarks() async {
    isLoading = true;
    notifyListeners();

    final box = Hive.box('landmarksBox');

    try {
        // Try API
        _landmarks = await ApiService.getLandmarks();

        // Save to local
        box.put('data', _landmarks.map((e) => {
        "id": e.id,
        "title": e.title,
        "lat": e.lat,
        "lon": e.lon,
        "image": e.image,
        "score": e.score,
        "visit_count": e.visitCount,
        }).toList());

    } catch (e) {
        // If offline → load from cache
        final cached = box.get('data', defaultValue: []);

        _landmarks = cached.map<Landmark>((e) {
        return Landmark.fromJson(e);
        }).toList();
    }

    isLoading = false;
    notifyListeners();
    }
    }
    Future<void> syncVisits() async {
    final queueBox = Hive.box('visitQueue');

    if (queueBox.isEmpty) return;

    for (var item in queueBox.values) {
        try {
        await ApiService.visitLandmark(
            item['id'],
            item['lat'],
            item['lon'],
        );
        } catch (e) {
        return; // stop if still offline
        }
    }

    queueBox.clear();
    }