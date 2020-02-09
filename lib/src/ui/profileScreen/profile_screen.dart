import 'package:aram_management/src/ui/home/home_main.dart';
import 'package:aram_management/src/ui/signScreens/sign_screen.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Parent(
                style: ParentStyle()
                  ..height(MediaQuery.of(context).size.height * .3)
                  ..width(double.infinity)
                  ..elevation(5, color: Color(0xff1F54C3), opacity: .3),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Image.asset('assets/images/profile.png'),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(icon: Icon(Icons.settings), onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
                      Route route =
                          MaterialPageRoute(builder: (context) => HomeMain());

                      Navigator.push(context, route);
                    }),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .23,
              right: 0,
              left: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://scontent.fbtz1-4.fna.fbcdn.net/v/t1.0-9/39467861_1974066275972645_1391056009283239936_n.jpg?_nc_cat=102&_nc_ohc=rtuEl8w7iAkAX9lDBXI&_nc_ht=scontent.fbtz1-4.fna&oh=8c8f7b71562e1e3c36dd33e49e48b228&oe=5EC625AC',
                            scale: 20),
                        radius: 50,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Txt(
                              'أحمد نصرالله',
                              style: TxtStyle()
                                ..fontSize(22)
                                ..fontWeight(FontWeight.w700),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Txt(
                              'مونتير',
                              style: TxtStyle()
                                ..fontSize(18)
                                ..fontWeight(FontWeight.w400)
                                ..textColor(Color(0xff1F54C3)),
                            ),
                          ],
                        ),
                      ),
                      Txt(
                        'sherlock.am8@gmail.com',
                        style: TxtStyle()
                          ..fontSize(14)
                          ..fontWeight(FontWeight.w400)
                          ..textColor(Color(0xffE93354)),
                      ),
                    ],
                  ),
                  Parent(
                      style: ParentStyle()
                        ..height(MediaQuery.of(context).size.height * .2)
                        ..width(MediaQuery.of(context).size.width * .8)
                        ..elevation(5, color: Color(0xff1F54C3), opacity: .3),
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Txt(
                                  'تم المونتاج',
                                  style: TxtStyle()
                                    ..fontSize(22)
                                    ..fontWeight(FontWeight.w500),
                                ),
                                Txt(
                                  '900',
                                  style: TxtStyle()
                                    ..fontSize(22)
                                    ..fontWeight(FontWeight.w500)
                                    ..textColor(Color(0xff2ED573)),
                                ),
                              ],
                            ),
                            Divider(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Txt(
                                  'قيد المونتاج',
                                  style: TxtStyle()
                                    ..fontSize(22)
                                    ..fontWeight(FontWeight.w500),
                                ),
                                Txt(
                                  '4',
                                  style: TxtStyle()
                                    ..fontSize(22)
                                    ..fontWeight(FontWeight.w500)
                                    ..textColor(Color(0xffE73355)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),

                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Txt('تسجيل خروج',
                  //       style: TxtStyle()
                  //         ..alignment.center()
                  //         // ..background.color(Color(0xffE93354))
                  //         ..textColor(Color(0xffE93354))
                  //         ..borderRadius(all: 5)
                  //         ..border(all: 2, color: Color(0xffE93354))
                  //         ..padding(vertical: 10, horizontal: 15)
                  //       // ..width(MediaQuery.of(context).size.width*.3)
                  //       // ..ripple(true)
                  //       // ..animate(150, Curves.easeOut)
                  //       ,
                  //       gesture: Gestures()),
                  // )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(),
                FlatButton.icon(
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Color(0xffE93354),
                  ),
                  label: Txt('تسجيل خروج',
                      style: TxtStyle()
                        ..alignment.center()
                        ..textColor(Color(0xffE93354))
                        ..padding(vertical: 10, horizontal: 15)),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('userid');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => SignInUPScreen()));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
