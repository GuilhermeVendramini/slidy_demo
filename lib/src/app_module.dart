import 'package:hasura_connect/hasura_connect.dart';
//import 'package:slidy_demo/src/repositories/firebase/firebase_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:slidy_demo/src/app_widget.dart';
import 'package:slidy_demo/src/app_bloc.dart';

import 'repositories/hasura/message/hasura_message_repository.dart';
import 'repositories/hasura/user/hasura_user_repository.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => HasuraConnect("https://flutter-hasura-demo.herokuapp.com/v1/graphql")),
        //Dependency((i) => FirebaseRepository()),
        Dependency((i) => HasuraUserRepository(i.get<HasuraConnect>())),
        Dependency((i) => HasuraMessageRepository(i.get<HasuraConnect>())),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
