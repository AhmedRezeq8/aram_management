import 'package:aram_management/src/api/user_api.dart';
import 'package:aram_management/src/model/user.dart';
import 'package:flutter/material.dart';

class LoginTest extends StatefulWidget {

  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {



  @override
  void initState() {

    super.initState();

    UserApi();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text('Title'),
         ),
         body: FutureBuilder(
           future: UserApi().getUsers(),
           builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
             if(snapshot.hasData)
        for (var item in snapshot.data) {
          print(item.userName);
        }
          return Center(child: CircularProgressIndicator(),);
           },
         ),
       ),
    );
  }
}