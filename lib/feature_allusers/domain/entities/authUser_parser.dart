import 'package:equatable/equatable.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class User extends Equatable {
  final String name;
  final String job;
  final String activity;
  final String email;
  final String country;
  final String age;
  final String story;
  final String language;
  final String userid;
  final String date;
  final String image;
  final String password;

  const User({ required this.name,required this.job,required this.activity,required this.email,required this.country,
    required this.age,required this.story,required this.language,required this.userid,required this.date, required this.image,required this.password});


  factory User.fromJson(Map<String, dynamic> json) {
    return  User(
      userid: json['userid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      country: json['country'] as String,
      job: json['job'] as String,
      activity: json['activity'] as String,
      language: json['language'] as String,
      date: json['date'] as String,
      story: json['story'] as String,
      age: json['age'] as String,
      image: json['image'] as String,
      password: json['password'] as String,
    );
  }

  static String hashSHA512(String text) {
    return sha512.convert(utf8.encode(text)).toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'name': name,
      'activity': activity,
      'email': email,
      'age': age,
      'country': country,
      'story': story,
      'language': language,
      'job': job,
      'date': date,
      'image':image,
      'password':hashSHA512(password)
    };
  }

  @override
  List<Object?> get props => [
    userid,
    name,
    activity,
    email,
    country,
    age,
    story,
    language,
    job,
    date,
    image,
    password,
  ];
}


