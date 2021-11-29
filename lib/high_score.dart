import 'package:flutter/material.dart';
import 'package:times/theme/times_text.dart';

class HighScore extends StatefulWidget {
  const HighScore({Key? key}) : super(key: key);

  @override
  _HighScoreState createState() => _HighScoreState();
}

class _HighScoreState extends State<HighScore> {
  int _score = 0;

  int addToScore(int value) {
    if (value < 0) {
      return _score;
    }
    setState(() {
      _score += value;
    });
    return _score;
  }

  int getScore() {
    return _score;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      '$_score',
      maxLines: 1,
      style: TimesText.sansLight64,
    ));
  }
}
