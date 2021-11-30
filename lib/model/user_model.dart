import 'package:flutter/material.dart';
import 'package:times/model/user.dart';

class UserModel extends ChangeNotifier {
  User? _user;

  User? get user {
    return _user;
  }

  set user(User? user) {
    _user = user;
    notifyListeners();
  }
}
