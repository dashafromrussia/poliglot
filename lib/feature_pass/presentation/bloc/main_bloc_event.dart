import 'package:equatable/equatable.dart';
import 'package:poliglot/entities/userLogin.dart';
import 'package:poliglot/feature_login/presentation/pages/MainWidgets.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class VerifyData extends LoginEvent {
final UserLogin user;
const VerifyData(this.user);
}

class IsAuthorized extends LoginEvent{

}

