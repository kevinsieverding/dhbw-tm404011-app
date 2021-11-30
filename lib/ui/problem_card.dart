import 'package:flutter/material.dart';
import 'package:times/model/problem.dart';
import 'package:times/theme/times_text.dart';

class ProblemCard extends Card {
  final Problem problem;

  const ProblemCard(this.problem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
                child:
                    Text(problem.toString(), style: TimesText.sansRegular20))));
  }
}
