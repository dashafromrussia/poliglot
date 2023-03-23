import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ArticleEvent extends Equatable{
  const ArticleEvent();
  @override
  List<Object> get props => [];
}

class LoadArticlesEvent extends ArticleEvent{
  List<Map<String,dynamic>> messData;
 LoadArticlesEvent({required this.messData});
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
// Stream<QuerySnapshot> stream;
List<Map<String,dynamic>> stream;
  LoadArticleProgress({required this.stream});
}
class ArticleErrorState extends ArticleState{
  const ArticleErrorState();
}


class LoadingProcessState extends ArticleState{
  const LoadingProcessState();
}


class MessageBloc extends Bloc<ArticleEvent,ArticleState>{
final String idchat;


  MessageBloc({required this.idchat}) : super(LoadArticleBegin()) {
    print('NEW${idchat}');
    on<ArticleEvent>((event,emit)async{
      if(event is LoadArticlesEvent){
        emit(LoadArticleProgress(stream:event.messData));
     //   await loadArticleData(event, emit);
      }else if(event is DataArticlesEvent){

      }
    });
loadArticleData();
  }
//сдел для чата свой айдишник и всё
  Future<void> loadArticleData(

      ) async {
 List<Map<String,dynamic>> messData = [];
   //final CollectionReference usersStream =  FirebaseFirestore.instance.collection('messages');
   final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance.collection('messages')
        .where('idchat', isEqualTo: idchat).orderBy('time',descending: true).snapshots();
  emit(const LoadingProcessState());
  usersStream.listen((value)async{
     // print('${value}totallllllllllll');
       // print("doc${doc}}doc");
       for (var d in value.docs) {
         final docMessData = d.data() as Map<String, dynamic>;
     /* if(docMessData['images']!=null){
       final String img = await FirebaseStorage.instance.refFromURL("gs://glot-c5df4.appspot.com/images/${docMessData['images'] as String}").getDownloadURL().then((value){
            return value.isNotEmpty? value :'';
          });
       print("imgimg${img}");
         docMessData['images'] = img;
        }*/
         messData.add(docMessData);
         //print("d${d}}d");
         print("mesmesmes${d.id} => ${docMessData['name']}mesmesmes");
       }

     messData.sort((a, b) =>
     int.parse(b['time'].toString()) -
         int.parse(a['time'].toString()));


     print('messFinishData'
         '0 ${messData.toString()}');
       print('stream${usersStream}');

       add(LoadArticlesEvent(messData: messData));
   });
    /*final Stream<QuerySnapshot<Map<String,dynamic>>> usersStream1 = FirebaseFirestore.instance.
    collection('messages').where('name', isEqualTo: 'dasha').where('to', isEqualTo: 'dina').snapshots();*/
  //  List<Stream<QuerySnapshot<Map<String,dynamic>>>> combineList = [usersStream1,usersStream];
   // var totalRef = CombineLatestStream.list(combineList);
   /* await for (var value in usersStream) {
      print('CONTROLLER${value.docs}');
      controller.add(value);
    }*/
    // controller as Stream<QuerySnapshot>

  }
}








