import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/landmark_provider.dart';
import '../services/image_service.dart';
import '../services/location_service.dart';

class AddLandmarkScreen extends StatefulWidget {
  @override
  _AddLandmarkScreenState createState() => _AddLandmarkScreenState();
}

class _AddLandmarkScreenState extends State<AddLandmarkScreen> {

  TextEditingController titleController = TextEditingController();
  File? selectedImage;
  double? lat, lon;

  Future<void> pickImage() async {
    selectedImage = await ImageService.pickImage();
    setState(() {});
  }

  Future<void> getLocation() async {
    final pos = await LocationService.getCurrentLocation();
    lat = pos.latitude;
    lon = pos.longitude;
    setState(() {});
  }

  Future<void> submit() async {
    if (titleController.text.isEmpty ||
        selectedImage == null ||
        lat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fill all fields")),
      );
      return;
    }

    final provider =
        Provider.of<LandmarkProvider>(context, listen: false);

    String result = await provider.addLandmark(
      titleController.text,
      lat!,
      lon!,
      selectedImage!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Landmark")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: getLocation,
              child: Text(lat == null
                  ? "Get Location"
                  : "Lat: $lat, Lon: $lon"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: pickImage,
              child: Text("Pick Image"),
            ),

            if (selectedImage != null)
              Image.file(selectedImage!, height: 150),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: submit,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}