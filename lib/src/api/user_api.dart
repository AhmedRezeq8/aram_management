
import 'package:aram_management/src/model/user.dart';
import 'package:http/http.dart' show Client;

class UserApi {
  final String baseUrl = "http://46.101.250.202/ahmed/aramapi/public";
  Client client = Client();

  Future<List<User>> getUsers() async {
    final response = await client.get("$baseUrl/users/get");
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createUser(User data) async {
    final response = await client.post(
      "$baseUrl/user/post",
      headers: {"content-type": "application/json"},
      body: userToJson(data),
    );
    if (response.statusCode == 201||response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(User data) async {
    final response = await client.put(
      "$baseUrl/user/put/${data.userId}",
      headers: {"content-type": "application/json"},
      body: userToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteUser(String id) async {
    final response = await client.delete(
      "$baseUrl/user/delete/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
