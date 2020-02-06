import 'package:aram_management/src/api/user_api.dart';
import 'package:aram_management/src/ui/home/home_main.dart';
import 'package:aram_management/src/ui/home/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controllerUserName = TextEditingController();

  TextEditingController _controllerPassword = TextEditingController();

  UserApi userApi;


  @override
  void initState() {
    super.initState();
    getLoginUserId();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
          

                color: Colors.grey,
              ),
            ]),
            width: 350,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("تسجيل دخول",
                      style: TextStyle(
                          fontSize: 15,
                          // fontFamily: "Poppins-Bold",
                          letterSpacing: .6)),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _controllerUserName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "إسم المستخدم",
                        hintStyle: TextStyle(fontSize: 12.0)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _controllerPassword,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "كلمة المرور",
                        hintStyle: TextStyle(fontSize: 12.0)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "نسيت كلمة المرور ؟",
                        style: TextStyle(
                            color: Colors.blue,
                            // fontFamily: "Poppins-Medium",
                            fontSize: 20),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: Container(
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                          borderRadius: BorderRadius.circular(6.0),
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
                            UserApi()
                                .getLoginUsers(this._controllerUserName.text,
                                    this._controllerPassword.text)
                                .then((isSuccess) {
                              if (isSuccess) {
                                getLoginUserId();
                                Route route = MaterialPageRoute(
                                    builder: (context) => HomeMain());

                                Navigator.push(context, route);
                              } else {
                                print('not loged in !!');
                              }
                            });
                            ;

                            //  print(userid.loginUser);
                          },
                          child: Center(
                            child: Text("تسجيل الدخول",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins-Bold",
                                    fontSize: 18,
                                    letterSpacing: 1.0)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
