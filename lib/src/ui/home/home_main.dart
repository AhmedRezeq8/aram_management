import 'package:flutter/material.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {

final pgControler = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
         
          PageView(
            controller: pgControler,
            children: <Widget>[
              Container(
               decoration: BoxDecoration(
                 color: Colors.amber
               ),
                ),
              Container(),
              Container(),
            ],

          ),
        ],
      ),
    );
     
  
  }
}