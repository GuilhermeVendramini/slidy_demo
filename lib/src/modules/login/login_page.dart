import 'package:flutter/material.dart';

import 'login_bloc.dart';
import 'login_module.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = LoginModule.to.bloc<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
              stream: bloc.streamName,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changeName,
                  decoration: InputDecoration(
                    labelText: "Name",
                    errorText: snapshot.hasError ? snapshot.error : null,
                  ),
                );
              },
            ),
            StreamBuilder<String>(
              stream: bloc.streamPassword,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: bloc.changePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: snapshot.hasError ? snapshot.error : null,
                  ),
                );
              },
            ),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final bloc = LoginModule.to.bloc<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    void _submit() async {
      final bloc = LoginModule.to.bloc<LoginBloc>();
      bool result = await bloc.login();
      if (!result) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(bloc.message),
          duration: Duration(seconds: 3),
        ));
      }
    }

    return StreamBuilder<bool>(
        stream: bloc.outSubmitValid,
        builder: (context, snapshot) {
          return SizedBox(
            height: 50,
            child: RaisedButton(
              child: Text("Login"),
              onPressed: snapshot.hasData ? _submit : null,
            ),
          );
        });
  }
}
