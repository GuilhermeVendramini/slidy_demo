import 'package:flutter/material.dart';

import '../../shared/widgets/stream_input_field.dart';
import 'login_bloc.dart';
import 'login_module.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginModule.to.bloc<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamInputField(
            hint: "Name",
            obscure: false,
            stream: _bloc.streamName,
            onChanged: _bloc.changeName,
          ),
          StreamInputField(
            hint: "Password",
            obscure: false,
            stream: _bloc.streamPassword,
            onChanged: _bloc.changePassword,
          ),
          _LoginButton(),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
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
