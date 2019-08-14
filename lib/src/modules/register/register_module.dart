import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:slidy_demo/src/modules/register/register_bloc.dart';
import 'package:slidy_demo/src/modules/register/register_page.dart';

import '../../app_module.dart';
import '../../repositories/hasura/user/hasura_user_repository.dart';

class RegisterModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => RegisterBloc(AppModule.to.get<HasuraUserRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RegisterPage();

  static Inject get to => Inject<RegisterModule>.of();
}
