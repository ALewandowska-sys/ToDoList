import 'package:flutter/material.dart';
import 'task.dart';

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
        child: Opacity(
            opacity: 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.list_alt,
                  size: 70,
                ),
                Text('Add some task',
                    style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
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
