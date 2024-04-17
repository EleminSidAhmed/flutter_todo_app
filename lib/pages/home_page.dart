import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learn_flutter/data/database.dart';
import 'package:learn_flutter/util/dialogue_box.dart';
import 'package:learn_flutter/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  ToDoDataBase db = ToDoDataBase();
  final _myBox = Hive.box('mybox');
  @override
  void initState(){
    if(_myBox.get("TODOLIST") ==null){
    db.createInitialData();
    }
    else{
      db.loadData();
    }
    super.initState();
  }
  final _controller = TextEditingController();
 void checkBoxChanged(bool? value, int index){
   setState(() {
     db.toDolist[index][1] = !db.toDolist[index][1];
   });
   db.updateData();
 }
 void saveNewtask(){
   setState(() {
     db.toDolist.add([_controller.text,false]);
   });
   Navigator.of(context).pop();
   db.updateData();
   _controller.clear();
 }

 void creatNewTask(){
   showDialog(context: context, builder: (context){
     return DialogueBox(
       controller: _controller,
       onSave: saveNewtask,
       onCancel: () => Navigator.of(context).pop(),
     );
   });
 }
 void deleteTask(int index){
   setState(() {
     db.toDolist.removeAt(index);
   });
   db.updateData();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('TO DO '),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
        onPressed: creatNewTask,
      ),
      body: ListView.builder(
        itemCount: db.toDolist.length,
        itemBuilder: (context, index){
          return ToDoTile(taskName: db.toDolist[index][0],
              taskCompleted: db.toDolist[index][1],
              onChanged: (value)=>checkBoxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),

    );
  }
}
