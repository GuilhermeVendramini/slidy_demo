import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../app_bloc.dart';
import '../../app_module.dart';
import '../../repositories/hasura/user/hasura_user_repository.dart';
import '../../shared/models/user/user_model.dart';
import 'register_validators.dart';

enum RegisterState { IDLE, LOADING, SUCCESS, FAIL }

class RegisterBloc extends BlocBase with RegisterValidators {
  final HasuraUserRepository _userRepository;

  RegisterBloc(this._userRepository);

  final _appBloc = AppModule.to.bloc<AppBloc>();
  final _nameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<RegisterState>();

  String message;

  Stream<String> get streamName =>
      _nameController.stream.transform(validateName);

  Stream<String> get streamPassword =>
      _passwordController.stream.transform(validatePassword);

  Stream<RegisterState> get streamState => _stateController.stream;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(streamName, streamPassword, (a, b) => true);

  Function(String) get changeName => _nameController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Future<bool> register() async {
    try {
      _stateController.add(RegisterState.LOADING);
      UserModel user = await _userRepository.getUser(
        name: _nameController.value,
      );

      if (user != null) {
        _stateController.add(RegisterState.FAIL);
        message = 'User name already exists';
        return false;
      }

      user = await _userRepository.createUser(
        name: _nameController.value,
        password: _passwordController.value,
      );

      _appBloc.userController.add(user);
      _stateController.add(RegisterState.SUCCESS);
      return true;
    } catch (ex) {
      _stateController.add(RegisterState.FAIL);
      message = 'Internal error. Please, try later';
      return false;
    }
  }

  @override
  void dispose() {
    _nameController.close();
    _passwordController.close();
    _stateController.close();
    super.dispose();
  }
}
