import 'package:aram_management/src/model/user.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  final String baseUrl = "http://46.101.250.202/ahmed/aramapi/public";
  Client client = Client();

  Future<List<User>> getUsers() async {
    final response = await client.get("$baseUrl/users/get");
    if (response.statusCode == 200) {
      var body = userFromJson(response.body);

      return body;
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
    if (response.statusCode == 201 || response.statusCode == 200) {
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

// check if user exsist and save user data

  _loginUser(int userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    await prefs.setInt('userid', userid);
  }

  Future<bool> getLoginUsers(String userEmail, String password) async {
    final response =
        await client.get("$baseUrl/userlogin/get/$userEmail/$password");
    if (response.statusCode == 200) {
      bool isSucsess = false;
      try {
        var body = userrFromJson(response.body);
        _loginUser(int.parse(body.userId));
        print(body.userName);
        isSucsess = true;
      } catch (e) {
        print(e.toString());
      }

      return isSucsess;
    } else {
      return false;
    }
  }
}
