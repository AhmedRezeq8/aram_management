import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 
  @override
  Widget build(BuildContext context) {
      MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
         
          children: <Widget>[
            Container(
              height: 280,
                          child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.settings), onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.navigate_next), onPressed: () {}),
                    ],
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/profile.png')),
                          
                    ),
                    
                  ),
                  Positioned(
                      top: 170,
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
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("أحمد نصرالله"),
                    SizedBox(width: 10,),
                      Text("مونتير"),
                  ],
                ),
                  Text("AbuBateekha@gmail.com"),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
