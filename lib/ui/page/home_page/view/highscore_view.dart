import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:times/model/highscore_with_user_name.dart';
import 'package:times/repository/highscore_repository.dart';
import 'package:times/theme/times_text.dart';

/// View for the home page to display highscores.
class HighscoreView extends StatefulWidget {
  const HighscoreView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HighscoreViewState();
}

class _HighscoreViewState extends State<HighscoreView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Use the future builder to display a loading animation while the highscore
    // data is being loaded from the data base.
    return FutureBuilder<List<HighscoreWithUserName>>(
        future: HighscoreRepository.findAllWithUserNamesOrderByScore(),
        builder: (BuildContext context,
            AsyncSnapshot<List<HighscoreWithUserName>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return _buildNoHighscoresFound();
            }

            return _buildHighscoreList(snapshot.data!);
          } else if (snapshot.hasError) {
            // Display error.
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text(snapshot.error.toString())],
              ),
            );
          } else {
            // Display loading indicator.
            return Center(
                child: SizedBox(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    child: const LoadingIndicator(
                        indicatorType: Indicator.circleStrokeSpin)));
          }
        });
  }

  Widget _buildNoHighscoresFound() {
    return Center(
        child: Text('Es gibt noch eine Highscores!',
            style: TimesText.sansRegular20));
  }

  Widget _buildHighscoreList(List<HighscoreWithUserName> highscores) {
    final highestScore = highscores.first;
    highscores.removeAt(0);
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // page header
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(highestScore.userName ?? 'unbekannt',
                        style: TimesText.sansRegular20),
                    Text(highestScore.score?.toString() ?? '0',
                        style: TimesText.sansLight64)
                  ],
                )),
            Expanded(child: ListView(children: _getListItems(highscores)))
          ],
        ));
  }

  List<Widget> _getListItems(List<HighscoreWithUserName>? highscores) {
    final List<Widget> widgets = [];

    if (highscores == null) {
      return widgets;
    }

    for (var highscore in highscores) {
      widgets.add(Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
              leading: Text(highscore.score.toString(),
                  style: TimesText.sansRegular48),
              title: Text(highscore.userName ?? 'unknown',
                  style: TimesText.sansRegular20))));
    }

    return widgets;
  }
}
