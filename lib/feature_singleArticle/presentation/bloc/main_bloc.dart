import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/feature_article/presentation/bloc/main_bloc.dart';
import 'package:poliglot/feature_singleArticle/domain/usecases/articleDatauseCase.dart';
import 'package:poliglot/feature_singleArticle/domain/usecases/giveLikeCases.dart';
import 'package:poliglot/entities/articles.dart';
import 'dart:convert';


abstract class ArticleEvent extends Equatable{
  const ArticleEvent();
  @override
  List<Object> get props => [];
}

class LoadArticlesEvent extends ArticleEvent{

  const LoadArticlesEvent();
}

class GiveLikesEvent extends ArticleEvent{
  final String cookie;
  const GiveLikesEvent(this.cookie);
}


abstract class ArticleState extends Equatable{
  const ArticleState();
  @override
  List<Object> get props => [];
}

class LoadArticleBegin extends ArticleState{
  const LoadArticleBegin();
}


class LoadArticleProgress extends ArticleState{
  const LoadArticleProgress();
}
class ArticleErrorState extends ArticleState{
  const ArticleErrorState();
}

class ArticlesFinishData extends ArticleState{
  final Articles article;
  const ArticlesFinishData(this.article);
}

class ArticleGiveLikeState extends ArticleState{

}


class OneArticlesBloc extends Bloc<ArticleEvent,ArticleState>{
 final Articles data;
  final OneArticleDataCase articleData;
  final GiveLikeDataCase giveLikeCase;

  OneArticlesBloc({required this.articleData,required this.giveLikeCase,required this.data}) : super(const LoadArticleBegin()) {
    on<ArticleEvent>((event,emit)async{
      if(event is LoadArticlesEvent){
        await loadArticleData(event, emit);
      }else if(event is GiveLikesEvent){
         List<String> likes =(state as ArticlesFinishData).article.likes;
         print(likes.contains(event.cookie));
         if(likes.contains(event.cookie)){
           print('dislike');
          likes = likes.where((element) =>
           element != event.cookie).toList();
          print(likes);
         }else {
           print('like');
           likes = [...likes, event.cookie];

         }

         final Map<String,dynamic> sendData = {'id':(state as ArticlesFinishData).article.id,
           'likes':jsonEncode(likes)};
       final result =  await giveLikeCase.callData(GiveLikeParams(sendData));
       Articles dataResult = (state as ArticlesFinishData).article.copyWith(curlikes:likes);
         emit(ArticleGiveLikeState());
         print(dataResult);
         emit(result.fold(
                 (failure) => const ArticleErrorState(),
                 (articles) => ArticlesFinishData(dataResult)));
      }
    });
add(const LoadArticlesEvent());
  }

  Future<void> loadArticleData(
      LoadArticlesEvent event,
      Emitter<ArticleState> emit,
      ) async {
    emit(const LoadArticleProgress());
    final dataRes = await articleData.callData(OneArtParams(data));
    emit(dataRes.fold(
            (failure) => const ArticleErrorState(),
            (articles) => ArticlesFinishData(articles)));
    print("${state}articlesss");

  }
}








