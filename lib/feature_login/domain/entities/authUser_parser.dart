import 'package:equatable/equatable.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class UserLogin extends Equatable {
  final String email;
  final String password;

const UserLogin({required this.email,required this.password});


  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return  UserLogin(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  static String hashSHA512(String text) {
    return sha512.convert(utf8.encode(text)).toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password':hashSHA512(password)
    };
  }

  @override
  List<Object?> get props => [
    email,
    password,
  ];
}


