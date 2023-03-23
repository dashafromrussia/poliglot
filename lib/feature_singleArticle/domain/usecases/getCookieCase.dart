import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/core/error/failure.dart';
import 'package:poliglot/feature_singleArticle/domain/repositories/articleServiceData.dart';
import 'package:poliglot/core/useCases.dart';
import 'package:poliglot/entities/articles.dart';

class CookieOneArtCase extends UseCase<String, GetCookParams> {
  final OneArticleServiceData oneArtService;

 CookieOneArtCase({required this.oneArtService});

  @override
  Future<Either<Failure,String>> callData(GetCookParams params) async {
    return await oneArtService.getCookieData();
  }
}

class GetCookParams extends Equatable {

  const GetCookParams();

  @override
  List<Object> get props => [];
}
