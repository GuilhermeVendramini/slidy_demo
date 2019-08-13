import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';

import 'models/user/user_model.dart';

class AppBloc extends BlocBase {
  BehaviorSubject<UserModel> userController = BehaviorSubject<UserModel>();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    userController.close();
    super.dispose();
  }
}
