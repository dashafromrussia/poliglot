import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/entities/user.data.dart';


abstract class PersonRemoteDataSource {

  /// Throws a [ServerException] for all error codes.
 // Future<List<PersonModel>> getAllPersons(int page);

  /// Throws a [ServerException] for all error codes.
  Future<bool>sendUserData(User user);
  Future<List<User>>getUserData();
  Future<bool>sendCode(String code,String email);
}



class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
 // final HttpClient client;
final http.Client client;
  PersonRemoteDataSourceImpl({required this.client});


 /* @override
  Future<bool>sendUserData(User user)async{
    final url = Uri.parse('http://192.168.1.2:3500/adduser');
    final String parameters = jsonEncode(user.toJson());
    final request = await client.postUrl(url);
    request.headers.add('Content-type', 'application/json; charset=UTF-8');
    request.write(parameters);
    final response = await request.close();


   /* final String parameters = jsonEncode(user.toJson());
    final url = Uri.parse('');
    print("${parameters}userrr");
    final response = await client
        .post(Uri.parse("http://localhost/addusers"), headers: {'Content-Type': 'application/json'}, body:{'data':'1'});
       client.close();*/
    if (response.statusCode == 200) {
      final string = await response
          .transform(utf8.decoder)
          .toList()
          .then((value) => value.join());
      final json = jsonDecode(string) as int;
    // final insertId = json.decode(response.body);
      print(json);
    return true;
    } else {
      print('Errrorrr');
      throw ServerException();
    }

    }*/
//Uri.parse('http://192.168.1.2:3500/adduser')
  //; charset=UTF-8
  @override
  Future<bool>sendUserData(User user)async{
    final String parameters = jsonEncode(user.toJson());
    print("${parameters}user");
    var uri = Uri.http('192.168.1.5:3500', 'adduser');
    final response = await client
        .post(uri, headers: {"Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*'}, body:parameters);
       client.close();
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
  Future<List<User>>getUserData() async {
    var uri = Uri.http('192.168.1.5:3500', 'loadusers');
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
  Future<bool> sendCode(String code, String email) async {
   final String parameters = jsonEncode({'code':code,'email':email});
   print("${parameters}user");
   var uri = Uri.http('192.168.1.5:3500', 'sendmess');
   final response = await client
       .post(uri, headers: {"Access-Control-Allow-Origin": "*",
     'Content-Type': 'application/json; charset=UTF-8',
     'Accept': '*/*'}, body:parameters);
   client.close();
   if (response.statusCode == 200) {
     final data = json.decode(response.body);
     print(data);
     return true;
   } else {
     print('Errrorrr');
     throw ServerException();
   }
  }
  }


  /*  await fetch("http://192.168.0.12:3500/sendmess", {
    method: 'POST', // *GET, POST, PUT, DELETE, etc.
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: JSON.stringify({email:forget,code:text}),
})
    .then(response => response.text())
    .then(response =>
    console.log(response,'resp')
    )*/


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

