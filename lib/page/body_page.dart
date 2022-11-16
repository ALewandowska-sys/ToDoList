import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;

import '../data/database.dart';

class Body extends StatefulWidget {
  final int color;
  const Body({Key? key, required this.color}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateBody();
}

class _StateBody extends State<Body> {
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
        child: createBody());
  }

  createBody() {
    final database = Provider.of<MoorDatabase>(context, listen: false);
    return StreamBuilder<int>(
      stream: TaskDao(database).totalTasks().watchSingle(),
      builder: (
        BuildContext context,
        AsyncSnapshot<int> snapshot,
      ) {
        final totalTasksCount = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (totalTasksCount == 0 || totalTasksCount == null) {
            return empty();
          } else {
            return SingleChildScrollView(
              child: basic.Column(children: [toDo(), done()]),
            );
          }
        }
      },
    );
  }

  empty() {
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  done() {
    final database = Provider.of<MoorDatabase>(context, listen: false);
    return StreamBuilder(
      stream: TaskDao(database).watchDoneTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final doneTasks = snapshot.data ?? [];
        if (doneTasks.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ExpansionTile(
              title: const Text("See done tasks"),
              children: [dynamicListDone(database, doneTasks)]),
        );
      },
    );
  }

  toDo() {
    final database = Provider.of<MoorDatabase>(context, listen: false);
    return StreamBuilder<int>(
        stream: TaskDao(database).totalToDo().watchSingle(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          final toDoTasksCount = snapshot.data;
          if (toDoTasksCount == 0) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: basic.Column(children: [
              howManyToDo(toDoTasksCount),
              basic.Column(children: [
                dynamicListToDo(),
              ]),
            ]),
          );
        });
  }

  howManyToDo(toDoTasksCount) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, bottom: 15),
      alignment: const FractionalOffset(0.1, 0.0),
      child: Text(
        '$toDoTasksCount tasks to do',
        style: const TextStyle(
            fontStyle: FontStyle.italic, color: Colors.blueGrey),
      ),
    );
  }

  dynamicListToDo() {
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
              title: Text(
                itemTask.name,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5),
              ),
              checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              activeColor: Color(widget.color),
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
                TaskDao(database)
                    .updateTask(itemTask.copyWith(selected: newValue));
              },
            );
          },
        );
      },
    );
  }

  dynamicListDone(database, doneTasks) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: doneTasks.length,
      itemBuilder: (_, index) {
        final itemTask = doneTasks[index];
        return ListTile(
            title: Text(
              itemTask.name,
              style: const TextStyle(
                  fontSize: 22,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey),
            ),
            onLongPress: () => {TaskDao(database).deleteTask(itemTask)});
      },
    );
  }
}
