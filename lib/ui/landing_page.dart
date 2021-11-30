import 'package:flutter/material.dart';
import 'package:times/theme/times_color.dart';
import 'package:times/theme/times_text.dart';
import 'package:times/ui/component/form/name_form.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                color: TimesColor.orange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Willkommen!',
                        style:
                            TimesText.sansBold64.copyWith(color: Colors.white)),
                    const NameForm()
                  ],
                ))));
  }
}
