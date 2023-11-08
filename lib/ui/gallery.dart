import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/captured_image_provider.dart';
import '../widgets/image_gallery_builder.dart';

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
          body: Stack(
            children: [
              ImageGalleryBuilder(width: width, height: height),
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
            ],
          )),
    );
  }
}
