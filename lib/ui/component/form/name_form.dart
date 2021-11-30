import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times/model/user.dart';
import 'package:times/model/user_model.dart';
import 'package:times/repository/user_repository.dart';
import 'package:times/theme/times_text.dart';

class NameForm extends StatefulWidget {
  const NameForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                      maxLines: 1,
                      style: TimesText.sansRegular20,
                      decoration: const InputDecoration(
                        hintText: 'Gebe bitte deinen Namen ein.',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Gebe bitte deinen Namen ein.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          final user = User();
                          user.name = value;
                          UserRepository.insert(user).then((id) {
                            user.id = id;
                            Provider.of<UserModel>(context, listen: false)
                                .user = user;
                            Navigator.of(context).pushReplacementNamed('/home');
                          });
                        }
                      },
                    ))
              ],
            )));
  }
}
