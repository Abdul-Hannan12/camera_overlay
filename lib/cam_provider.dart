import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';

class CamProvider with ChangeNotifier {
  XFile? _imgFile;

  XFile? get imgFile => _imgFile;

  set imgFile(XFile? file) {
    _imgFile = file;
    notifyListeners();
  }
}
