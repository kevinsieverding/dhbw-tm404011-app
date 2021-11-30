import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times/model/user_model.dart';
import 'package:times/repository/user_repository.dart';
import 'package:times/theme/times_color.dart';
import 'package:times/theme/times_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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

    return SafeArea(
        child: Scaffold(
            backgroundColor: TimesColor.orange,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('1 x 1',
                    style: TimesText.sansBold64.copyWith(color: Colors.white))
              ],
            ))));
  }
}
