import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:poliglot/core/error/exeption.dart';
import 'package:poliglot/feature_login/domain/entities/authUser_parser.dart';


abstract class PersonRemoteDataSourceLog {

  /// Throws a [ServerException] for all error codes.
 // Future<List<PersonModel>> getAllPersons(int page);

  /// Throws a [ServerException] for all error codes.
  Future<bool>getUserData(UserLogin user);
}



class PersonRemoteDataSourceLogin implements PersonRemoteDataSourceLog {
  // final HttpClient client;
  final http.Client client;

  PersonRemoteDataSourceLogin({required this.client});


  @override
  Future<bool> getUserData(UserLogin user) async {
    final String parameters = jsonEncode(user.toJson());
    var uri = Uri.http('192.168.1.5:3500', 'getuser');
    final response = await client
        .post(uri,
        headers: {"Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'}, body: parameters);
       client.close();
    if (response.statusCode == 200) {
      print("RESPO${response.body}respose");
      final persons = json.decode(response.body);
      print('${persons}pesons');
      if ((persons as List)
          .map((person) => UserLogin.fromJson(person))
          .toList()
          .length == 1) {
        return true;
      }else{
        return false;
      }
    } else {
      throw ServerException();
    }
  }

 /* @override
  Future<bool> sendCode(String code, String email) async {
    final String parameters = jsonEncode({'code':code,'email':email});
    print("${parameters}user");
    var uri = Uri.http('192.168.1.5:3500', 'sendmess');
    final response = await client
        .post(uri, headers: {"Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '}, body:parameters);
    client.close();
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return true;
    } else {
      print('Errrorrr');
      throw ServerException();
    }
  }*/


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
