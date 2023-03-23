import 'dart:async';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_app/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_app/domain/usecases/isAuth.dart';
import 'package:flutter/material.dart';


class AppBloc extends Bloc<AppEvent,AppState>{
 AppIsAuth useCaseApp;
  AppBloc({required this.useCaseApp}) : super(const ToggleState({'Books': Colors.black,'Main': Colors.black, 'Articles':Colors.black, 'Update': Colors.black,
    'Chats': Colors.black, 'Exit':Colors.black})) {
   /* on<AppData>((event,emit){
     int data = (state as AppCount).count;
     print(data);
     data = data + 1;
     print(data);
    emit(AppCount(count: data));
  });*/
  on<ToggleDrawer>((event,emit){
      Map<String,Color>data =(state as ToggleState).selects;
      Map<String,Color>changedData = {};
      for(var item in data.entries){
        if(item.key==event.select.toString()){
          changedData[event.select] = Colors.blue;
          print(event.select);
        }else{
          changedData[item.key] = Colors.black;
        }
      }
      emit(ToggleState(changedData));
    },
    );
  on<ExitEvent>((event,emit)async{
    await useCaseApp.callData(const AppParams());
  });
 // add(const ToggleDrawer('books'));

  }
}



