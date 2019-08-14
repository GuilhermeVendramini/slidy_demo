import 'package:flutter/material.dart';

class StreamInputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextEditingController controller;

  StreamInputField(
      {this.hint, this.obscure, this.stream, this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        initialData: '',
        builder: (context, snapshot) {
          return TextField(
            controller: controller,
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
