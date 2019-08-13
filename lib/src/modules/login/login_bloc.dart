import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../../repositories/hasura/user/hasura_user_repository.dart';

import '../../app_bloc.dart';
import '../../app_module.dart';

class LoginBloc extends BlocBase {
  final HasuraUserRepository repository;
  final appBloc = AppModule.to.bloc<AppBloc>();

  LoginBloc(this.repository);

  TextEditingController controller = TextEditingController();

  Future<bool> login() async {
    try {
      var user = await repository.getUser(controller.text);
      appBloc.userController.add(user);
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
