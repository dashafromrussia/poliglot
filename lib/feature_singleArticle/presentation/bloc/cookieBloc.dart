import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/feature_singleArticle/domain/usecases/getCookieCase.dart';
import 'package:flutter/material.dart';

abstract class CookieEvent extends Equatable {
  const CookieEvent();

  @override
  List<Object> get props => [];
}

/*class AppData extends AppEvent {

}*/

class GetCookie extends CookieEvent {
  const GetCookie();
}

abstract class CookieState extends Equatable {
  const CookieState();

  @override
  List<Object> get props => [];
}


class CookieSuccessState extends CookieState {
  final String cookie;
  const CookieSuccessState(this.cookie);

  @override
  List<Object> get props => [cookie];

}

class CookieFailState extends CookieState {
  const CookieFailState();

}



class CookieBloc extends Bloc<CookieEvent,CookieState>{
  CookieOneArtCase useCaseApp;
  CookieBloc({required this.useCaseApp}) : super(const CookieFailState()) {
    on<GetCookie>((event,emit)async{
      final data = await useCaseApp.callData(const GetCookParams());
      emit(data.fold(
              (failure) => const CookieFailState(),
              (cook) => CookieSuccessState(cook)));
    },
    );
    add(const GetCookie());
  }
}


