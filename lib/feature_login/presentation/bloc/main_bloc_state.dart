import 'package:equatable/equatable.dart';
import 'package:poliglot/feature_auth/domain/entities/authUser_parser.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginUnloginState extends LoginState {

}


class LoginSuccessState extends LoginState {

}


class LoginProgressState extends LoginState {

}

class LoginErrorState extends LoginState {
 final String error;
 const LoginErrorState(this.error);
}

class IsAuthorizedState extends LoginState {

}
