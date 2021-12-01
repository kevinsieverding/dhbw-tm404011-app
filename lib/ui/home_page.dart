import 'package:flutter/material.dart';
import 'package:times/theme/times_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text('Letzter Highscore', style: TimesText.sansLight48),
              ),
              Center(
                child: Text('0', style: TimesText.sansLight48),
              )
            ]),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/game');
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 64)),
                child: Text('Spielen!',
                    style: TimesText.sansBold64.copyWith(color: Colors.white))))
      ]),
    ));
  }
}
