
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:poliglot/feature_book/presentation/bloc/main_bloc_state.dart';
import 'package:poliglot/feature_book/presentation/bloc/main_bloc_event.dart';


class BookBloc extends Bloc<BookEvent,BookState>{

  BookBloc() : super(const BookCount(count:0)) {
    on<SendData>((event,emit){
     int data = (state as BookCount).count;
     print(data);
     data = data + 1;
     print(data);
    emit(BookCount(count: data));
  });

  }
}



