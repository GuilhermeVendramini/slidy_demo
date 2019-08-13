import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:slidy_demo/src/repositories/hasura/user/hasura_user_repository.dart';

import '../../app_module.dart';
import 'login_bloc.dart';
import 'login_page.dart';

class LoginModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => LoginBloc(AppModule.to.get<HasuraUserRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginPage();

  static Inject get to => Inject<LoginModule>.of();
}
