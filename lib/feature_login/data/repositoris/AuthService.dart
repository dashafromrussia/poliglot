import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/userLogin.dart';
import 'package:poliglot/feature_login/domain/repositories/authService.dart';
import 'package:poliglot/data/database_req.dart';
import 'package:poliglot/data/cookieData.dart';

class LoginService implements AuthServiceLogin {
  final PersonRemoteDataSource remoteData;
  final CookieData cookieData;

 LoginService({required this.remoteData, required this.cookieData});


@override
Future<Either<Failure,bool>>checkDataPerson(UserLogin user)async{
  try {
    final remoteResult = await remoteData.getUserData(user);
    if(remoteResult.length==1){
     await cookieData.setSessionId(user.email);
    }
    return Right(remoteResult.length==1);
  } on ServerException{
    return Left(ServerFailure());
  }
}
@override
Future<Either<Failure,bool>>isAuth()async{
  try {
   if(await cookieData.getSessionId() is String){
     return Right(true);
    }
    return Right(false);
  } on ServerException{
    return Left(ServerFailure());
  }
}

}
