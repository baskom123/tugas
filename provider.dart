import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class MyBioModel extends ChangeNotifier {
  String? _imagePath;
  double _score = 0;

  String? get imagePath => _imagePath;
  double get score => _score;

  final ImagePicker _picker = ImagePicker();

  Future<void> setImage(XFile? image) async {
    if (image != null) {
      _imagePath = image.path;
      notifyListeners();
    }
  }

  Future<void> setScore(double value) async {
    _score = value;
    notifyListeners();
  }

  Future<void> pickImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setImage(image);
  }
}
