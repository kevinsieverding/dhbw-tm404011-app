import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:times/model/highscore_with_user_name.dart';
import 'package:times/repository/highscore_repository.dart';
import 'package:times/theme/times_text.dart';

class HighscoreView extends StatefulWidget {
  const HighscoreView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HighscoreViewState();
}

class _HighscoreViewState extends State<HighscoreView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Center(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: FutureBuilder<List<HighscoreWithUserName>>(
                    future:
                        HighscoreRepository.findAllWithUserNamesOrderByScore(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<HighscoreWithUserName>> snapshot) {
                      if (snapshot.hasData) {
                        final highestScore = snapshot.data?.first;
                        return Column(
                          children: [
                            Text(highestScore?.userName ?? 'unbekannt'),
                            Text(highestScore?.score?.toString() ?? '0',
                                style: TimesText.sansLight64)
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Text(snapshot.error.toString())],
                          ),
                        );
                      } else {
                        return Center(
                            child: SizedBox(
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                child: const LoadingIndicator(
                                    indicatorType:
                                        Indicator.circleStrokeSpin)));
                      }
                    })))
      ],
    );
  }
}
