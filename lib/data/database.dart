import 'package:hive/hive.dart';

class ToDoDataBase{
  List toDolist = [];
  final _myBox = Hive.box('mybox');
  void createInitialData(){
    toDolist =[
      ["Learn Software",false],
      ["Do Exercise",false],
    ];
  }

  void loadData(){
   toDolist = _myBox.get("TODOLIST");
  }

  void updateData(){
    _myBox.put("TODOLIST", toDolist);
  }
}