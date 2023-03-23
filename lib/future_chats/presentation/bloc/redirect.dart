import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';


abstract class RedirectEvent extends Equatable{
  const RedirectEvent();
  @override
  List<Object> get props => [];
}

class AddRedirectEvent extends RedirectEvent{
  final Map<String,dynamic> redirect;
  const AddRedirectEvent({required this.redirect});
}

class DeleteRedirectEvent extends RedirectEvent{

  const DeleteRedirectEvent();
}



abstract class RedirectState extends Equatable{
  const RedirectState();
  @override
  List<Object> get props => [];
}

class NoRedirectState extends RedirectState{
 const NoRedirectState();

}

class YesRedirectState extends RedirectState{
  final List<Map<String,dynamic>> redirect;
  const YesRedirectState({required this.redirect});
}




class RedirectBloc extends Bloc<RedirectEvent,RedirectState>{



  RedirectBloc() : super(const NoRedirectState()) {
    print('Redirect');
    on<RedirectEvent>((event,emit)async{
      if(event is DeleteRedirectEvent){
        emit(const NoRedirectState());
      }else if(event is AddRedirectEvent){
        final List<Map<String,dynamic>> redir = [];
        final  List<Map<String,dynamic>> redirAtredir = (event.redirect['redirect'] as List).length > 0 ?
        (event.redirect['redirect'] as List).map((dynamic document) {
          return document as Map<String, dynamic>;
        }).toList():[];
        redir.add(event.redirect);
        redir.addAll(redirAtredir);
        emit(YesRedirectState(redirect:redir));
      }
    });
    add(const DeleteRedirectEvent());
  }

}








