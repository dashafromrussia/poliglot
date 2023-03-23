import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'dart:math';
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

abstract class StatusEvent extends Equatable{
  const StatusEvent();
  @override
  List<Object> get props => [];
}

class StatusOnlainEvent extends StatusEvent{

  const StatusOnlainEvent();
}
class StatusNoOnlainEvent extends StatusEvent{

  const StatusNoOnlainEvent();
}



abstract class StatusState extends Equatable{
  const StatusState();
  @override
  List<Object> get props => [];
}


class OnlineState extends StatusState{

  const OnlineState();
}



class NoOnlineState extends StatusState{
  const NoOnlineState();
}





class StatusBloc extends Bloc<StatusEvent,StatusState> /*with WidgetsBindingObserver*/ {


  StatusBloc() : super(const OnlineState()) {

    final CollectionReference ref = FirebaseFirestore.instance.collection('status');

    print('statusSSS');

    StreamSubscription<FGBGType> subscription = FGBGEvents.stream.listen((event) {
      // FGBGType.foreground or FGBGType.background
      print('бегин${state}');
      if(event == FGBGType.foreground){
        add(const StatusOnlainEvent());
      }else{
        add(const StatusNoOnlainEvent());
      }
      print('sssseee${event}');
      print('sssseee${state}');
    });
   // WidgetsBinding.instance.addObserver(this);
    on<StatusEvent>((event, emit) async {
        if (event is StatusOnlainEvent) {
      await  onlineData(event, emit,ref);
      } else if (event is StatusNoOnlainEvent) {
          await nolineData(event, emit,ref);
      }
    });
    // add(const LoadArticlesEvent());
    add(const StatusOnlainEvent());
  }

  Future<void> onlineData(
      StatusEvent event,
      Emitter<StatusState> emit,
      CollectionReference ref
      ) async {
     List<String> data = [];
   await updateStatus('online', ref);
    emit(const OnlineState());
  }

  Future<void> nolineData(
      StatusEvent event,
      Emitter<StatusState> emit,
      CollectionReference ref
      ) async {
    List<String> data = [];
    await updateStatus('offline', ref);
    emit(const NoOnlineState());
  }

  Future<void> updateStatus(
     String status,
      CollectionReference ref
      ) async {
    List<String> data = [];
    await  ref.where('name', isEqualTo:'dasha').get().then((event) {
      if(event.docs.isEmpty){
        ref.add({
          'name': 'dasha', // John Doe
          'status': status, // Stokes and Sons
        })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }else{
        for (var doc in event.docs)  {
          data.add(doc.id.toString());
          ref
              .doc(doc.id.toString())
              .update({'status': status})
              .then((value) => print("status update"))
              .catchError((error) => print("Failed to update user: $error"));
          print("${doc.id} => ${doc.data()}");
        }
      }

    });
  }


//СТАТУС ПРИЛОЖЕНИЯ
  /*@override
  void didChangeAppLifecycleState(AppLifecycleState states){
    super.didChangeAppLifecycleState(states);
    print('sTATUS${states}STATUSss');
    if(states == AppLifecycleState.resumed){
      print(states == AppLifecycleState.resumed);
      add(const StatusOnlainEvent());
    }else{
      add(const StatusNoOnlainEvent());
    }
    print('so${state}');
  //  print('so${(state as OnlineState).isStatus}');
  }*/
}