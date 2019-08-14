import 'package:flutter/material.dart';

import '../login_bloc.dart';
import '../login_module.dart';

class LoginButton extends StatelessWidget {
  final _bloc = LoginModule.to.bloc<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    void _submit() async {
      final bloc = LoginModule.to.bloc<LoginBloc>();
      bool result = await bloc.login();
      if (!result) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(bloc.message),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    return StreamBuilder<bool>(
      stream: _bloc.outSubmitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text("Login"),
          onPressed: snapshot.hasData ? _submit : null,
        );
      },
    );
  }
}