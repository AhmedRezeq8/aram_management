import 'package:aram_management/src/ui/formadd/video_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/ui/home/home_screen.dart';
import 'src/ui/home/video_list.dart';

void main() => runApp(MyApp());
GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar'), // English
      ],
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text('إدارة آرام'),
          actions: <Widget>[
            GestureDetector(onTap: (){
              Navigator.push(
            _scaffoldState.currentContext,
            MaterialPageRoute(builder: (BuildContext ctx){
              return VideoAddScreen();
            }),
            );
          
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child:Icon( Icons.add),
            ),)
          ],
        ),
        body: VideoScreen(),
      ),
    );
  }
}
