import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/feature_singleArticle/domain/repositories/articleServiceData.dart';
import 'package:poliglot/data/database_req.dart';
import 'package:poliglot/entities/articles.dart';
import 'package:poliglot/data/cookieData.dart';

class OneArticleService implements OneArticleServiceData {
  final PersonRemoteDataSource remoteData;
  final CookieData cookieData;
  OneArticleService({required this.remoteData,required this.cookieData});


@override
Future<Either<Failure,Articles>>getOneArticleData(Articles data)async{
  final int views = data.views +1;
  try {
    final updateView = await remoteData.updateView(data.id, views);
    final result = await remoteData.getOneArticlesData(data.id);
    return Right(result);
  } on ServerException{
    return Left(ServerFailure());
  }
}


  @override
  Future<Either<Failure,String>>getCookieData()async{
    try {
      final result = await cookieData.getSessionId();
      final String cookieResult = result is String ? result : '';

      return Right(cookieResult);
    } on ServerException{
      return Left(ServerFailure());
    }
  }


  @override
  Future<Either<Failure,bool>>giveLike(Map<String,dynamic> data)async{
    try {
      final result = await remoteData.updateLike(data);
      return Right(result);
    } on ServerException{
      return Left(ServerFailure());
    }
  }
}
