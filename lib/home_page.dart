import 'package:flutter/material.dart';
import 'package:times/high_score.dart';
import 'package:times/theme/times_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const HighScore(score: 100),
          Expanded(
              child:
                  Center(child: Text('CARDS', style: TimesText.sansRegular20)))
        ],
      ),
      color: Theme.of(context).canvasColor,
    );
  }
}
