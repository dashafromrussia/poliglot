import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/entities/user.data.dart';
import 'package:poliglot/entities/articles.dart';
import 'package:poliglot/entities/userLogin.dart';


abstract class PersonRemoteDataSource {

  /// Throws a [ServerException] for all error codes.
  // Future<List<PersonModel>> getAllPersons(int page);
  /// Throws a [ServerException] for all error codes.
  Future<List<UserLogin>>getUserData(UserLogin user);
  Future<bool> sendCode(String code, String email);
  Future<bool>sendUserData(User user);
  Future<List<User>>getUsersData();
  Future<List<User>> findDataEmail(String email);
  Future<bool> updatePassword(UserLogin user);
  Future<bool> updateUser(User user);
  Future<List<Articles>>getArticlesData();
  Future<Articles>getOneArticlesData(int id);
  Future<bool> updateView(int id, int views);
  Future<bool> updateLike(Map<String,dynamic> data);
  Future<bool> getData();
}

//https://jsonplaceholder.typicode.com/todos/1

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
   final HttpClient clients;
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client,required this.clients});

  @override
  Future<bool> getData()async{
    final request = await clients.postUrl(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    final response = await request.close();
   final data = response.transform(utf8.decoder);
   print(data);
    return true;
  }



  @override
  Future<List<UserLogin>> getUserData(UserLogin user) async { //ищет чувака по майлу и паролю
    final String parameters = jsonEncode(user.toJson());
    print("params${parameters}");
    var uri = Uri.http('192.168.0.114:3500', 'getuser');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: parameters);
   // client.close();
    if (response.statusCode == 200) {
      print("RESPO${response.body}respose");
      final persons = json.decode(response.body);
      print('${persons}pesons');
   final List<UserLogin> data = (persons as List)
          .map((person) => UserLogin.fromJson(person)).toList();
     return data; //если длина массива 1,то вернуть тру
    } else {
      throw ServerException();
    }
  }


  @override
  Future<List<User>> findDataEmail(String email) async { //ищет чувака по майлу
    final String parameters = jsonEncode({'email':email});
    var uri = Uri.http('192.168.0.114:3500', 'findemail');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: parameters);
  //  client.close();
    if (response.statusCode == 200) {
      print("RESPO${response.body}respose выбор по емайл");
      final persons = json.decode(response.body);
      print('${persons}pesons');
      final List<User> data = (persons as List)
          .map((person) => User.fromJson(person)).toList();
      return data; //если длина массива 1,то вернуть тру
    } else {
      throw ServerException();
    }
  }

  
  @override
  Future<bool> updatePassword(UserLogin user) async { //заменяем пароль
    final String parameters = jsonEncode(user.toJson());
    var uri = Uri.http('192.168.0.114:3500', 'updatepassword');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: parameters);
   // client.close();
    if (response.statusCode == 200) {
      final data = response.body;
      print('${data}РЕСПОНС update');
      return true;
    } else {
      throw ServerException();
    }
  }


  @override
  Future<bool> updateUser(User user) async { //обновляем данные пользв
    final String parameters = jsonEncode(user.toJson());
    var uri = Uri.http('192.168.0.114:3500', 'updateuser');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: parameters);
   // client.close();
    if (response.statusCode == 200) {
      final data = response.body;
      print('${data}РЕСПОНС update олл дата');
      return true;
    } else {
      throw ServerException();
    }
  }


  @override
  Future<bool> sendCode(String code, String email) async {
    final String parameters = jsonEncode({'code':code,'email':email});
    print("${parameters}user");
    var uri = Uri.http('192.168.0.114:3500', 'sendmess');
    final response = await client
        .post(uri, headers: {"Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept':'*/*'}, body:parameters);
   // client.close();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('code');
      print(data);
      return true;
    } else {
      print('Errrorrr');
      throw ServerException();
    }
  }





  @override
  Future<bool>sendUserData(User user)async{     //добавл пользов
    final String parameters = jsonEncode(user.toJson());
    print("${parameters}user");
    var uri = Uri.http('192.168.0.114:3500', 'adduser');
    final response = await client
        .post(uri, headers: {"Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*'}, body:parameters);
   // client.close();
    if (response.statusCode == 200) {
      final insertId = json.decode(response.body);
      print(insertId);
      return true;
    } else {
      print('Errrorrr');
      throw ServerException();
    }
  }

  @override
  Future<List<User>>getUsersData() async { //грузит всех пользов
    var uri = Uri.http('192.168.0.114:3500', 'loadusers');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'},body:jsonEncode([]));
    if (response.statusCode == 200) {
      print("RESPO${response.body}respose");
      final persons = json.decode(response.body);
      print('${persons}pesons');
      return (persons as List)
          .map((person) => User.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }


  @override
  Future<List<Articles>>getArticlesData() async { //грузит все articles
    var uri = Uri.http('192.168.0.114:3500', 'loadarticles');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'},body:jsonEncode([]));
    if (response.statusCode == 200) {
      print("RESPO${response.body}respose");
      final articles = json.decode(response.body);
      print('${articles}articles');
      return (articles as List)
          .map((articles) => Articles.fromJson(articles))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Articles>getOneArticlesData(int id) async { //onearticles
    final String parameters = jsonEncode({'id':id});
    var uri = Uri.http('192.168.0.114:3500', 'loadonearticles');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: parameters);
    client.close();
    if (response.statusCode == 200) {
      print("RESPO${response.body}respose one articles");
      final articles = json.decode(response.body);
      print('${articles}pesons');
      final List<Articles> data = (articles as List)
          .map((article) => Articles.fromJson(article)).toList();
      return data[0];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateLike(Map<String,dynamic>data) async { //обновляем лайки
    final String parameters = jsonEncode(data);
    var uri = Uri.http('192.168.0.114:3500', 'updatelikes');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: parameters);
    client.close();
    if (response.statusCode == 200) {
      final data = response.body;
      print('${data}РЕСПОНС update like');
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateView(int id, int views) async { //обновляем просмотры
    final String parameters = jsonEncode({'id':id, 'views':views});
    var uri = Uri.http('192.168.0.114:3500', 'updateviews');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: parameters);
    client.close();
    if (response.statusCode == 200) {
      final data = response.body;
      print('${data}РЕСПОНС update view');
      return true;
    } else {
      throw ServerException();
    }
  }


/*void _validateResponse(http.Response response, dynamic json) {
    if (response.statusCode == 401) {
      final dynamic status = json['status_code'];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiAuthClientException();
      } else if (code == 3) {
        throw ApiSessionClientException();
      } else {
        throw ApiOtherClientException();
      }
    }
  }
}*/


/*Future<Post> createPost({required String title, required String body}) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109
    };
    final request = await client.postUrl(url);
    request.headers.add('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final string = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join());
    final json = jsonDecode(string) as Map<String, dynamic>;
    final post = Post.fromJson(json);
    return post;
  }*/


/*Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerException();
    }
  }*/
}