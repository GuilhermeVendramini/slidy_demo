import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:slidy_demo/src/repositories/hasura/message/hasura_message_repository.dart';

import '../../app_bloc.dart';
import '../../app_module.dart';
import 'home_bloc.dart';
import 'home_page.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(
              AppModule.to.get<HasuraMessageRepository>(),
              AppModule.to.bloc<AppBloc>(),
            )),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
