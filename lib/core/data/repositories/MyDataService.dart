import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/core/domain/repositoris/myData.dart';
import 'package:poliglot/data/database_req.dart';
import 'package:poliglot/data/cookieData.dart';

class MyDataService implements MyInfoService {
  final PersonRemoteDataSource remoteData;
   final CookieData cookieData;

  MyDataService({required this.remoteData,required this.cookieData});

  @override
  Future<Either<Failure,bool>>updateData(User user)async{
    try {
      final remoteResult = await remoteData.updateUser(user);
      return Right(remoteResult);
    } on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure,List<User>>>getMyData() async{
    try {
      final cookieEmail = await cookieData.getSessionId();
      List<User> myData =[];
      if(cookieEmail is String){
        print('LOAD MY DATATATAA');
       myData =await remoteData.findDataEmail(cookieEmail);
      }
      return Right(myData);
    } on ServerException{
      return Left(ServerFailure());
    }
  }



}
