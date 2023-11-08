import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../ui/custom_camera.dart';

late List<CameraDescription> _cameras;

class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CameraDescription>> snapshot) {
        if (snapshot.hasData) {
          _cameras = snapshot.data!;
          controller = CameraController(_cameras[0], ResolutionPreset.max);
          return FutureBuilder(
              future: controller.initialize(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CustomCamera(controller: controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
