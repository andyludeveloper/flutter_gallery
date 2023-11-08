import 'package:flutter/cupertino.dart';

class CapturedImageProvider extends ChangeNotifier {
  //singleton
  static CapturedImageProvider? _instance;
  //use of to get it
  static CapturedImageProvider of() {
    _instance ??= CapturedImageProvider();
    return _instance!;
  }

  List<String> _images = [
    'assets/images/image1.jpeg',
    'assets/images/image2.png',
    'assets/images/image3.jpeg'
  ];

  List<String> get images => _images;

  void addImage(String image) {
    _images.add(image);
    notifyListeners();
  }
}
