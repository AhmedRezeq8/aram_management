import 'package:aram_management/src/ui/home/video_list.dart';
import 'package:aram_management/src/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class TabHomeScreen extends StatelessWidget {
  const TabHomeScreen({Key key}) : super(key: key);

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