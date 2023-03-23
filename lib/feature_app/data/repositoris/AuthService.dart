import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/userLogin.dart';
import 'package:poliglot/feature_app/domain/repositories/authService.dart';
import 'package:poliglot/feature_app/data/datasources/database_req.dart';
//import 'package:poliglot/feature_app/data/datasources/cookieData.dart';
import 'package:poliglot/data/cookieData.dart';
import 'package:poliglot/feature_app/data/datasources/database_req.dart';

class AppService implements AppServiceLogin {


  final CookieData cookieData;

 AppService({required this.cookieData});

  /*@override
  Future<Either<Failure,bool>>checkDataPerson(UserLogin user)async{
    try {
      final remoteResult = await remoteData.getUserData(user);
      if(remoteResult){
        await cookieData.setSessionId(user.email);
      }
      return Right(remoteResult);
    } on ServerException{
      return Left(ServerFailure());
    }
  }*/

@override
Future<Either<Failure,bool>>exit()async{
  try {
 await cookieData.deleteSessionId();
     return Right(true);
  } on ServerException{
    return Left(ServerFailure());
  }
}

}
