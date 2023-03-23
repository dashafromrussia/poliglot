import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:poliglot/data/cookieData.dart';
abstract class ArticleEvent extends Equatable{
  const ArticleEvent();
  @override
  List<Object> get props => [];
}

class NewMessEvent extends ArticleEvent{
  final int newmess;

  const NewMessEvent({required this.newmess});
}



class BeginDataArticlesEvent extends ArticleEvent{

  const BeginDataArticlesEvent();
}




abstract class ArticleState extends Equatable{
  const ArticleState();
  @override
  List<Object> get props => [];
}

class LoadArticleBegin extends ArticleState{

}


class NewMessProgress extends ArticleState{
  final int newmess;

  const NewMessProgress({required this.newmess});
}

class ArticleErrorState extends ArticleState{
  const ArticleErrorState();
}

class EmptyDataState extends ArticleState {

}

class SearchMiddleWareState extends ArticleState{
  const SearchMiddleWareState();
}


class NewMessBloc extends Bloc<ArticleEvent,ArticleState>  {


  NewMessBloc() : super(LoadArticleBegin()) {
    print('all chat');
    final List<Map<String,dynamic>> messData =[];

    on<ArticleEvent>((event, emit) async {
      if (event is NewMessEvent) {
        await loadArticleData(event, emit);
      } else if (event is BeginDataArticlesEvent) {
        emit(LoadArticleBegin());
      }
    });
    listenAndLoadData(messData);

  }


  Future<void> listenAndLoadData(List<Map<String,dynamic>> messData)async{
    final myName = await CookieDataProvider().getSessionId() as String;

    //сообщения

    final List<Map<String,dynamic>> messFinishData =[];
    final Stream<QuerySnapshot> mesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('name', isEqualTo: myName).snapshots();
    final Stream<QuerySnapshot> mesStream1 = FirebaseFirestore.instance
        .collection('messages')
        .where('to', isEqualTo: myName).snapshots();
    List<Stream<QuerySnapshot>> combineList = [mesStream, mesStream1];
    final totalRef1 = CombineLatestStream.list(combineList);
    totalRef1.listen((value) {
      // print('${value}totallllllllllll');
      for (var doc in value) {
        // print("doc${doc}}doc");
        for (var d in doc.docs) {
          final docMessData = d.data() as Map<String, dynamic>;
          messData.add(docMessData);
          //print("d${d}}d");
          print("mesmesmes${d.id} => ${docMessData['name']}mesmesmes");
        }
      }
      messData.forEach((
          element) { //чтобы убрать дубли чата самому себе
        if (messFinishData
            .where((el) => el['id'] == element['id'])
            .isEmpty) {
          print('da');
          messFinishData.add(element);
        }
      });

      messFinishData.sort((a, b) =>
      int.parse(b['time'].toString()) -
          int.parse(a['time'].toString()));

      print('messFinishData'
          '0 ${messFinishData.toString()}');

    });
    final int newmess = messFinishData.where((element) => element['new']=='yes').length;
    add(NewMessEvent(newmess:newmess));
  }



  Future<void> loadArticleData(NewMessEvent event,
      Emitter<ArticleState> emit,) async {
    print('eventt');
    emit(NewMessProgress(newmess: event.newmess));
  }
}