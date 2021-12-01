import 'package:flutter/material.dart';
import 'package:times/theme/times_color.dart';
import 'package:times/theme/times_text.dart';

class GameOverPage extends StatelessWidget {
  const GameOverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: TimesColor.orange,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'GAME OVER',
                  style: TimesText.sansBold64.copyWith(color: Colors.white),
                ),
                Column(children: [
                  Text('Highscore',
                      style: TimesText.sansRegular48
                          .copyWith(color: Colors.white)),
                  Text('0',
                      style:
                          TimesText.sansRegular64.copyWith(color: Colors.white))
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/home');
                          },
                          child: Text('Zurück', style: TimesText.sansRegular20),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32))),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/game');
                          },
                          child:
                              Text('Nochmal', style: TimesText.sansRegular20),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 32)))
                    ])
              ],
            ))));
  }
}
