import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:times/model/user_model.dart';
import 'package:times/repository/user_repository.dart';
import 'package:times/theme/times_color.dart';
import 'package:times/theme/times_text.dart';

/// A basic splash page to show on startup while data is being loaded.
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context, listen: false);

    if (userModel.user == null) {
      UserRepository.findAll().then((users) {
        if (users.isNotEmpty) {
          userModel.user = users.first;
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          Navigator.of(context).pushReplacementNamed('/landing');
        }
      });
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: TimesColor.orange,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('1 x 1',
                    style: TimesText.sansBold64.copyWith(color: Colors.white)),
                SizedBox(
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                    child: const LoadingIndicator(
                      indicatorType: Indicator.circleStrokeSpin,
                      colors: [Colors.white],
                    ))
              ],
            ))));
  }
}
