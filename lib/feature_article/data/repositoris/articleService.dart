import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/feature_article/domain/repositories/articleServiceData.dart';
import 'package:poliglot/data/database_req.dart';
import 'package:poliglot/entities/articles.dart';


class ArticleService implements ArticleServiceData {
  final PersonRemoteDataSource remoteData;

  ArticleService({required this.remoteData});



  @override
  Future<Either<Failure,List<Articles>>>getArticlesData()async{
    try {
      final remoteResult = await remoteData.getArticlesData();
      return Right(remoteResult);
    } on ServerException{
      return Left(ServerFailure());
    }
  }

}
