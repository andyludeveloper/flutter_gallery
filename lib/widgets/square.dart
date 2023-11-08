import 'package:flutter/material.dart';
import 'package:gallery/provider/captured_image_provider.dart';
import 'package:provider/provider.dart';

import 'camera_app.dart';

class Square extends StatelessWidget {
  final double width;
  final double height;

  const Square({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //draw a square with + in the center and width and height as passed in
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: width,
            height: height,
            // color: Colors.grey,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: const Icon(Icons.add, color: Colors.black)),
      ),
      onTap: () {
        BuildContext currentContext = context;
        Navigator.push(
          currentContext,
          MaterialPageRoute(builder: (context) => const CameraApp()),
        ).then((image) {
          if (image != null) {
            debugPrint("image: $image");
            currentContext.read<CapturedImageProvider>().addImage(image);
          }
        });
      },
    );
  }
}
