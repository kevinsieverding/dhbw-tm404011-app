import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:times/model/problem.dart';
import 'package:times/theme/times_color.dart';
import 'package:times/theme/times_text.dart';
import 'package:times/ui/problem_card.dart';
import 'package:times/ui/swipeable_card_deck.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const maxLives = 3;
  Random random = Random();
  int _highScore = 0;
  int _lives = maxLives;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Row(
                        children: getLiveIcons(),
                        mainAxisSize: MainAxisSize.min,
                      ))),
              Align(
                  child: Text(
                '$_highScore',
                maxLines: 1,
                style: TimesText.sansLight64,
              )),
            ],
          ),
          Expanded(
              child: Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: SwipeableCardDeck(
                        cardBuilder: () => ProblemCard(getProblem()),
                        swipeHandler: (direction, card) {
                          ProblemCard pc = card as ProblemCard;
                          if (direction == AxisDirection.right &&
                                  pc.problem.isValid() ||
                              direction == AxisDirection.left &&
                                  !pc.problem.isValid()) {
                            correctAnswer(pc.problem);
                          } else {
                            wrongAnswer(pc.problem);
                          }
                        },
                      ))))
        ],
      ),
      color: Theme.of(context).canvasColor,
    ));
  }

  Problem getProblem() {
    int a = random.nextInt(11 - 1) + 1;
    int b = random.nextInt(11 - 1) + 1;
    if (random.nextBool()) {
      return Problem(a, b);
    } else {
      return Problem.withResult(
          a, b, a * b + (random.nextInt(1 + a * b * 2) - a * b));
    }
  }

  void wrongAnswer(Problem problem) {
    setState(() {
      if (_lives > 0) {
        _lives--;
      } else {
        dev.log('YOU LOST!');
      }
    });
  }

  void correctAnswer(Problem problem) {
    setState(() {
      _highScore += problem.operand1 * problem.operand2;
    });
  }

  List<Icon> getLiveIcons() {
    List<Icon> icons = [];
    for (int i = 0; i < _lives; i++) {
      icons.add(TimesIcons.fullHeart);
    }
    for (int i = 0; i < maxLives - _lives; i++) {
      icons.add(TimesIcons.emptyHeart);
    }
    return icons;
  }
}

class TimesIcons {
  static const Icon fullHeart = Icon(
    Icons.favorite,
    color: TimesColor.orange,
    size: 24,
  );
  static const Icon emptyHeart =
      Icon(Icons.favorite_border, color: TimesColor.orange, size: 24);
}
