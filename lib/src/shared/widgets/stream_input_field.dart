import 'package:flutter/material.dart';

class StreamInputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  StreamInputField({this.hint, this.obscure, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              errorText: snapshot.hasError ? snapshot.error : null,
            ),
            obscureText: obscure,
          );
        });
  }
}
