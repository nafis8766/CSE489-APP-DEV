import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageService {
  static Future<File?> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      return File(picked.path);
    }
    return null;
  }
}