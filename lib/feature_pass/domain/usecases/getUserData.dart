import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/feature_pass/domain/repositories/authService.dart';

class VerifyEmailData extends UseCase<String,VerifyEmailParams> {
  final ForgetPassService authService;

  VerifyEmailData({required this.authService});

  @override
  Future<Either<Failure,String>>callData(VerifyEmailParams params) async {
    return await authService.checkEmailPerson(params.email);
  }
}

class VerifyEmailParams extends Equatable {
  final String email;
  const VerifyEmailParams({required this.email});

  @override
  List<Object> get props => [email];
}

