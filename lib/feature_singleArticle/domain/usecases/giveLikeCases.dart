import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/feature_singleArticle/domain/repositories/articleServiceData.dart';
import 'package:poliglot/entities/articles.dart';

class GiveLikeDataCase extends UseCase<bool, GiveLikeParams> {
  final OneArticleServiceData articleService;

  GiveLikeDataCase({required this.articleService});

  @override
  Future<Either<Failure,bool>>callData(GiveLikeParams params) async {
    return await articleService.giveLike(params.data);
  }
}


class GiveLikeParams extends Equatable {
  final Map<String,dynamic> data;
  const GiveLikeParams(this.data);

  @override
  List<Object> get props => [];
}
