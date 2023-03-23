import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_auth/domain/repositories/authService.dart';

class SendCodeToEmail extends UseCase<bool, EmailCodeParams> {
  final AuthServiceRegist authService;

  SendCodeToEmail({required this.authService});

  @override
  Future<Either<Failure, bool>> callData(EmailCodeParams params) async {
    return await authService.sendCode(params.code, params.email);
  }
}

class EmailCodeParams extends Equatable {
 final String code;
 final String email;
 const EmailCodeParams({required this.code,required this.email});

  @override
  List<Object> get props => [code,email];
}
