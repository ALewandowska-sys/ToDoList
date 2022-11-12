import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;

import '../data/database.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<StatefulWidget> createState() => _StateBody();
}

class _StateBody extends State<Body> {
  int _tasksCounter = 0;
  int _toDoCounter = 0;
  int _selectColor = -15632662;

  @override
  void initState(){
    super.initState();
    getAllCount().then((value) => _tasksCounter = value);
    getToDoCount().then((value) => _toDoCounter = value);
    takeColor().then((value) => _selectColor = value);
  }
  @override
  void dispose() {
    super.dispose();
  }

  Future<int> takeColor() async{
    final database = Provider.of<MoorDatabase>(context, listen: false);
    Future<int> total = ThemeColorsDao(database).getColorQuery();
    return await total;
  }

  Future<int> getAllCount() async{
    final database = Provider.of<MoorDatabase>(context, listen: false);
    Selectable<int> total = TaskDao(database).totalTasks();
    return await total.getSingle();
  }

  Future<int> getToDoCount() async{
    final database = Provider.of<MoorDatabase>(context, listen: false);
    Selectable<int> total = TaskDao(database).totalToDo();
    return await total.getSingle();
  }
  reloadData(){
    getToDoCount().then((value) => _toDoCounter = value);
    getAllCount().then((value) => _tasksCounter = value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        color: Colors.white,
      ),
      child: createBody()
    );
  }

  createBody() {
    reloadData();
    if (_tasksCounter == 0) {
      return empty();
    }
    return SingleChildScrollView(child: basic.Column(
        children: [
          toDo(),
          done()
        ]
    ),
    );
  }

  empty(){
    return Center(
      child: Opacity(
        opacity: 0.4,
        child: basic.Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.list_alt,
              size: 70,
            ),
            Text('Add some task',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  done(){
    if(_tasksCounter == _toDoCounter){
      return const SizedBox.shrink();
    }
    return basic.Column(
        children: [
          ExpansionTile(
              title: const Text("See done tasks"),
              children:[
                  dynamicListDone(),
              ]),
        ]);
  }

  toDo(){
    return basic.Column(
        children: [
          howManyToDo(),
            basic.Column(
                children:[
                    dynamicListToDo(),
                ]),

        ]);
  }

  howManyToDo(){
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, bottom: 15),
      alignment: const FractionalOffset(0.1, 0.0),
      child: Text(
        '$_toDoCounter tasks to do',
        style: const TextStyle(
            fontStyle: FontStyle.italic, color: Colors.blueGrey),
      ),
    );
  }

  dynamicListToDo(){
    final database = Provider.of<MoorDatabase>(context, listen: false);
    return StreamBuilder(
      stream: TaskDao(database).watchToDoTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? [];
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final itemTask = tasks[index];
            return CheckboxListTile(
              title: Text(itemTask.name, style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
              ),
              checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)
              ),
              checkColor: Color(_selectColor),
              secondary: IconButton(
                color: Colors.grey,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  TaskDao(database).deleteTask(itemTask);
                },
              ),
              value: itemTask.selected,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (newValue) {
                TaskDao(database).updateTask(itemTask.copyWith(selected: newValue));
              },
            );
          },
        );
      },
    );
  }

  dynamicListDone(){
    final database = Provider.of<MoorDatabase>(context, listen: false);
    return StreamBuilder(
      stream: TaskDao(database).watchDoneTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? [];
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final itemTask = tasks[index];
            return ListTile(
              title: Text(itemTask.name, style: const TextStyle(
                  fontSize: 22,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey),
              ),
              onLongPress: () => {
                TaskDao(database).deleteTask(itemTask)
              }
            );
          },);
      },);
  }
}