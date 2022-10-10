import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/select_color_moor.dart';
import '../data/task_moor.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateBody();
}

class StateBody extends State<Body> {
  TextEditingController taskController = TextEditingController();

  // done(List doneTask){
  //   return ExpansionTile(
  //     title: const Text("See done tasks"),
  //     children: [
  //       ValueListenableBuilder(
  //         valueListenable: Hive.box<TaskModel>('task').listenable(),
  //         builder: (context, Box<TaskModel> _notesBox, _) {
  //           tasksBox = _notesBox;
  //           return ListView.builder(
  //               itemCount: _notesBox.values.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 final todo = tasksBox.getAt(index);
  //                 return ListTile(
  //                   title: Text(todo!.content, style: const TextStyle(
  //                       fontSize: 22,
  //                       decoration: TextDecoration.lineThrough,
  //                       color: Colors.grey),),
  //                   onLongPress: () => tasksBox.deleteAt(index),
  //                 );
  //               });
  //         },),],
  //   );
  // }
  // toDo(List toDoTask){
  //   var howManyTask = toDoTask.length;
  //   return Column(
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.only(top: 20, left: 10, bottom: 15),
  //           alignment: const FractionalOffset(0.1, 0.0),
  //           child: Text(
  //             '$howManyTask tasks to do',
  //             style: const TextStyle(
  //                 fontStyle: FontStyle.italic, color: Colors.blueGrey),
  //           ),
  //         ),
  //         Column(
  //             children: [
  //               ValueListenableBuilder(
  //                 valueListenable: Hive.box<TaskModel>('task').listenable(),
  //                 builder: (context, Box<TaskModel> _notesBox, _) {
  //                   tasksBox = _notesBox;
  //                   return ListView.builder(
  //                     itemCount: _notesBox.values.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       final todo = tasksBox.getAt(index);
  //                       return ListTile(
  //                         title: Text(todo!.content, style: const TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.w600,
  //                             letterSpacing: 0.5),),
  //                         onLongPress: () => tasksBox.deleteAt(index),
  //                       );
  //                     },);
  //                 },),
  //             ])
  //       ]
  //   );
  // }
  // empty(){
  //   return Center(
  //     child: Opacity(
  //       opacity: 0.4,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: const <Widget>[
  //           Icon(
  //             Icons.list_alt,
  //             size: 70,
  //           ),
  //           Text('Add some task',
  //               style: TextStyle(
  //                   fontWeight: FontWeight.bold, fontSize: 20)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // createBody() {
  //   if (tasksBox.isEmpty) {
  //     return empty();
  //   }
  //   else {
  //     List doneTask = tasksBox.values
  //         .where((object) => object.check == true)
  //         .toList();
  //     List toDoTask = tasksBox.values
  //         .where((object) => object.check == false)
  //         .toList();
  //
  //     if (doneTask.isEmpty || toDoTask.isNotEmpty) {
  //       return toDo(toDoTask);
  //     }
  //     if (doneTask.isNotEmpty || toDoTask.isEmpty){
  //       return done(doneTask);
  //     }
  //     else{
  //       return Column(
  //           children: [
  //             toDo(toDoTask),
  //             done(doneTask)
  //           ]
  //       );
  //     }
  //   }
  // }



  // Color takeColor(){
  //   final database = Provider.of<AppDatabase>(context, listen: false);
  //   SelectColors color = database.getColor().asStream().first as SelectColors;
  //   // color.colorName as int
  //   return Color(-623098);
  // }

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
      child: Column(
      children:[
        Expanded(child: _buildTaskList(context))
        ]
      ),
    );
        // child: empty()
      // createBody(),
    // );
  }

  // return ListView.builder(
  //               itemCount: _notesBox.values.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 final todo = tasksBox.getAt(index);
  //                 return ListTile(
  //                   title: Text(todo!.content, style: const TextStyle(
  //                       fontSize: 22,
  //                       decoration: TextDecoration.lineThrough,
  //                       color: Colors.grey),),
  //                   onLongPress: () => tasksBox.deleteAt(index),
  //                 );
  //               });

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