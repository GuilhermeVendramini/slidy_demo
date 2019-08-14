import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../app_bloc.dart';
import '../../app_module.dart';
import '../../repositories/hasura/user/hasura_user_repository.dart';
import '../../shared/models/user/user_model.dart';
import 'login_validators.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators {
  final HasuraUserRepository _userRepository;

  LoginBloc(this._userRepository);

  final _appBloc = AppModule.to.bloc<AppBloc>();
  final _nameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  String message;

  Stream<String> get streamName =>
      _nameController.stream.transform(validateName);

  Stream<String> get streamPassword =>
      _passwordController.stream.transform(validatePassword);

  Stream<LoginState> get streamState => _stateController.stream;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(streamName, streamPassword, (a, b) => true);

  Function(String) get changeName => _nameController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Future<bool> login() async {
    try {
      _stateController.add(LoginState.LOADING);
      UserModel user = await _userRepository.getUser(
        name: _nameController.value,
        password: _passwordController.value,
      );

      if (user == null) {
        message = 'Invalid name or password';
        _stateController.add(LoginState.FAIL);
        return false;
      }

      _appBloc.userController.add(user);
      _stateController.add(LoginState.SUCCESS);
      return true;
    } catch (ex) {
      message = 'Internal error. Please, try later';
      _stateController.add(LoginState.FAIL);
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
