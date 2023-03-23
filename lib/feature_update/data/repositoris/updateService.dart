import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_update/domain/repositories/updateServiceData.dart';
import 'package:poliglot/data/database_req.dart';


class UpdateService implements UpdateServiceData {
  final PersonRemoteDataSource remoteData;

  UpdateService({required this.remoteData});



  @override
  Future<Either<Failure,bool>>updateData(User user)async{
    try {
      final remoteResult = await remoteData.updateUser(user);
      return Right(remoteResult);
    } on ServerException{
      return Left(ServerFailure());
    }
  }

}
