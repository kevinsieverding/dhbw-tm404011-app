import 'package:flutter/material.dart';

class HighscoreModel extends ChangeNotifier {
  int _highscore = 0;

  int get highscore {
    return _highscore;
  }

  set highscore(int highscore) {
    _highscore = highscore;
    notifyListeners();
  }
}
