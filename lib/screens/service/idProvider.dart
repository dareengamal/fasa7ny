import 'package:flutter/material.dart';

class IdProvider with ChangeNotifier {
  String value = '';
  String get uid => value;
  set sharedValue(String v) {
    value = v;
    notifyListeners();
  }
}