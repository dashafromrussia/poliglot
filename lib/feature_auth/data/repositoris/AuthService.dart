import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_auth/domain/repositories/authService.dart';
import 'package:poliglot/data/database_req.dart';

class AuthService implements AuthServiceRegist {
  final PersonRemoteDataSource remoteData;
 AuthService({required this.remoteData});

@override
Future<Either<Failure,bool>>registPerson(User user)async{
 try {
   final remoteResult = await remoteData.sendUserData(user);
   return Right(remoteResult);
 } on ServerException{
   return Left(ServerFailure());
 }
}

@override
Future<Either<Failure,List<User>>>getUsersData()async{
  try {
    final remoteResult = await remoteData.getUsersData();
    return Right(remoteResult);
  } on ServerException{
    return Left(ServerFailure());
  }
}

  @override
  Future<Either<Failure,bool>>sendCode(String code,String email)async{
    try {
      final codeIsSend = await remoteData.sendCode(code, email);
      return Right(codeIsSend);
    } on ServerException{
      return Left(ServerFailure());
    }
  }


}
