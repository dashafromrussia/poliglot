import 'package:equatable/equatable.dart';
import 'package:poliglot/feature_auth/domain/entities/authUser_parser.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthUnloadUsers extends AuthState {

}


class AuthSendData extends AuthState {

}


class AuthProgress extends AuthState {

}

class AuthErrorState extends AuthState{

}

