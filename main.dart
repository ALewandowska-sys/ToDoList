import 'package:flutter/material.dart';
import './task.dart';

void main() => runApp(MyAplication());

class MyAplication extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateAplication();
  }
}

class StateAplication extends State<MyAplication>{

  @override
  Widget build(BuildContext centext){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('To do list'),
        ),
        body: Column(
          children: [

            Text('Done'),
            Task('Some task'),
          ],
        ),
    ),
    );
  }
}
