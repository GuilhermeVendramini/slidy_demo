import 'package:flutter/material.dart';

import '../../shared/widgets/stream_input_field.dart';
import 'login_bloc.dart';
import 'login_module.dart';
import 'widgets/login_button.dart';
import 'widgets/register_button.dart';

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
      body: StreamBuilder<LoginState>(
        stream: _bloc.streamState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == LoginState.LOADING
                  ? CircularProgressIndicator()
                  : SizedBox(height: 35.0),
              StreamInputField(
                hint: "Name",
                obscure: false,
                stream: _bloc.streamName,
                onChanged: _bloc.changeName,
              ),
              StreamInputField(
                hint: "Password",
                obscure: true,
                stream: _bloc.streamPassword,
                onChanged: _bloc.changePassword,
              ),
              LoginButton(),
              RegisterButton(),
            ],
          );
        },
      ),
    );
  }
}
