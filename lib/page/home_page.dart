import 'package:database/page/body_page.dart';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:flutter/src/widgets/basic.dart' as basic;
import 'package:provider/provider.dart';

import '../data/task_moor.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController taskController = TextEditingController();
  final Color color = Colors.cyanAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        centerTitle: true,
        title: const Text(
          'To do list', style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        elevation: 0,
      //   actions: const [Settings()],
      ),
      body: const Body(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
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
                        TextField(
                          style: const TextStyle(fontSize: 20),
                          controller: taskController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: color, width: 3),
                            ),
                            labelText: 'Enter Title',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            final database = Provider.of<AppDatabase>(context, listen: false);
                            database.insertTask(TasksCompanion(name: Value(taskController.text)));
                            // database.insertColor(const SelectColorsCompanion(colorName: Value(-13795108)));
                            // database.insertColor(const SelectColorsCompanion(colorName: Value(-2466604)));
                            // database.insertColor(const SelectColorsCompanion(colorName: Value(-12856517)));
                            // database.insertColor(const SelectColorsCompanion(colorName: Value(-334336)));
                            // database.insertColor(const SelectColorsCompanion(colorName: Value(-51967434)));
                            // database.insertColor(const SelectColorsCompanion(colorName: Value(-623098), selected: Value(true)));
                            taskController.clear();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                color),
                          ),
                          child: const Text(
                            'Add', style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
          );
        },
        backgroundColor: color,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}