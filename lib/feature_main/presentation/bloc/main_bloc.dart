
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_event.dart';
import 'package:poliglot/feature_main/presentation/bloc/main_bloc_state.dart';

class MainBloc extends Bloc<MainEvent,MainState>{

  MainBloc() : super(const MainCount(count:0)) {
    on<SendData>((event,emit){
     int data = (state as MainCount).count;
     print(data);
     data = data + 1;
     print(data);
    emit(MainCount(count: data));
  });

  }
}



