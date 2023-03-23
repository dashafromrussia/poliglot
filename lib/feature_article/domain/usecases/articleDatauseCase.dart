import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_article/domain/repositories/articleServiceData.dart';
import 'package:poliglot/entities/articles.dart';

class ArticleDataCase extends UseCase<List<Articles>, ArticleParams> {
  final ArticleServiceData articleService;

  ArticleDataCase({required this.articleService});

  @override
  Future<Either<Failure,List<Articles>>> callData(ArticleParams params) async {
    return await articleService.getArticlesData();
  }
}

class ArticleParams extends Equatable {

  const ArticleParams();

  @override
  List<Object> get props => [];
}
