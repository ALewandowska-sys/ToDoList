import 'package:flutter/material.dart';
import 'task.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyAplication(),
    );
  }
}

class MyAplication extends StatefulWidget {
  const MyAplication({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateAplication();
}

class StateAplication extends State<MyAplication> {

  TextEditingController taskController = TextEditingController();
  List task = <String>[];



  createBody(){
    if(task.isEmpty){
      return Center(
        child: Opacity(
          opacity: 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.list_alt,
                size: 70,
              ),
              Text('Add some task',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
        ),
      );
    }
    else{
      return Container(
        padding: EdgeInsets.only(top:20, left: 10),
        child: Column(
            children: List.generate(task.length, (index)
          {
            return Task(task[index]);
          },
          ),
          ),
      );
    }
  }

  addTask(){
    setState(() {
    task.add(taskController.text);
    },);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('To do list', style: TextStyle(fontSize: 25, color: Colors.white),),
      ),
      body: createBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              color: Colors.cyan[50],
              child: Column(
                children: [
                  TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Enter Title',
                    ),
                  ),
                  TextButton(onPressed: () {
                    addTask();
                  },
                      child: const Text("Add"),
                  )
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.cyan[600],
      ),
    );
  }
}
