import 'package:aram_management/src/provaiders/public_provaider.dart';
import 'package:aram_management/src/provaiders/user_provider.dart';
import 'package:aram_management/src/ui/home/tab_screen.dart';
import 'package:aram_management/src/ui/login_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  getLoginUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt('userid');
    userID = intValue;
    return intValue;
  }

  int userID = 0;

  @override
  void initState() {
     getLoginUserId();
     print(userID);
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SelectedVideoTypeProvider()),
        ChangeNotifierProvider(create: (ctx) => SelectedDomainProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
      ],
      child: BotToastInit(
        child: MaterialApp(
          navigatorObservers: [BotToastNavigatorObserver()],
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
          home: userID>0? TabHomeScreen(): LoginScreen(),
        
        ),
      ),
    );
  }
}










/////////////////////////////////////////////////////////////////////////



// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.orange,
//         accentColor: Colors.orangeAccent,
//       ),
//       home: Scaffold(
//         key: _scaffoldState,
//         appBar: AppBar(
//           title: Text(
//             "Flutter CRUD API",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           actions: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   _scaffoldState.currentContext,
//                   MaterialPageRoute(builder: (BuildContext context) {
//                     return FormAddScreen();
//                   }),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 16.0),
//                 child: Icon(
//                   Icons.add,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: HomeScreen(),
//       ),
//     );
//   }
// }
