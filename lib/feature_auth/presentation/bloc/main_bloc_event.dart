import 'package:equatable/equatable.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_auth/presentation/pages/MainWidgets.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendData extends AuthEvent {
final User newUser;
 SendData(this.newUser);
}

