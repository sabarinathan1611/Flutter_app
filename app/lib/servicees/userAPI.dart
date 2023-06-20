import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/models/user.dart';

class UserApi {
  Future<List<User>?> getAllUser() async {
    var client = http.Client();
    //http://192.168.1.8/:5000/user
    var uri = Uri.parse("http://192.168.1.8:5000/user");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
  }

  //Add New User
  Future<User> addUser(String name, String contact) async {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.1.8:5000/user");
    final http.Response response = await client.post(uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',

        },
        body: jsonEncode(<String, String>{'name': name, 'contact': contact}));
    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    }else{
      throw Exception("Faild to Save User");
    }
  }

  //Delete User
  Future<User> deleteUser(int id) async {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.1.8:5000/user/$id");
    final http.Response response = await client.delete(uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',

        },
        );
    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    }else{
      throw Exception("Faild to Delete User");
    }
  }

  //Update User
  Future<User> updateUser(String name, String contact,int id) async {
    var client = http.Client();
    var uri = Uri.parse("http://192.168.1.8:5000/user/$id");
    final http.Response response = await client.put(uri,
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8',

        },
        body: jsonEncode(<String, String>{'name': name, 'contact': contact}));
    if (response.statusCode == 200) {
      var json = response.body;
      return User.fromJson(jsonDecode(json));
    }else{
      throw Exception("Faild to Update User");
    }
  }
}

