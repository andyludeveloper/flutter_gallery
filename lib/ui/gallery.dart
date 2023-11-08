import 'package:flutter/material.dart';
import 'package:gallery/widgets/square.dart';

import '../widgets/image_cropper_widget.dart';

const snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
);

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 4;
    final height = width;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text("123"),
        ),
        body: Stack(
          children: [
            GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.0),
              children: [
                ImageCropperWidget(
                  width: width,
                  height: height,
                  imageUrl: 'assets/images/image1.jpeg',
                ),
                ImageCropperWidget(
                  width: width,
                  height: height,
                  imageUrl: 'assets/images/image2.png',
                ),
                ImageCropperWidget(
                  width: width,
                  height: height,
                  imageUrl: 'assets/images/image3.jpeg',
                ),
                Square(width: width, height: height),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text("OK"),
                ),
              ),
            )
          ],
        ));
  }
}
