import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/userLogin.dart';
import 'package:poliglot/feature_pass/domain/repositories/authService.dart';
import 'package:poliglot/data/database_req.dart';


class PasswordService implements ForgetPassService {
  final PersonRemoteDataSource remoteData;


 PasswordService({required this.remoteData});


@override
Future<Either<Failure,String>>checkEmailPerson(String email)async{
  try {
    final remoteResult = await remoteData.findDataEmail(email);
    String emailResult ='';
    if(remoteResult.length==1){
      emailResult = remoteResult[0].email;
    }
    return Right(emailResult);
  } on ServerException{
    return Left(ServerFailure());
  }
}

  @override
  Future<Either<Failure,bool>>sendPassword(String email,String password)async{
    try {
      final remoteResult = await remoteData.sendCode(password, email);
     UserLogin data = UserLogin(email: email, password: password);
      final remoteResult1 = await remoteData.updatePassword(data);
      return Right(remoteResult && remoteResult1);
    } on ServerException{
      return Left(ServerFailure());
    }
  }

}
