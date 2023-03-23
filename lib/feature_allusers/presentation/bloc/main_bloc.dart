import 'dart:async';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/feature_allusers/domain/repositories/authService.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_app/domain/usecases/isAuth.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:poliglot/entities/user.data.dart';

abstract class AllUsersEvent extends Equatable {
  const AllUsersEvent();

  @override
  List<Object> get props => [];
}

/*class AppData extends AppEvent {

}*/

class BeginEvent extends AllUsersEvent {

  const BeginEvent();
  @override
  List<Object> get props => [];
}


class SearchUserEvent extends AllUsersEvent{
final String search;
const SearchUserEvent({required this.search});
}

abstract class AllUsersState extends Equatable {
  const AllUsersState();

  @override
  List<Object> get props => [];
}

class SearchDataState extends AllUsersState {
  final List<User> searchUsers;
  const SearchDataState({required this.searchUsers});

  @override
  List<Object> get props => [];

}

class MiddleWareState extends AllUsersState{

}

class BeginState extends AllUsersState {

  const BeginState();


  @override
  List<Object> get props => [];


}
class ProcessState extends AllUsersState {

  const ProcessState();

  @override
  List<Object> get props => [];

}

class FinishDataState extends AllUsersState {
final List<User> allusers;
  const FinishDataState({required this.allusers});

  @override
  List<Object> get props => [];

}

class SearchEmptyState extends AllUsersState {
  final List<User> allusers;
  const SearchEmptyState({required this.allusers});

  @override
  List<Object> get props => [];

}

class ErrorDataState extends AllUsersState{

}


class AllUserBloc extends Bloc<AllUsersEvent,AllUsersState>{
  AllUserService allUser;
  AllUserBloc({required this.allUser}) : super(const BeginState()) {
  List<User> users = [];
  on<AllUsersEvent>((event,emit)async{
    if(event is BeginEvent){
      emit(const ProcessState());
      try{
        final List<User> data = await allUser.getUsersData();
        users = data;
        emit(FinishDataState(allusers:data));
      }on ServerException{
        emit(ErrorDataState());
      }
    }else if(event is SearchUserEvent){
      emit(MiddleWareState());
      List<User> searchUsers = users.where((element){
        return element.email.toLowerCase().contains(event.search.toLowerCase());
      }).toList();
      event.search==''? emit(SearchDataState(searchUsers: searchUsers)):
      emit(SearchDataState(searchUsers: searchUsers));
    }
    },
    );
  add(const BeginEvent());
  }
}


