import 'dart:async';

import 'package:flutter_bloc_login_app/models/error.dart';
import 'package:flutter_bloc_login_app/models/login_detail.dart';
import 'package:flutter_bloc_login_app/models/user.dart';

class AuthService {
  Future<User> loginUser(LoginDetail detail) async {
    await Future.delayed(Duration(seconds: 1)); //simulate network delay
    if (detail.email == 'johndoe@acme.com' && detail.password == '1234') {
      return User(
          id: 1,
          name: 'John Doe',
          email: 'johndoe@acme.com',
          age: 26,
          profilePic: 'john_doe.png');
    } else {
      throw MyError(message: 'login details incorrect.');
    }
  }
}
