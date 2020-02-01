import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String userId;
  String userName;
  String userEmail;
  String userTypeId;
  String userPassword;
  String userImage;
  String userTypeName;

  int loginUser = 0;
  int get userIdLogin => loginUser;

  set userIdLogin(int val) {
    loginUser = val;
    notifyListeners();
  }

  // int _count = 0;
  // int get count => _count;

  // set count(int val) {
  //   _count = val;
  //   notifyListeners();
  // }
}
