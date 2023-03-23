import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_auth/domain/repositories/authService.dart';

class GetUserData extends UseCase<List<User>,UserDataParams> {
  final AuthServiceRegist authService;

  GetUserData({required this.authService});

  @override
  Future<Either<Failure,List<User>>> callData(UserDataParams params) async {
    return await authService.getUsersData();
  }
}

class UserDataParams extends Equatable {

  const UserDataParams();

  @override
  List<Object> get props => [];
}

