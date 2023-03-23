import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
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

class LoadArticlesEvent extends ArticleEvent{
final List<Map<String,dynamic>> list;
final List<Map<String,dynamic>> listmess;
  const LoadArticlesEvent({required this.list,required this.listmess});
}

class ShowSearchEvent extends ArticleEvent{
final String search;
final String userName;
  const ShowSearchEvent({required this.search,required this.userName});
}

class BeginDataArticlesEvent extends ArticleEvent{

  const BeginDataArticlesEvent();
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


class LoadAllArticleProgress extends ArticleState{
final List<Map<String,dynamic>> list;
final List<Map<String,dynamic>> listmess;
   const LoadAllArticleProgress({required this.list,required this.listmess});
}

class ArticleErrorState extends ArticleState{
  const ArticleErrorState();
}

class EmptyDataState extends ArticleState {

}

class SearchMiddleWareState extends ArticleState{
  const SearchMiddleWareState();
}

class ArticlesSearchEmptyState extends ArticleState{
final List<Map<String,dynamic>> list;
final List<Map<String,dynamic>> listmes;
const ArticlesSearchEmptyState({required this.list,required this.listmes});
}

class SearchState extends ArticleState{
final List<Map<String,dynamic>> list;
final List<Map<String,dynamic>> listmes;
const SearchState({required this.list,required this.listmes});
}


class AllchatsBloc extends Bloc<ArticleEvent,ArticleState>  {


  AllchatsBloc() : super(LoadArticleBegin()) {
    print('all chat');
    final List<Map<String,dynamic>> data =[];
    final List<Map<String,dynamic>> messData =[];
    List<Map<String,dynamic>> decodeImg = [];

    on<ArticleEvent>((event, emit) async {
      if (event is LoadArticlesEvent) {
        await loadArticleData(event, emit);
      } else if (event is BeginDataArticlesEvent) {
        emit(LoadArticleBegin());
      }else if(event is ShowSearchEvent){
        emit(const SearchMiddleWareState());
        final List<Map<String,dynamic>> listSearch =event.search==''? data : data.where((element){
          final searchName = event.userName == element['companion_one'] ? element['companion_two']:element['companion_one'];
          print(searchName.toLowerCase().contains(event.search.toLowerCase()));
          return searchName.toLowerCase().contains(event.search.toLowerCase());}).toList();
        emit(LoadAllArticleProgress(list:listSearch,listmess: messData));
      }
    });

    listenAndLoadData(data,messData,decodeImg);

  /*  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('chats')
        .where('companion_one', isEqualTo: 'dasha').snapshots();
    final Stream<QuerySnapshot> usersStream1 = FirebaseFirestore.instance
        .collection('chats')
        .where('companion_two', isEqualTo: 'dasha').snapshots();
    List<Stream<QuerySnapshot>> combineList1 = [usersStream, usersStream1];
    final List<Map<String,dynamic>> chatData = [];
    final totalRef = CombineLatestStream.list(combineList1);
    totalRef.listen((value) {
     print('${value}totallllllllllll');
     for (var doc in value) {
       print("doc${doc}}doc");
       for (var d in doc.docs) {
         final docData = d.data() as Map<String, dynamic>;
         chatData.add(docData);
         //print("d${d}}d");
         print("chat${d.id} => ${docData['companion_one']}chat");
       }
     }
     chatData.forEach((
         element) { //чтобы убрать дубли чата самому себе
       if (data
           .where((el) => el['id'] == element['id'])
           .isEmpty) {
         data.add(element);
       }
     });

    data.sort((a, b) =>
     int.parse(b['timelastmess'].toString()) -
         int.parse(a['timelastmess'].toString()));

     print(chatData.toString());

    });
   //сообщения

    final List<Map<String,dynamic>> messFinishData =[];
    final Stream<QuerySnapshot> mesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('name', isEqualTo: 'dasha').snapshots();
    final Stream<QuerySnapshot> mesStream1 = FirebaseFirestore.instance
        .collection('messages')
        .where('to', isEqualTo: 'dasha').snapshots();
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
    add(LoadArticlesEvent(list: data,listmess:messFinishData));*/
  }


Future<void> listenAndLoadData(List<Map<String,dynamic>> data,List<Map<String,dynamic>> messData,List<Map<String,dynamic>>decodeImg)async{
 final myName = await CookieDataProvider().getSessionId() as String;
  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('chats')
      .where('companion_one', isEqualTo: myName).snapshots();
  final Stream<QuerySnapshot> usersStream1 = FirebaseFirestore.instance
      .collection('chats')
      .where('companion_two', isEqualTo: myName).snapshots();
  List<Stream<QuerySnapshot>> combineList1 = [usersStream, usersStream1];
  final List<Map<String,dynamic>> chatData = [];
  final totalRef = CombineLatestStream.list(combineList1);
  totalRef.listen((value) {
    print('${value}totallllllllllll');
    for (var doc in value) {
      print("doc${doc}}doc");
      for (var d in doc.docs) {
        final docData = d.data() as Map<String, dynamic>;
        chatData.add(docData);
        //print("d${d}}d");
        print("chat${d.id} => ${docData['companion_one']}chat");
      }
    }
    chatData.forEach((
        element) { //чтобы убрать дубли чата самому себе
      if (data
          .where((el) => el['id'] == element['id'])
          .isEmpty) {
        data.add(element);
      }
    });

    data.sort((a, b) =>
    int.parse(b['timelastmess'].toString()) -
        int.parse(a['timelastmess'].toString()));

    print(chatData.toString());

  });
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
  /*messFinishData.map((el){
  if(el['images']!=null){
  el['images'] = json.decode(el['images'] as String) as Uint8List;
  }
  return el;
  }).toList();*/

  add(LoadArticlesEvent(list: data,listmess:messFinishData));
}



  Future<void> loadArticleData(LoadArticlesEvent event,
      Emitter<ArticleState> emit,) async {
    print('eventt');
emit(LoadAllArticleProgress(list:event.list,listmess: event.listmess));
  }
}
