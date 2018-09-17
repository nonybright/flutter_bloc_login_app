import 'package:flutter/material.dart';
import 'package:flutter_bloc_login_app/blocs/bloc_provider.dart';
import 'package:flutter_bloc_login_app/models/user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About User'),
      ),
      body: StreamBuilder<User>(
        initialData: null,
        stream: BlocProvider.of(context).authBloc.currentUser,
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return Column(
              children: <Widget>[
                Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: new ExactAssetImage('assets/images/'+userSnapshot.data.profilePic),
                      fit: BoxFit.cover,
                    ))),
                _createUserDetailRow('name', userSnapshot.data.name),
                _createUserDetailRow('email', userSnapshot.data.email),
                _createUserDetailRow('age', userSnapshot.data.age.toString()),
              ],
            );
          } else {
            return Center(
              child: Text('There is no user to view'),
            );
          }
        },
      ),
    );
  }

  _createUserDetailRow(detail, content) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 50.0,
                child: Text(detail),
              ),
              SizedBox(
                width: 30.0,
              ),
              Text(
                content,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
