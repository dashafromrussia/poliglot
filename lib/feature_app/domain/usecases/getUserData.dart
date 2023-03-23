import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/entities/userLogin.dart';
import 'package:poliglot/feature_login/domain/repositories/authService.dart';

class GetLoginData extends UseCase<bool,DataParams> {
  final AuthServiceLogin authService;

  GetLoginData({required this.authService});

  @override
  Future<Either<Failure,bool>>callData(DataParams params) async {
    return await authService.checkDataPerson(params.user);
  }
}

class DataParams extends Equatable {
  final UserLogin user;
  const DataParams({required this.user});

  @override
  List<Object> get props => [user];
}

