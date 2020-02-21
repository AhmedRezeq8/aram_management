import 'package:aram_management/src/provaiders/public_provaider.dart';
import 'package:aram_management/src/provaiders/user_provider.dart';
import 'package:aram_management/src/ui/home/home_main.dart';
import 'package:aram_management/src/ui/profileScreen/profile_screen.dart';
import 'package:aram_management/src/ui/signScreens/sign_screen.dart';
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

//////////////////               check if userID exst              //////////////////////////////////////
  int _userID = 0;
  Future<int> getLoginUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int intValue = prefs.getInt('userid');

    return intValue == null ? 0 : intValue;
  }
  void _updateUserId(int userId) {
    setState(() {
      this._userID = userId;
    });
  }
/////////////////////////////           end             /////////////////////////////////////////////////
///
///
 
  @override
  void initState() {
    getLoginUserId().then(_updateUserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SelectedVideoTypeProvider()),
        ChangeNotifierProvider(create: (ctx) => SelectedDomainProvider()),
        ChangeNotifierProvider(create: (ctx) => UserProvider()),
        ChangeNotifierProvider(create: (ctx) => SelectedVideoStatusProvider()),
        ChangeNotifierProvider(create: (ctx) => SelectedSginProvider()),
      ],
      child: BotToastInit(
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'ArabicModern'),
          // theme: ThemeData.dark(),
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
          home: _userID > 0 ? HomeMain() : SignInUPScreen(),
        ),
      ),
    );
  }
}