import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_auth/presentation/pages/MainWidgets.dart';

abstract class AllUserService{

  Future<List<User>>getUsersData();

}


