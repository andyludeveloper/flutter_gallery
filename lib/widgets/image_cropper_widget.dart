import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'image_preview.dart';

class ImageCropperWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const ImageCropperWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cropImage(imageUrl, width, height),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Hero(
            tag: imageUrl,
            child: Material(
              color:Colors.transparent,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    width: width,
                    height: height,
                    child: Image.asset(imageUrl, fit: BoxFit.cover),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePreview(path: imageUrl)),
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<Uint8List> _cropImage(
      String imageUrl, double cropWidth, double cropHeight) async {
    img.Image image = img
        .decodeImage(Uint8List.fromList(await loadImageAsUint8List(imageUrl)))!;
    img.Image croppedImage = img.copyCrop(
      image,
      x: 0,
      y: 0,
      height: cropWidth * image.width ~/ image.height,
      width: cropHeight * image.height ~/ image.width,
    );
    return Uint8List.fromList(img.encodeJpg(croppedImage));
  }

  Future<Uint8List> loadImageAsUint8List(String imagePath) async {
    ByteData data = await rootBundle.load(imagePath);
    List<int> bytes = data.buffer.asUint8List();
    return Uint8List.fromList(bytes);
  }
}
