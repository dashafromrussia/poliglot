import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/userLogin.dart';
import 'package:poliglot/feature_auth/presentation/pages/MainWidgets.dart';

abstract class AppServiceLogin{
  Future<Either<Failure,bool>>exit();
}

