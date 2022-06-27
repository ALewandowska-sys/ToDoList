import 'package:flutter/material.dart';
import 'main.dart';

class Task extends StatefulWidget{
  final String task;
  Task(this.task);

  @override
  State<StatefulWidget> createState() => _MyTask(task);
}



class _MyTask extends State<Task> {
  final String task;
  bool _isChecked = false;
  _MyTask(this.task);

  doneText(){
    return Text(task, style: const TextStyle(
        fontSize: 22,
        decoration: TextDecoration.lineThrough,
        color: Colors.grey),
    );
  }

  toDoText(){
    return Text(task, style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5),
    );
  }

  changeTask(){
    if(_isChecked == true) {
      return doneText();
    }
    else{
      return toDoText();
    }
  }

  @override
  Widget build(BuildContext context) {

    return CheckboxListTile(
      activeColor: Colors.grey,
      controlAffinity: ListTileControlAffinity.leading,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: changeTask(),
      value: _isChecked,
      onChanged: (value){
          setState(() {
            _isChecked = value!;
            changeTask();
          });
      },
      secondary:  IconButton(
        icon: const Icon(
          Icons.delete,
        ),
        iconSize: 20,
        color: Colors.grey,
        splashColor: Colors.red,
        onPressed: () {
          globalTask.removeWhere((element) => element == task);
        },
      ),
    );
  }
}

/*
return Container(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child: Column(
            children: List.generate(globalTask.length, (index) {
              return Task(globalTask[index]);
            }),
           ),
        );


class MyDone extends StatelessWidget{
  final String done;
  MyDone(this.done);

  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("See done tasks"),
      children: List.generate(done.length, (indexDone) {
        return Text(
            done[indexDone],
            style: const TextStyle(fontSize: 20,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey));
      },),
    );
  }
}
*/
