import 'package:flutter/material.dart';
import 'package:flutter_bloc_login_app/blocs/auth_bloc.dart';
import 'package:flutter_bloc_login_app/blocs/bloc_provider.dart';
import 'package:flutter_bloc_login_app/helpers/validators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Validator validator = new Validator();
  final formKey = GlobalKey<FormState>();
  DecorationImage backgroundImage = new DecorationImage(
    image: new ExactAssetImage('assets/images/bg_image.jpg'),
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = BlocProvider.of(context).authBloc;
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Container(
              height: screenSize.height - AppBar().preferredSize.height,
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(image: backgroundImage),
              child: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: 'email',
                            labelStyle: TextStyle(color: Colors.grey)),
                        validator: validator.validateEmail,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'password',
                            labelStyle: TextStyle(color: Colors.grey)),
                        obscureText: true,
                        validator: validator.validatePassword,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      StreamBuilder<bool>(
                        initialData: false,
                        stream: authBloc.loading,
                        builder: (context, loadingSnapshot) {
                          return SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.deepOrange,
                              textColor: Colors.white,
                              child: Text((loadingSnapshot.data)
                                  ? 'Login ...'
                                  : 'Login'),
                              onPressed: () {
                                _submit(context, authBloc);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  _submit(context, AuthBloc authBloc) {
    authBloc.emailChanged(emailController.text);
    authBloc.passwordChanged(passwordController.text);

    if (formKey.currentState.validate()) {
      authBloc.submitLogin(context);
    }
  }
}
