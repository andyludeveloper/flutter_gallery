import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CustomCamera extends StatelessWidget {
  final CameraController controller;

  const CustomCamera({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraPreview(controller),
        Align(
          alignment: Alignment.bottomCenter,
          child:
          // button to take picture
          FloatingActionButton(
            child: const Icon(Icons.camera),
            onPressed: () async {
              try {
               final file =  await controller.takePicture();
               // check file correct and back to previous page
                Navigator.pop(context, file.path);
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          ),
        )
      ],
    );
  }
}
