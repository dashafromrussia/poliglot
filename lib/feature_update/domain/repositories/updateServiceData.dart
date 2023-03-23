import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/entities/userLogin.dart';
import 'package:poliglot/feature_auth/presentation/pages/MainWidgets.dart';

abstract class UpdateServiceData{
  Future<Either<Failure,bool>>updateData(User user);
}

