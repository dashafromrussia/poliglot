import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/feature_pass/domain/repositories/authService.dart';

class SendPasswordToEmail extends UseCase<bool, PasswordToEmailParams> {
  final ForgetPassService authService;

  SendPasswordToEmail({required this.authService});

  @override
  Future<Either<Failure, bool>> callData(PasswordToEmailParams params) async {
    return await authService.sendPassword(params.email, params.password);
  }
}

class PasswordToEmailParams extends Equatable {
 final String password;
 final String email;
 const PasswordToEmailParams({required this.password,required this.email});

  @override
  List<Object> get props => [password,email];
}
