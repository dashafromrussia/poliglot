/*import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:poliglot/data/cookieData.dart';
import 'package:poliglot/feature_singleArticle/presentation/bloc/cookieBloc.dart';
import 'package:poliglot/future_chats/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/future_chats/presentation/bloc/main_bloc_state.dart';
import 'package:equatable/equatable.dart';

abstract class CookieEvent extends Equatable {
  const CookieEvent();

  @override
  List<Object> get props => [];
}

class GetCookie extends CookieEvent {

}

abstract class CookieState extends Equatable {
  const CookieState();

  @override
  List<Object> get props => [];
}

class NoCookieState extends CookieState {

  const NoCookieState();

  @override
  List<Object> get props => [];

}
class YesCookieState extends CookieState {
  final String cookie;
  const YesCookieState({required this.cookie});

  @override
  List<Object> get props => [];

}

class CookieBloc extends Bloc<CookieEvent,CookieState>{

  CookieBloc() : super(const NoCookieState()) {
    on<GetCookie>((event,emit)async{
 final cook = await CookieDataProvider().getSessionId();
 final String cookie = cook is String ? cook : '';
   emit(YesCookieState(cookie: cookie));
  });

  }
}*/



