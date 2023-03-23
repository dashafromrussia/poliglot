import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/feature_article/domain/usecases/articleDatauseCase.dart';
import 'package:poliglot/entities/articles.dart';


abstract class ArticleEvent extends Equatable{
  const ArticleEvent();
  @override
  List<Object> get props => [];
}

class LoadArticlesEvent extends ArticleEvent{

  const LoadArticlesEvent();
}

class ShowCategoryEvent extends ArticleEvent{
final String category;
  const ShowCategoryEvent({required this.category});
}

class ShowSearchEvent extends ArticleEvent{
  final String search;
  const ShowSearchEvent({required this.search});
}


class AddViewEvent extends ArticleEvent{
final int id;
const AddViewEvent(this.id);
}

class UpdatePostEvent extends ArticleEvent{
  final int id;
  final List<String> likes;
  const UpdatePostEvent({required this.id,required this.likes});
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
  final List<Articles> articles;
  const ArticlesFinishData(this.articles);
}

class ArticlesCategoryState extends ArticleState{

}

class ArticlesInterestState extends ArticlesCategoryState{
  final List<Articles> articles;
   ArticlesInterestState(this.articles);
}


class ArticlesAllState extends ArticlesCategoryState{
  final List<Articles> articles;
   ArticlesAllState(this.articles);
}

class ArticlesCalendarState extends ArticlesCategoryState{
  final List<Articles> articles;
  ArticlesCalendarState(this.articles);
}

class ArticlesOtherState extends ArticlesCategoryState{
  final List<Articles> articles;
   ArticlesOtherState(this.articles);
}

class ArticlesLifehackState extends ArticlesCategoryState{
  final List<Articles> articles;
  ArticlesLifehackState(this.articles);
}

class ArticlesSearchState extends ArticlesCategoryState{
  final List<Articles> articles;
  ArticlesSearchState(this.articles);
}

class ArticlesSearchEmptyState extends ArticlesCategoryState{
  final List<Articles> articles;
  ArticlesSearchEmptyState(this.articles);
}
class ArticlesSearchMiddleWareState extends ArticleState{

 const ArticlesSearchMiddleWareState();
}


class ArticlesUpdateLikesState extends ArticleState{

  const ArticlesUpdateLikesState();
}

class ArticlesUpdateViewsState extends ArticleState{

 const ArticlesUpdateViewsState();
}



class ArticlesBloc extends Bloc<ArticleEvent,ArticleState>{

  final ArticleDataCase articleData;
  List<Articles> allArticles = [];
  String category = 'all';

  ArticlesBloc({required this.articleData}) : super(const LoadArticleBegin()) {
    print('NEW');
    on<ArticleEvent>((event,emit)async{
      if(event is LoadArticlesEvent){
        await loadArticleData(event, emit);
      }else if(event is ShowCategoryEvent){
        print(event.category);
        final List<Articles> listCategory = event.category =='all'? allArticles : allArticles.where((element) =>
        element.category == event.category).toList();
        if(event.category == 'lifehack'){
          category = 'lifehack';
          emit(ArticlesLifehackState(listCategory));
        }else if(event.category == 'other'){
          category = 'other';
          emit(ArticlesOtherState(listCategory));
        }else if(event.category == 'interest') {
          category = 'interest';
          emit(ArticlesInterestState(listCategory));
        }else if(event.category == 'calendar') {
          category = 'calendar';
          emit(ArticlesCalendarState(listCategory));
        }else if(event.category == 'all') {
          category = 'all';
          emit(ArticlesAllState(listCategory));
        }
      //  emit(ArticlesCategoryState(listCategory));
      }else if(event is ShowSearchEvent){
        emit(const ArticlesSearchMiddleWareState());
        final List<Articles> listSearch =event.search==''? allArticles : allArticles.where((element){
          print(element.header.toLowerCase().contains(event.search.toLowerCase()));
      return element.header.toLowerCase().contains(event.search.toLowerCase());}).toList();
        event.search==''?emit(ArticlesSearchEmptyState(listSearch)): emit(ArticlesSearchState(listSearch));
      }
      else if(event is AddViewEvent){
        print('update views');
        emit(const ArticlesUpdateViewsState());
         List<Articles> listCategory = category =='all'? allArticles : allArticles.where((element) =>
        element.category == category).toList();
         listCategory = listCategory.map((el){
           if(event.id == el.id){
              el = el.copyWith(curviews: el.views+1);
           }
           print(el);
           return el;
         }).toList();
         print('общий артиклллл${listCategory}');
        emit(ArticlesAllState(listCategory));
        if(category == 'lifehack'){
          print('LIFEHAAACCCCCC');
          category = 'lifehack';
          emit(ArticlesLifehackState(listCategory));
        }else if(category == 'other'){
          print('OTHERRRRRRRR');
          category = 'other';
          emit(ArticlesOtherState(listCategory));
        }else if(category == 'interest') {
          category = 'interest';
          emit(ArticlesInterestState(listCategory));
          print('INTERESRRRRRTTTTT');
        }else if(category == 'calendar') {
          category = 'calendar';
          emit(ArticlesCalendarState(listCategory));
          print('CALENDSAAAAARRRRRR');
        }else if(category == 'all') {
          category = 'all';
          emit(ArticlesAllState(listCategory));
          print('ALLLLLLLLLLLLLLLLLLLLLLLL');
        }
      }else if(event is UpdatePostEvent){
        print('update likes');
        emit(const ArticlesUpdateLikesState());
        List<Articles> listCategory = category =='all'? allArticles : allArticles.where((element) =>
        element.category == category).toList();

        listCategory = listCategory.map((el){
          if(event.id == el.id){
            el = el.copyWith(curlikes: event.likes);
          }
          print(el);
          return el;
        }).toList();

        if(category == 'lifehack'){
          category = 'lifehack';
          emit(ArticlesLifehackState(listCategory));
        }else if(category == 'other'){
          category = 'other';
          emit(ArticlesOtherState(listCategory));
        }else if(category == 'interest') {
          category = 'interest';
          emit(ArticlesInterestState(listCategory));
        }else if(category == 'calendar') {
          category = 'calendar';
          emit(ArticlesCalendarState(listCategory));
        }else if(category == 'all') {
          category = 'all';
          emit(ArticlesAllState(listCategory));
        }
      }
    });
    print('1');
  add(const LoadArticlesEvent());
  print('2');
  //add(const ShowCategoryEvent(category: 'all'));
  print('3');
  }

  Future<void> loadArticleData(
      LoadArticlesEvent event,
      Emitter<ArticleState> emit,
      ) async {
    emit(const LoadArticleProgress());
    final data = await articleData.callData(const ArticleParams());
    emit(data.fold(
            (failure) => const ArticleErrorState(),
            (articles) => ArticlesFinishData(articles)));
    allArticles = state is ArticlesFinishData ?
    (state as ArticlesFinishData).articles : [];
    emit(ArticlesAllState(allArticles));
    print("${state}articlesss");
  }
}








