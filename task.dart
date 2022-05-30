import 'package:flutter/material.dart';
import 'task.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

List globalTask = <String>[];

class StateAplication extends State<MyAplication> {
  TextEditingController taskController = TextEditingController();



  createBody() {
    if (globalTask.isEmpty) {
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
    else {
        return Container(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: Column(
            children: List.generate(globalTask.length, (index) {
              return Task(globalTask[index]);
            }),
           ),
        );
    }
   /* if(done.isNotEmpty){
      return ExpansionTile(
        title: Text("See done tasks"),
        children:List.generate(done.length, (indexDone){
          return Text(done[indexDone], style: TextStyle(fontSize: 20, decoration: TextDecoration.lineThrough, color: Colors.grey));
        },),
      );
    }
    */
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
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      style: const TextStyle(fontSize: 20),
                      controller: taskController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 3),
                        ),
                        labelText: 'Enter Title',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          globalTask.add(taskController.text);
                        },);
                        taskController.clear();
                        },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                      ),
                      child: const Text('Add',style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
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
