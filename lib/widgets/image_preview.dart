import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String path;

  const ImagePreview({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //full screen image
    return Scaffold(
        appBar: AppBar(
          title: const Text("Preview"),
        ),
        body: Hero(
          tag: path,
          child: Center(child: Image.asset(path, fit: BoxFit.cover)),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
