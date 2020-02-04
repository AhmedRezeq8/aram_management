import 'dart:math' as Math;
import 'package:aram_management/src/ui/home/video_list.dart';
import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

// package doc: https://pub.dev/packages/transformer_page_view

class TransformerPageViewDemoPage extends StatelessWidget {
  final List<Color> colorList = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Theme.of(context).primaryColorDark,
     
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
             Expanded(
              child:  TransformerPageView(
                  loop: false,
                  itemBuilder: (BuildContext context, int index) {
                    return  VideoScreen();
                    //  Container(
                    //   decoration: BoxDecoration(
                    //       // color: colorList[index % colorList.length],
                    //       // border: Border.all(color: Colors.white),
                    //       ),
                    //   child:  Center(
                    //     child:  Text(
                    //       "$index",
                    //       style:  TextStyle(
                    //           fontSize: 80.0, color: Colors.white),
                    //     ),
                    //   ),
                    // );
                  },
                  itemCount: 5),
            ),
           
          ],
        ),
      ),
    );
  }
}
