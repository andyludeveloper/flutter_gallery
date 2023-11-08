import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';

import '../provider/captured_image_provider.dart';
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
          return Stack(children: [
            Center(
              child: Hero(
                tag: imageUrl,
                child: Material(
                  color: Colors.transparent,
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
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: ClipOval(
                child: Material(
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                        customBorder: const CircleBorder(),
                        child: const Padding(
                            padding: EdgeInsets.all(2),
                            child:
                                Icon(Icons.close, color: Colors.red, size: 20)),
                        onTap: () {
                          context
                              .read<CapturedImageProvider>()
                              .removeImage(imageUrl);
                        }),
                  ),
                ),
              ),
            ),
          ]);
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
