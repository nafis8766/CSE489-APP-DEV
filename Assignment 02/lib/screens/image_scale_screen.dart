import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageScaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(
        "https://picsum.photos/500",
      ),
    );
  }
}