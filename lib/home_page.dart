import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:times/theme/times_text.dart';
import 'package:times/ui/swipeable_card_deck.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _highScore = 0;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
              child: Text(
            '$_highScore',
            maxLines: 1,
            style: TimesText.sansLight64,
          )),
          Expanded(
              child: Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: SwipeableCardDeck(
                        cardBuilder: () {
                          var card = Card(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Center(
                                    child: Text('Card #$_index',
                                        style: TimesText.sansRegular20))),
                          );
                          _index++;
                          return card;
                        },
                        swipeHandler: (direction, card) {
                          log('card swiped: $direction');
                          if (direction == AxisDirection.left) {
                            setState(() {
                              _highScore -= 10;
                            });
                          } else if (direction == AxisDirection.right) {
                            setState(() {
                              _highScore += 10;
                            });
                          }
                        },
                      ))))
        ],
      ),
      color: Theme.of(context).canvasColor,
    );
  }
}
