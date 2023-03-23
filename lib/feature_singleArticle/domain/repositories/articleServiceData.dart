import 'package:dartz/dartz.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/entities/articles.dart';



abstract class OneArticleServiceData{
  Future<Either<Failure,String>>getCookieData();
  Future<Either<Failure,Articles>>getOneArticleData(Articles data);
  Future<Either<Failure,bool>>giveLike(Map<String,dynamic> data);
}

