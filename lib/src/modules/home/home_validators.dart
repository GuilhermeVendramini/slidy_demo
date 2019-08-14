import 'dart:async';

class HomeValidators {
  final validateMessage = StreamTransformer<String, String>.fromHandlers(
      handleData: (message, sink) {
    if (message.isNotEmpty) {
      sink.add(message);
    }
  });
}
