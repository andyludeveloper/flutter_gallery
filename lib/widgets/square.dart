import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final double width;
  final double height;

  const Square({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //draw a square with + in the center and width and height as passed in
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: width,
          height: height,
          // color: Colors.grey,
          decoration: BoxDecoration(
            color:Colors.grey,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: const Icon(Icons.add, color: Colors.black)),
    );
  }
}
