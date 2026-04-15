import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/landmark.dart';
import 'dart:io';

class ApiService {
  static const String baseUrl =
      "https://labs.anontech.info/cse489/exm3/api.php";
  static const String apiKey = "22301031";
  static Future<Map<String, dynamic>> visitLandmark(
    int id, double lat, double lon) async {

  final url = Uri.parse(
      "$baseUrl?action=visit_landmark&key=$apiKey");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "landmark_id": id,
      "user_lat": lat,
      "user_lon": lon,
    }),
  );
  
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Visit failed");
  }
}

  static Future<String> deleteLandmark(int id) async {
  final url = Uri.parse(
      "$baseUrl?action=delete_landmark&key=$apiKey");

  final response = await http.post(
    url,
    body: {
      "id": id.toString(),
    },
  );

  if (response.statusCode == 200) {
    return "Deleted successfully";
  } else {
    return "Delete failed";
  }
}

static Future<String> createLandmark(
  String title,
  double lat,
  double lon,
  File image,
) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse("$baseUrl?action=create_landmark&key=$apiKey"),
  );

  request.fields['title'] = title;
  request.fields['lat'] = lat.toString();
  request.fields['lon'] = lon.toString();

  request.files.add(
    await http.MultipartFile.fromPath('image', image.path),
  );

  var response = await request.send();

  if (response.statusCode == 200) {
    return "Landmark added successfully";
  } else {
    return "Failed to add landmark";
  }
}

  static Future<List<Landmark>> getLandmarks() async {
    final url = Uri.parse("$baseUrl?action=get_landmarks&key=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Landmark.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load landmarks");
    }
  }
}