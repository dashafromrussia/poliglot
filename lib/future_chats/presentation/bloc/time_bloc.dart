import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class TimeEvent extends Equatable{
  const TimeEvent();
  @override
  List<Object> get props => [];
}

class TimeDataEvent extends TimeEvent{
final int dateMess;
  const TimeDataEvent({required this.dateMess});
}




abstract class TimeState extends Equatable{
  const TimeState();
  @override
  List<Object> get props => [];
}

class TimeDataState extends TimeState{
  final String dateMess;
  const TimeDataState({required this.dateMess});
}
class TimeDataNotState extends TimeState{

}








class TimeBloc extends Bloc<TimeEvent,TimeState> {
  TimeBloc() : super(TimeDataNotState()) {
    print('time converter');
    on<TimeEvent>((event, emit) async {
      if (event is TimeDataEvent) {
         String resultime ='';
        final today = DateTime.now().toUtc().millisecondsSinceEpoch;
        final tomorrow = DateTime.now().toUtc().add(const Duration(hours: 24)).millisecondsSinceEpoch;
        final oneDayMilliSeconds = tomorrow - today;
        final differenceDay = today - event.dateMess;
        if(differenceDay < oneDayMilliSeconds){
          print('a');
          print(DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:false).hour);
          print(DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:false).minute);
           resultime = '${(DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:false).hour)}:${DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:false).minute}';
        }else if(differenceDay > oneDayMilliSeconds){
          print('b');
          print(DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:true).day);
          print(DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:true).month);
          print(DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:true));
          resultime = '${(DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:false).hour)}:${DateTime.fromMillisecondsSinceEpoch(event.dateMess,isUtc:false).minute}';
        }
        emit(TimeDataState(dateMess: resultime));
      }
    });
    //add(const LoadArticlesEvent());
  }

//сдел для чата свой айдишник и всё
  /*Future<void> loadArticleData(LoadArticlesEvent event,
      Emitter<ArticleState> emit,) async {
    print('eventt');
    //созд массив с айдишниками чатов,которое будут хр в личн инфе о пользователе
    /* final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('chats')
        .where('idchat', isEqualTo: '123').orderBy('timelastmes',descending: true).snapshots();
    emit(LoadArticleProgress(stream:usersStream));*/

  }*/
}