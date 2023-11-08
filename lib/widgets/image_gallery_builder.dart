import 'package:flutter/material.dart';
import 'package:gallery/widgets/square.dart';
import 'package:provider/provider.dart';

import '../provider/captured_image_provider.dart';
import 'image_cropper_widget.dart';

class ImageGalleryBuilder extends StatelessWidget {
  final double width;
  final double height;

  const ImageGalleryBuilder(
      {Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CapturedImageProvider>(
        builder: (BuildContext context, provider, Widget? child) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.0),
        itemCount: provider.images.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < provider.images.length) {
            return ImageCropperWidget(
              width: width,
              height: height,
              imageUrl: provider.images[index],
            );
          } else {
            if (provider.images.length < 10) {
              return Square(width: width, height: height);
            } else {
              return Container();
            }
          }
        },
      );
    });
  }
}
