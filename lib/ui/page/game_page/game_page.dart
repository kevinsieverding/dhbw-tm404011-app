import 'dart:math';

import 'package:flutter/material.dart';
import 'package:times/model/problem.dart';
import 'package:times/theme/times_color.dart';
import 'package:times/theme/times_text.dart';
import 'package:times/ui/component/swipeable_card_deck.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
                            setState(() {
                              _highScore +=
                                  pc.problem.operand1 * pc.problem.operand2;
                            });
                          } else {
                            if (_lives > 1) {
                              setState(() {
                                _lives--;
                              });
                            } else {
                              Navigator.of(context)
                                  .pushReplacementNamed('/game_over');
                            }
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
