import 'package:flutter/material.dart';
import 'package:gallery/widgets/square.dart';
import 'package:provider/provider.dart';

import '../provider/captured_image_provider.dart';
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
    return ChangeNotifierProvider(
      create: (BuildContext context) => CapturedImageProvider(),
      lazy: false,
      child: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: const Text("Gallery"),
          ),
          body: Consumer<CapturedImageProvider>(
            builder: (BuildContext context, provider, Widget? child) {
              debugPrint("provider.images.length: ${provider.images.length}");
              return Stack(children: [
                GridView.builder(
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
                      return Square(width: width, height: height);
                    }
                  },
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
                    ))
              ]);
            },
          )),
    );
  }
}
