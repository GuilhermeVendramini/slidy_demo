import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../app_bloc.dart';
import '../../app_module.dart';
import '../../repositories/hasura/user/hasura_user_repository.dart';
import '../../shared/models/user/user_model.dart';
import 'register_validators.dart';

class RegisterBloc extends BlocBase with RegisterValidators {
  final HasuraUserRepository _userRepository;
  final _appBloc = AppModule.to.bloc<AppBloc>();

  RegisterBloc(this._userRepository);

  final _nameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  String message;

  Stream<String> get streamName =>
      _nameController.stream.transform(validateName);

  Stream<String> get streamPassword =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(streamName, streamPassword, (a, b) => true);

  Function(String) get changeName => _nameController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Future<bool> register() async {
    try {
      UserModel user = await _userRepository.getUser(
        name: _nameController.value,
      );

      if (user != null) {
        message = 'User name already exists';
        return false;
      }

      user = await _userRepository.createUser(
        name: _nameController.value,
        password: _passwordController.value,
      );

      _appBloc.userController.add(user);
      return true;
    } catch (ex) {
      message = 'Internal error. Please, try later';
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.close();
    _passwordController.close();
    super.dispose();
  }
}
