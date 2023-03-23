import 'dart:async';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:poliglot/feature_app/domain/usecases/isAuth.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/data/cookieData.dart';

abstract class CookieEvent extends Equatable {
  const CookieEvent();

  @override
  List<Object> get props => [];
}

/*class AppData extends AppEvent {

}*/

class SetCookieEvent extends CookieEvent {
  final String cookie;

  const SetCookieEvent(this.cookie);

  @override
  List<Object> get props => [cookie];
}

class ExitCookieEvent extends CookieEvent{

}

class GetCookieEvent extends CookieEvent{

}


abstract class CookieState extends Equatable {
  const CookieState();

  @override
  List<Object> get props => [];
}

 class CookieBeginState extends CookieState{
  const CookieBeginState();

  @override
  List<Object> get props => [];
}

class SetCookieState extends CookieState {
  final String cookie;

  const SetCookieState(this.cookie);

  @override
  List<Object> get props => [cookie];
}

class ExitState extends CookieState{

}

class GetCookieState extends CookieState{
  final String? cookie;
  const GetCookieState(this.cookie);
}




class CookieDrawerBloc extends Bloc<CookieEvent,CookieState>{
CookieData cookieData;
  CookieDrawerBloc({required this.cookieData}) : super(const CookieBeginState()) {
    on<CookieEvent>((event,emit)async{
      if (event is GetCookieEvent) {
    final String? cook =  await cookieData.getSessionId();
    emit(GetCookieState(cook!=null?cook:''));
      } else if (event is SetCookieEvent) {
        await cookieData.setSessionId(event.cookie);
        emit(SetCookieState(event.cookie));
      }else if(event is ExitCookieEvent){
        await cookieData.deleteSessionId();
        emit(ExitState());
      }
    },
    );
  
    add(GetCookieEvent());
  }
}
