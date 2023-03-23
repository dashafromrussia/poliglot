import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/articles.dart';



abstract class ArticleServiceData{
  Future<Either<Failure,List<Articles>>>getArticlesData();
}

