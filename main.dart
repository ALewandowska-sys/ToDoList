import './task.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do Homie',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyAplication(),
    );
  }
}

class MyAplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateAplication();
}

class StateAplication extends State<MyAplication> {
  @override
  Widget build(BuildContext centext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do list'),
      ),
      body: Center(
        child: Text("You don't have a task to do"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              height: 100,
              child: Text('This is a modal bottom sheet'),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
