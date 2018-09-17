import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_login_app/models/login_detail.dart';
import 'package:flutter_bloc_login_app/models/user.dart';
import 'package:flutter_bloc_login_app/pages/home_page.dart';
import 'package:flutter_bloc_login_app/services/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  AuthService authService;
  BuildContext _context;

  final currentUserSubject = BehaviorSubject<User>(seedValue: null);
  final emailSubject = BehaviorSubject<String>(seedValue: '');
  final passwordSubject = BehaviorSubject<String>(seedValue: '');
  final loadingSubject = BehaviorSubject<bool>(seedValue: false);
  final loginSubject = BehaviorSubject<Null>(seedValue: null);

  //sink
  void Function(String) get emailChanged => emailSubject.sink.add;
  void Function(String) get passwordChanged => passwordSubject.sink.add;
  void Function(BuildContext) get submitLogin => (context) {
    this.setContext(context);
    loginSubject.add(null);
  };

  //stream
  Stream<User> get currentUser => currentUserSubject.stream;
  Stream<String> get emailStream => emailSubject.stream;
  Stream<String> get passwordStream => passwordSubject.stream;
  Stream<bool> get loading => loadingSubject.stream;

  AuthBloc({this.authService}) {
    Stream<LoginDetail> loginDetailStream = Observable.combineLatest2(
        emailStream, passwordStream, (email, password) {
      return LoginDetail(email: email, password: password);
    });
    Stream<User> loggedIn = Observable(loginSubject.stream)
        .withLatestFrom(loginDetailStream, (_, loginDetail) {
      return loginDetail;
    }).flatMap((loginDetail) {
      return Observable.fromFuture(authService.loginUser(loginDetail)).doOnListen((){
          loadingSubject.add(true);
      }).doOnDone((){
        loadingSubject.add(false);
      });
    });

    loggedIn.listen((User user) {
      currentUserSubject.add(user);
      Navigator.push(
        _context,
        new MaterialPageRoute(builder: (context) => HomePage()),
      );
    }, onError: (error) {
      Scaffold.of(_context).showSnackBar(new SnackBar(
        content: new Text("Username or password incorrect"),
      ));
    });
  }

    setContext(BuildContext context){
      _context = context;
    }

  close() {
    emailSubject.close();
    passwordSubject.close();
    loadingSubject.close();
    loginSubject.close();
  }
}
