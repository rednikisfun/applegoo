import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  List _answers = [];
  String _userName = '';

  get answers => _answers;
  get userName => _userName;

  addToAnswers(answer) {
    _answers.add(answer);
    notifyListeners();
  }

  setName(name) {
    _userName = name;
    notifyListeners();
  }
}
