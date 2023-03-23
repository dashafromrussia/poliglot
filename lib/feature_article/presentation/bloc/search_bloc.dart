import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/feature_article/domain/usecases/articleDatauseCase.dart';
import 'package:poliglot/entities/articles.dart';


abstract class SearchEvent extends Equatable{
  const SearchEvent();
  @override
  List<Object> get props => [];
}




class ShowSearchHolderEvent extends SearchEvent{
  const ShowSearchHolderEvent();
}

class ShowUnSearchHolderEvent extends SearchEvent{
  const ShowUnSearchHolderEvent();
}

 class SearchState extends Equatable{
  const SearchState();
  @override
  List<Object> get props => [];
}



class UnSearchState extends  SearchState{
  const UnSearchState();
  @override
  List<Object> get props => [];
}

class BeginSearchState extends  SearchState{
  const BeginSearchState();
  @override
  List<Object> get props => [];
}


class ArticleErrorState extends SearchState{
  const ArticleErrorState();
}





class SearchBloc extends Bloc<SearchEvent,SearchState>{

  SearchBloc() : super(const UnSearchState()) {
    print('NEW');
    on<SearchEvent>((event,emit){
      if(event is ShowSearchHolderEvent){
     emit(const BeginSearchState());
     print('begin');
    }else if(event is ShowUnSearchHolderEvent){
        emit(const UnSearchState());
        print('close');
      }
    });
  }
        }








