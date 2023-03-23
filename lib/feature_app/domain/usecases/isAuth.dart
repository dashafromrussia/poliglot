import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/feature_app/domain/entities/authUser_parser.dart';
import 'package:poliglot/feature_app/domain/repositories/authService.dart';

class AppIsAuth extends UseCase<bool,AppParams> {
  final AppServiceLogin authService;

  AppIsAuth({required this.authService});

  @override
  Future<Either<Failure,bool>>callData(AppParams params) async {
    return await authService.exit();
  }
}

class AppParams extends Equatable {

  const AppParams();

  @override
  List<Object> get props => [];
}

