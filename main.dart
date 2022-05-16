import 'package:flutter/material.dart';
import 'body.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do Homie',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
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
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              color: Colors.cyan[50],
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter Title',
                    ),
                  ),
                  TextButton(onPressed: () {},
                      child: Text("Add"),
                  )
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.cyan[600],
      ),
    );
  }
}
