import 'package:aram_management/src/api/user_api.dart';
import 'package:aram_management/src/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  TextEditingController _controllerPassword = TextEditingController();
  UserApi userApi;

  @override
  void initState() {
    super.initState();
    getLoginUserId();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Column(
      children: <Widget>[
      
    Container(
          width: queryData.size.width - 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.2),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controllerUsername,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "اسم المستخدم",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 12.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),  Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.2),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "البريد الإلكتروني",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 12.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF6078ea).withOpacity(.2),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    controller: _controllerPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "كلمة المرور",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 12.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF1D55C5), Color(0xFFE93354)]),
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF6078ea).withOpacity(.3),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0)
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        User _user =User(userEmail: _controllerEmail.text,userName: _controllerUsername.text,userPassword: _controllerPassword.text);
                         UserApi().createUser(_user).then((value) => print(value.toString()));
                        // UserApi()
                        //     .getLoginUsers(this._controllerEmail.text,
                        //         this._controllerPassword.text)
                        //     .then((isSuccess) {
                        //   if (isSuccess) {
                        //     getLoginUserId();
                        //     Route route = MaterialPageRoute(
                        //         builder: (context) => HomeMain());

                        //     Navigator.push(context, route);
                        //   } else {
                        //     print('not loged in !!');
                        //   }
                        // });
                      },
                      child: Center(
                          child: Text(
                        'حفظ',
                        style: TextStyle(
                            fontFamily: 'ArabicModern',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              
              Divider(
                color: Colors.black45,
              ),
            ],
          ),
        )
      ],
    );
  }
}

getLoginUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int intValue = prefs.getInt('userid');
  // print(intValue);
  return intValue;
}
