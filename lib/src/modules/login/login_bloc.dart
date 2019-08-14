import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../app_bloc.dart';
import '../../app_module.dart';
import '../../repositories/hasura/user/hasura_user_repository.dart';

class LoginBloc extends BlocBase {
  final HasuraUserRepository _userRepository;
  final _appBloc = AppModule.to.bloc<AppBloc>();

  LoginBloc(this._userRepository);

  TextEditingController nameTextEditingController = TextEditingController();

  Future<bool> login() async {
    try {
      var user = await _userRepository.getUser(nameTextEditingController.text);
      _appBloc.userController.add(user);
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    nameTextEditingController.dispose();
    super.dispose();
  }
}
