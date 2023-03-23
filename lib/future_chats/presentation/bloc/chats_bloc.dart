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

abstract class ArticleEvent extends Equatable{
  const ArticleEvent();
  @override
  List<Object> get props => [];
}

class LoadArticlesEvent extends ArticleEvent{

  const LoadArticlesEvent();
}

class DataArticlesEvent extends ArticleEvent{

  const DataArticlesEvent();
}

class ViewArticlesEvent extends ArticleEvent{

  const ViewArticlesEvent();
}


abstract class ArticleState extends Equatable{
  const ArticleState();
  @override
  List<Object> get props => [];
}

class LoadArticleBegin extends ArticleState{

}


class LoadArticleProgress extends ArticleState{
 final totalRef;
 final totalRef1;
 const  LoadArticleProgress({required this.totalRef,required this.totalRef1});
}

class ArticleErrorState extends ArticleState{
  const ArticleErrorState();
}





class ChatsBloc extends Bloc<ArticleEvent,ArticleState> with WidgetsBindingObserver {


  ChatsBloc() : super(LoadArticleBegin()) {
    print('CHATS');
   WidgetsBinding.instance.addObserver(this);
    on<ArticleEvent>((event, emit) async {
      if (event is LoadArticlesEvent) {
        await loadArticleData(event, emit);
      } else if (event is DataArticlesEvent) {

      }
    });
    add(const LoadArticlesEvent());
  }

//сдел для чата свой айдишник и всё
  Future<void> loadArticleData(LoadArticlesEvent event,
      Emitter<ArticleState> emit,) async {
    print('eventt');
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('chats')
        .where('companion_one', isEqualTo: 'dasha').snapshots();
    final Stream<QuerySnapshot> usersStream1 = FirebaseFirestore.instance.collection('chats')
        .where('companion_two', isEqualTo: 'dasha').snapshots();

    List<Stream<QuerySnapshot>> combineList = [usersStream,usersStream1];
    final totalRef = CombineLatestStream.list(combineList);


    final Stream<QuerySnapshot> mesStream = FirebaseFirestore.instance.collection('messages')
        .where('name', isEqualTo: 'dasha').snapshots();
    final Stream<QuerySnapshot> mesStream1 = FirebaseFirestore.instance.collection('messages')
        .where('to', isEqualTo: 'dasha').snapshots();
    List<Stream<QuerySnapshot>> combineList1 = [mesStream,mesStream1];
    final  totalRef1 = CombineLatestStream.list(combineList1);

    emit(LoadArticleProgress(totalRef:totalRef,totalRef1: totalRef1));

    }
//СТАТУС ПРИЛОЖЕНИЯ
   /* @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);
     print('sTATUS${state}STATUS');
    final isBackground = state == AppLifecycleState.paused;
    }*/
  }


//ОТПРАВКА СООБЩЕНИЙ НА EMAIL
/*Future<void> loadArticleData(LoadArticlesEvent event,
    Emitter<ArticleState> emit,) async {
  print('eventt');
  String username = 'dariavladimirowna@gmail.com';
  String password = 'xaysgevibecqjzsr';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'dash')
    ..recipients.add('dariavladimirowna@gmail.com')
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}*/