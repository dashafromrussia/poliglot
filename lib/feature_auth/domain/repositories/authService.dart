import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_auth/presentation/pages/MainWidgets.dart';

abstract class AuthServiceRegist{
  Future<Either<Failure,bool>>registPerson(User user);

  Future<Either<Failure,List<User>>>getUsersData();

  Future<Either<Failure,bool>>sendCode(String code, String email);
}

