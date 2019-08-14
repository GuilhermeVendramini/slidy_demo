import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../app_bloc.dart';
import '../../repositories/hasura/message/hasura_message_repository.dart';
import '../../shared/models/message/message_model.dart';
import 'home_validators.dart';

class HomeBloc extends BlocBase with HomeValidators {
  final HasuraMessageRepository _messageRepository;
  final AppBloc _appBloc;
  BehaviorSubject<String> _messageController = BehaviorSubject<String>();

  Stream<String> get streamMessage =>
      _messageController.stream.transform(validateMessage);

  BehaviorSubject<List<MessageModel>> messagesController =
      BehaviorSubject<List<MessageModel>>();

  Function(String) get changeMessage {
    return _messageController.sink.add;
  }

  HomeBloc(this._messageRepository, this._appBloc) {
    Observable(_messageRepository.getMessages()).pipe(messagesController);
  }

  void sendMessage() {
    if (_messageController.value != null) {
      _messageRepository.sendMessage(
        message: _messageController.value,
        userId: _appBloc.userController.value.id,
      );
    }
  }

  @override
  void dispose() {
    _messageController.close();
    messagesController.close();
    super.dispose();
  }
}
