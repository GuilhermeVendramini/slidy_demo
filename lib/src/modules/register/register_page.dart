import 'package:flutter/material.dart';

import '../../shared/widgets/stream_input_field.dart';
import 'register_bloc.dart';
import 'register_module.dart';
import 'widgets/register_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _bloc = RegisterModule.to.bloc<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: StreamBuilder<RegisterState>(
        stream: _bloc.streamState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == RegisterState.LOADING
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
              RegisterButton(),
            ],
          );
        },
      ),
    );
  }
}
