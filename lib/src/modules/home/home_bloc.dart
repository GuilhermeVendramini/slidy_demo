import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import '../../models/message/message_model.dart';
import '../../repositories/hasura/message/hasura_message_repository.dart';

import '../../app_bloc.dart';

class HomeBloc extends BlocBase {
  final HasuraMessageRepository _messageRepository;
  final AppBloc _appBloc;

  BehaviorSubject<List<MessageModel>> messagesController = BehaviorSubject<List<MessageModel>>();
  TextEditingController messageTextEditingController = TextEditingController();

  HomeBloc(this._messageRepository, this._appBloc) {
    Observable(_messageRepository.getMessages()).pipe(messagesController);
  }

  void sendMessage() {
    _messageRepository.sendMessage(
      messageTextEditingController.text,
      _appBloc.userController.value.id,
    );
    messageTextEditingController.clear();
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    messageTextEditingController.dispose();
    messagesController.close();
    super.dispose();
  }
}
