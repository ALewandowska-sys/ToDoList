import 'package:database/page/body_page.dart';
import 'package:database/page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;
import 'package:provider/provider.dart';

import '../data/database.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<MoorDatabase>(context, listen: false);
    return StreamBuilder<int>(
        stream: ThemeColorsDao(database).getColorQuery(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          var color = snapshot.data;
          color ??= -15632662;
          return Scaffold(
            backgroundColor: Color(color),
            appBar: title(color),
            body: Body(color: color),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                bottomSheet(color);
              },
              backgroundColor: Color(color),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        });
  }

  title(color) {
    return AppBar(
      backgroundColor: Color(color),
      centerTitle: true,
      title: const Text(
        'To do list',
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
      elevation: 0,
      actions: const [SettingPage()],
    );
  }

  addNewTask(color) {
    return TextButton(
      onPressed: () {
        final database = Provider.of<MoorDatabase>(context, listen: false);
        TaskDao(database)
            .insertTask(TasksCompanion(name: Value(taskController.text)));
        taskController.clear();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(color)),
        minimumSize: MaterialStateProperty.all(const Size(40.0, 40.0))
      ),
      child: const Text('Add',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20),
      ),
    );
  }

  taskTitleLabel(color) {
    return TextField(
      cursorColor: Colors.blueGrey,
      style: const TextStyle(fontSize: 20),
      controller: taskController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(color), width: 3),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 3),
        ),
        labelText: 'Enter Title',
        labelStyle: const TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  Future bottomSheet(color) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child: basic.Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              taskTitleLabel(color),
              addNewTask(color),
            ],
          ),
        ),
      ),
    );
  }
}
