// import 'dart:convert';

// import 'package:aram_management/src/model/video.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// class Test extends StatefulWidget {
//   Test({Key key}) : super(key: key);

//   @override
//   _TestState createState() => _TestState();
// }


// class _TestState extends State<Test> {


//   Future<List<Video>> getdata(id) async{
//     var response =  await http.get('http://46.101.250.202/ahmed/aramapi/public/videos/get');


//     var data = videoFromJson(response.body);

//    return data;


//   }

// @override
//   void initState() {
//     super.initState();
//     getdata();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: FutureBuilder(
//         future: getdata(),
//         builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {

//          return  snapshot.hasData?  ListView.builder(
//             itemCount:snapshot.data.length,
//             itemBuilder: (BuildContext context, int i) {
//             return Text(snapshot.data[i].videoTitle);
//            },
//           ) : Center(child: CircularProgressIndicator(),);
//         },
//       ),
//     );
//   }
// }