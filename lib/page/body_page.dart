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
  TextEditingController taskController = TextEditingController();
  int _tasksCounter = 0;
  int _toDoCounter = 0;
  int _selectColor = -15632662;

  //doesn't work
  _StateBody(){
    takeColor().then((value) => setState((){
      _selectColor = value.colorName;
    }));
    getAllCount().then((value) => setState((){
      _tasksCounter = value;
    }));
    getToDoCount().then((value) => setState((){
      _toDoCounter = value;
    }));
  }

  Future<SelectColor> takeColor() async{
    final database = Provider.of<AppDatabase>(context, listen: false);
    //  CANT FIND TABLE
    return await database.getColor().first;
  }

  Future<int> getAllCount() async{
    final database = Provider.of<AppDatabase>(context, listen: false);
    Selectable<int> total = TaskDao(database).totalTasks();
    return await total.getSingle();
  }

  Future<int> getToDoCount() async{
    final database = Provider.of<AppDatabase>(context, listen: false);
    Selectable<int> total = TaskDao(database).totalToDo();
    return await total.getSingle();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
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

  Widget createBody() {
    if (_tasksCounter == 0) {
      return empty();
    }
    return basic.Column(
        children: [
          toDo(),
          done()
        ]
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
    return Expanded(
      child: basic.Column(
          children: [
            ExpansionTile(
                title: const Text("See done tasks"),
                children:[
                  Flexible(
                    child: dynamicListDone(),
                  ),
                ]),
          ]),
    );
  }

  toDo(){
    return Expanded(
        child: basic.Column(
            children: [
              howManyToDo(),
              Expanded(
                child: basic.Column(
                    children:[
                      Flexible(
                        child: dynamicListToDo(),
                      ),
                    ]),
              ),
            ])
    );
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
    final database = Provider.of<AppDatabase>(context, listen: false);
    return StreamBuilder(
      stream: database.watchAllTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? [];
        return ListView.builder(
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
                  database.deleteTask(itemTask);
                },
              ),
              value: itemTask.selected,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (newValue) {
                database.updateTask(itemTask.copyWith(selected: newValue));
              },
            );
          },
        );
      },
    );
  }

  dynamicListDone(){
    final database = Provider.of<AppDatabase>(context, listen: false);
    return StreamBuilder(
      stream: database.watchAllTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? [];
        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final itemTask = tasks[index];
            return ListTile(
              title: Text(itemTask.name, style: const TextStyle(
                  fontSize: 22,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey),
              ),
              onLongPress: () => database.deleteTask(itemTask),
            );
          },);
      },);
  }

  @override
  void dispose() {
    super.dispose();
  }
}