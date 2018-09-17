import 'package:flutter/material.dart';
import 'package:flutter_bloc_login_app/blocs/bloc_provider.dart';
import 'package:flutter_bloc_login_app/pages/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
    ));
  }
}