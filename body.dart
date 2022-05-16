import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => MyBody();
}

class MyBody extends State<Body>{

  List task = <String>[];

  interior(task){
    if(task.isEmpty){
      return Center(
        child: Column(
        children: [
          Icon(
            Icons.list_alt,
          ),
          Text("List is empty"),
        ]
        ),
      );
    }
    else{
      return Row(
        children: [
          Text(task[0]),
          Text(task[1]),
        ],
      );
    }
  }

  Widget build(BuildContext context){
    return Container(
      child: interior(task),
    );
  }
}
