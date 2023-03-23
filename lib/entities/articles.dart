import 'package:equatable/equatable.dart';
import 'dart:convert';

class Articles extends Equatable {
  final int id;
  final String image;
  final String category;
  final String time;
  final int views;
  final String header;
  final String twoheader;
  final String text;
  final List<String> likes;


  const Articles({ required this.id,required this.image,required this.category,required this.time,required this.views,
    required this.header,required this.twoheader,required this.text,required this.likes});


  factory Articles.fromJson(Map<String, dynamic> jsonn) {
    return  Articles(
      id: jsonn['id'] as int,
      image: jsonn['image'] as String,
      category: jsonn['category'] as String,
      time: jsonn['time'] as String,
      views: jsonn['views'] as int,
      header: jsonn['header'] as String,
      twoheader: jsonn['twoheader'] as String,
      text: jsonn['text'] as String,
      likes: (json.decode(jsonn['likes']) as List<dynamic>).map((e)=> e as String).toList(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'time': time,
      'views': views,
      'header': header,
      'twoheader': twoheader,
      'text': text,
      'likes': jsonEncode(likes),
      'image':image,
    };
  }

  Articles copyWith({
    int? currentId,
    String? curcategory,
    String? curtime,
    int? curviews,
    String? curheader,
    String? curtwoheader,
    String? curtext,
    List<String>? curlikes,
    String? curimage,
  }) {
    return Articles(
      id: currentId ?? id,
      category: curcategory ?? category,
      time: curtime ?? time,
      views: curviews ?? views,
      header: curheader ?? header,
      twoheader: curtwoheader ?? twoheader,
      text: curtext ?? text,
      likes: curlikes ?? likes,
      image: curimage ?? image
    );
  }

  @override
  List<Object?> get props => [
   id,
  category,
   time,
   views,
  header,
   twoheader,
   text,
   likes,
   image,
  ];
}

/*class AppCount extends AppState {
  final int count;
 const AppCount({required this.count});

  @override
  List<Object> get props => [count];

AppCount copyWith({
    int? currentCount,
  }) {
    return AppCount(
      count: currentCount ?? count,
    );
  }
}*/
