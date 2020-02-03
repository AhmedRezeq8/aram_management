import 'package:aram_management/src/ui/home/video_list.dart';
import 'package:aram_management/src/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class TabHomeScreen extends StatefulWidget {
  const TabHomeScreen({Key key}) : super(key: key);

  @override
  _TabHomeScreenState createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> {
SharedPreferences sharedPrefs;
getLoginUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int intValue = prefs.getInt('userid');
  print(intValue);
  return intValue;
}
@override
void initState() {
  super.initState();
  getLoginUserId();
  //  int intValue = sharedPrefs.getInt('userid');
  // print(intValue);

}
  
  @override
  Widget build(BuildContext context) {
 return  DefaultTabController(
          length: 5,
          child: Scaffold(
           
            appBar: ShiftingTabBar(
              // Specify a color to background or it will pick it from primaryColor of your app ThemeData
              color: Colors.amber,

              // You can change brightness manually to change text color style to dark and light or
              // it will decide based on your background color
              // brightness: Brightness.dark,
              tabs: [
                // Also you should use ShiftingTab widget instead of Tab widget to get shifting animation
                ShiftingTab(icon: Icon(FontAwesomeIcons.tasks), text: "جميع المواد"),
                ShiftingTab(icon: Icon(FontAwesomeIcons.torah), text: "Test 2"),
                ShiftingTab(icon: Icon(FontAwesomeIcons.wallet), text: "Test 3"),
                // ShiftingTab(
                //   icon: Icon(Icons.directions_transit),
                //   text: "Test 4"
                // ),
                // ShiftingTab(
                //   icon: Icon(Icons.directions_boat),
                //   text: "Test 5"
                // ),
              ],
            ),
            body: TabBarView(
              children: [
                VideoScreen(),
                LoginScreen(),
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_boat),
              ],
            ),
          ),
        );

  }
}