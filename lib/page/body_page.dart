import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;

import '../data/database.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateBody();
}

class StateBody extends State<Body> {
  TextEditingController taskController = TextEditingController();

  done(){
    final database = Provider.of<AppDatabase>(context, listen: false);
    return Expanded(
        child: basic.Column(
        children: [
          ExpansionTile(
          title: const Text("See done tasks"),
          children:[
            Flexible(
              child: StreamBuilder(
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
                },),
            ),
      ]),
    ]),
    );
  }

  toDo(){
    final database = Provider.of<AppDatabase>(context, listen: false);
    int toDoCount = 0;
    Selectable<int> total = TaskDao(database).totalToDo();
    total.getSingle().then((value) => toDoCount = value);
    return Expanded(
        child: basic.Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 10, bottom: 15),
            alignment: const FractionalOffset(0.1, 0.0),
            child: Text(
              '$toDoCount tasks to do',
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.blueGrey),
            ),
          ),
            Expanded(
              child: basic.Column(
                children:[
                  Flexible(
                    child: StreamBuilder(
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
                            value: itemTask.selected,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (newValue) {
                            database.updateTask(itemTask.copyWith(selected: newValue));
                            },
                          );
                        },
                      );
                      },
                    ),
                  ),
                ]),
          ),
        ])
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

  Widget createBody() {
    final database = Provider.of<AppDatabase>(context, listen: false);
    int tasks = 8;
    Selectable<int> total = TaskDao(database).totalTasks();
    total.getSingle().then((value) => {
      tasks = value
    });
    if (tasks == 0) {
      return empty();
    }
      return basic.Column(
          children: [
            toDo(),
            done()
          ]
        );
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


  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
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
                    color: Colors.grey),
                ),
              onLongPress: () => database.deleteTask(itemTask),
            );
            // return _buildListItem(itemTask, database);
          },
        );
      },
    );
  }

  // Widget _buildListItem(Task itemTask, AppDatabase database) {
  //   return Slidable(
  //     actionPane: SlidableDrawerActionPane(),
  //     secondaryActions: <Widget>[
  //       IconSlideAction(
  //         caption: 'Delete',
  //         color: Colors.red,
  //         icon: Icons.delete,
  //         onTap: () => database.deleteTask(itemTask),
  //       )
  //     ],
  //     child: CheckboxListTile(
  //       title: Text(itemTask.name),
  //       value: itemTask.selected,
  //       onChanged: (newValue) {
  //         database.updateTask(itemTask.copyWith(selected: newValue));
  //       },
  //     ),
  //   );

}