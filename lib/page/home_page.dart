import 'package:database/page/body_page.dart';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
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
  int _selectColor = -15632662;

  @override
  void initState(){
    super.initState();
    takeColor().then((value) => _selectColor = value);
  }
  @override
  void dispose() {
    super.dispose();
  }

  Future<int> takeColor() async{
    final database = Provider.of<MoorDatabase>(context, listen: false);
    Future<int> color = ThemeColorsDao(database).getColorQuery();
    return await color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(_selectColor),
      appBar: title(),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheet();
        },
        backgroundColor: Color(_selectColor),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  title() {
    return AppBar(
      backgroundColor: Color(_selectColor),
      centerTitle: true,
      title: const Text(
        'To do list', style: TextStyle(fontSize: 30, color: Colors.white),
      ),
      elevation: 0,
      //   actions: const [Settings()],
    );
  }

  addNewTask() {
    return TextButton(
      onPressed: () {
        final database = Provider.of<MoorDatabase>(context, listen: false);
        TaskDao(database).insertTask(TasksCompanion(name: Value(taskController.text)));
        taskController.clear();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Color(_selectColor)),
      ),
      child: const Text(
        'Add', style: TextStyle(color: Colors.white),
      ),
    );
  }

  taskTitleLabel() {
    return TextField(
      style: const TextStyle(fontSize: 20),
      controller: taskController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(
              color: Color(_selectColor),
              width: 3),
        ),
        labelText: 'Enter Title',
      ),
    );
  }

  Future bottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          Padding(
            padding: MediaQuery
                .of(context)
                .viewInsets,
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: basic.Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  taskTitleLabel(),
                  addNewTask(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
    );
  }
}