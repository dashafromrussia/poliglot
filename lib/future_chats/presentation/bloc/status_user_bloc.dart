import 'dart:math';
import 'dart:async';
//import 'package:auth/blocks/status_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

abstract class StatusUserEvent extends Equatable{
  const StatusUserEvent();
  @override
  List<Object> get props => [];
}

class StatusUserOnlainEvent extends StatusUserEvent{

  const StatusUserOnlainEvent();
}
class StatusUserNoOnlainEvent extends StatusUserEvent{

  const StatusUserNoOnlainEvent();
}



abstract class StatusUserState extends Equatable{
  const StatusUserState();
  @override
  List<Object> get props => [];
}


class OnlineUserState extends StatusUserState{

  const OnlineUserState();
}



class NoOnlineUserState extends StatusUserState{
  const NoOnlineUserState();
}





class StatusUserBloc extends Bloc<StatusUserEvent,StatusUserState>{
final String name;

  StatusUserBloc({required this.name}) : super(const NoOnlineUserState()) {


    print('USER USER${name}');
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('status')
        .where('name', isEqualTo: name).snapshots();
    usersStream.listen((event) {
      print('DOOOOCC${event.docs}');
      for (var doc in event.docs)  {
       final docData =  doc.data() as Map<String,dynamic>;
        print("${doc.id} => ${docData['name']}");
        if(docData['status'] as String =='online'){
          add(const StatusUserOnlainEvent());
        }/*else if(docData['status'] as String =='offline'){
          add(const StatusUserNoOnlainEvent());
        }*/else{
          add(const StatusUserNoOnlainEvent());
        }
      }
    });

    // WidgetsBinding.instance.addObserver(this);
    on<StatusUserEvent>((event, emit) async {
      if (event is StatusUserOnlainEvent) {
        emit(const OnlineUserState());
      } else if (event is StatusUserNoOnlainEvent) {
        emit(const NoOnlineUserState());
      }
    });
    // add(const LoadArticlesEvent());
   // add(const StatusUserOnlainEvent());
  }
}



