import 'package:aram_management/src/fade_animation.dart';
import 'package:aram_management/src/provaiders/public_provaider.dart';
import 'package:aram_management/src/ui/signScreens/sign_in_widget.dart';
import 'package:aram_management/src/ui/signScreens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInUPScreen extends StatefulWidget {
  SignInUPScreen({Key key}) : super(key: key);

  @override
  _SignInUPScreenState createState() => _SignInUPScreenState();
}

class _SignInUPScreenState extends State<SignInUPScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    SelectedSginProvider signSelected =
        Provider.of<SelectedSginProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Consumer<SelectedSginProvider>(
                builder: (ctx, signSelected, _) => FadeAnimation(
                  .3,
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: signSelected.index == 1
                              ? AssetImage('assets/images/login.png')
                              : AssetImage('assets/images/signup.png')),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      offset: Offset(0, 10),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        signSelected.index = 1;
                      },
                      child: Consumer<SelectedSginProvider>(
                        builder: (ctx, signSelected, _) => Container(
                          child: Center(
                              child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                fontFamily: 'ArabicModern',
                                fontWeight: signSelected.index == 1
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                fontSize: 16),
                          )),
                          height: 70,
                          width: queryData.size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                  color: Color(0xff1F54C3),
                                  width: 5,
                                  style: signSelected.index == 1
                                      ? BorderStyle.solid
                                      : BorderStyle.none),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        signSelected.index = 2;
                      },
                      child: Consumer<SelectedSginProvider>(
                        builder: (ctx, signSelected, _) => Container(
                          height: 70,
                          child: Center(
                              child: Text(
                            'إنشاء حساب',
                            style: TextStyle(
                                fontFamily: 'ArabicModern',
                                fontWeight: signSelected.index == 1
                                    ? FontWeight.w500
                                    : FontWeight.w700,
                                fontSize: 16),
                          )),
                          width: queryData.size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                  color: Color(0xff1F54C3),
                                  width: 5,
                                  style: signSelected.index == 1
                                      ? BorderStyle.none
                                      : BorderStyle.solid),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<SelectedSginProvider>(builder: (ctx, signSelected, _) {
                return signSelected.index == 1 ? SignIn() : SignUp();
              }),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                .2,
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/socialmedia.png')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
