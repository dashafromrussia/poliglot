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
abstract class ChatsEvent extends Equatable{
  const ChatsEvent();
  @override
  List<Object> get props => [];
}

class IsChatsEvent extends ChatsEvent{
final String my;
final String to;
final BuildContext context;
  const  IsChatsEvent({required this.my,required this.to,required this.context});
}


abstract class ChatsState extends Equatable{
  const ChatsState();
  @override
  List<Object> get props => [];
}

class BeginChatState extends ChatsState{
  const BeginChatState();
}

class DataChatState extends ChatsState{
  final Map<String,String> data;

const DataChatState({required this.data});
}



class ArticleErrorState extends ChatsState{
  const ArticleErrorState();
}




class ChatsBloc extends Bloc<ChatsEvent,ChatsState>  {

String idchaT = '';
String name = '';
  ChatsBloc() : super(const BeginChatState()) {

    on<ChatsEvent>((event, emit) async {
      if (event is IsChatsEvent) {
        await loadData(event, emit);
      }
    });

  }


  Future<void> loadData(ChatsEvent event,
      Emitter<ChatsState> emit,)async{
  //final myName = await CookieDataProvider().getSessionId() as String;
    CollectionReference ref = FirebaseFirestore.instance
        .collection('chats');

      await ref.where('companion_one', isEqualTo: (event as IsChatsEvent).my).where('companion_two', isEqualTo: (event as IsChatsEvent).to)
    .get().then((event){
    if(event.docs.isEmpty){//если нет такого чата
    }
    else{
    for (var doc in event.docs)  {
      Map<String,dynamic> data= doc.data() as Map<String,dynamic>;
      idchaT = data["idchat"]!=null ?  data["idchat"] as String :'';
    print("${doc.id} => ${doc.data()}");
    }
    }

    });
      await ref.where('companion_two', isEqualTo:(event as IsChatsEvent).my).where('companion_one', isEqualTo: (event as IsChatsEvent).to).get().then((event)async{
          if(event.docs.isEmpty){//если нет такого чата
          }
          else{
            for (var doc in event.docs)  {
              Map<String,dynamic> data= doc.data() as Map<String,dynamic>;
              idchaT = data["idchat"]!=null ?  data["idchat"] as String :'';
              print("${doc.id} => ${doc.data()}");
            }
          }
          Map<String,String> arguments ={};
if(idchaT==''){
   idchaT =DateTime.now().toUtc().millisecondsSinceEpoch.toString();
  const String possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxxy0123456789";
  for (int i = 0; i < 5; i++){
    idchaT = idchaT + possible[Random().nextInt(59) + 1];
  }
 arguments = {'idchat':idchaT,'name':(event as IsChatsEvent).to};
   Navigator.pushNamed((event as IsChatsEvent).context, '/messages',arguments:arguments);
}
emit(DataChatState(data: arguments));
        });
    }
    //сообщения

  }

