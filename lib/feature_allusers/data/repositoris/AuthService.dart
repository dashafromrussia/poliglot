import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_allusers/domain/repositories/authService.dart';
import 'package:poliglot/data/database_req.dart';

class UsersService implements AllUserService {
  final PersonRemoteDataSource remoteData;
  UsersService({required this.remoteData});


  @override
  Future<List<User>>getUsersData()async{
    try {
      final remoteResult = await remoteData.getUsersData();
      return remoteResult;
    } on ServerException{
      //return data;
      throw ServerException();
    }
  }

}
