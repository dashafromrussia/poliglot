/*import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/feature_auth/domain/entities/authUser_parser.dart';
import 'package:poliglot/feature_auth/domain/repositories/authService.dart';

class SendUserData extends UseCase<bool, UserParams> {
  final AuthServiceRegist authService;

  SendUserData({required this.authService});

  @override
  Future<Either<Failure, bool>> callData(
     UserParams params) async {
    return await authService.registPerson(params.user);
  }
}

class UserParams extends Equatable {
  final User user;

   const UserParams({required this.user});

  @override
  List<Object> get props => [user];
}*/
