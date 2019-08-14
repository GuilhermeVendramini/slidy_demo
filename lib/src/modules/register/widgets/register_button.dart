import 'package:flutter/material.dart';

import '../register_bloc.dart';
import '../register_module.dart';

class RegisterButton extends StatelessWidget {
  final _bloc = RegisterModule.to.bloc<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    void _submit() async {
      final bloc = RegisterModule.to.bloc<RegisterBloc>();
      bool result = await bloc.register();
      if (!result) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(bloc.message),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Navigator.pop(context);
      }
    }

    return StreamBuilder<bool>(
      stream: _bloc.outSubmitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text("Register"),
          onPressed: snapshot.hasData ? _submit : null,
        );
      },
    );
  }
}
