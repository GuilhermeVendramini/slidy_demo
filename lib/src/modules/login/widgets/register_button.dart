import 'package:flutter/material.dart';

import '../../register/register_module.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Register"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterModule()),
        );
      },
    );
  }
}
