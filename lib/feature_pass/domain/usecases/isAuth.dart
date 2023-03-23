import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/feature_login/domain/entities/authUser_parser.dart';
import 'package:poliglot/feature_login/domain/repositories/authService.dart';

class IsAuth extends UseCase<bool,AuthParams> {
  final AuthServiceLogin authService;

IsAuth({required this.authService});

  @override
  Future<Either<Failure,bool>>callData(AuthParams params) async {
    return await authService.isAuth();
  }
}

class AuthParams extends Equatable {

  const AuthParams();

  @override
  List<Object> get props => [];
}

