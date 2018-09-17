import 'package:flutter/material.dart';
import 'package:flutter_bloc_login_app/blocs/auth_bloc.dart';
import 'package:flutter_bloc_login_app/services/auth_service.dart';

class BlocProvider extends InheritedWidget {
  final blocState = new BlocState(
    authBloc: AuthBloc(authService: AuthService()),
  );

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static BlocState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .blocState;
  }
}

class BlocState {
  final AuthBloc authBloc;

  BlocState({this.authBloc});
}
