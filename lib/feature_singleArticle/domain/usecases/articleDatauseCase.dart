import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_singleArticle/domain/repositories/articleServiceData.dart';
import 'package:poliglot/entities/articles.dart';

class OneArticleDataCase extends UseCase<Articles, OneArtParams> {
  final OneArticleServiceData articleService;

  OneArticleDataCase({required this.articleService});

  @override
  Future<Either<Failure,Articles>>callData(OneArtParams params) async {
    return await articleService.getOneArticleData(params.data);
  }
}

class OneArtParams extends Equatable {
  final Articles data;
  const OneArtParams(this.data);

  @override
  List<Object> get props => [];
}
