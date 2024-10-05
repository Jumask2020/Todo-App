import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:local_storge/helper/local_db.dart';
import 'package:local_storge/core/model/task.dart' as tt;


class TaskVM extends ChangeNotifier{
  LocalDb _db = LocalDb.instance;
  DateTime dateTime = DateTime.now();
  int count  = 0;
  selectedDateTime(DateTime newDateTime){
      dateTime = newDateTime;
      notifyListeners();
  }

  countTask()async{
    count;
    notifyListeners();
  }

  Future<Either<String,List<tt.Task>>> fetchAllTask()async {
    try {
      var tasks = await _db.select(
          'SELECT * FROM tasks');
      return right(tasks.map((t) => tt.Task.fromJson(t)).toList());
    } catch (e) {
      print(e);
      return left('$e');
    }
  }

  Future<Either<String,int>> addTask(tt.Task task)async{
    try {
      return await right( await _db.insert('tasks',task.toJson()));
    }catch (e){
      return left('$e');
    }

  }

  Future<Either<String,int>> deleteTask(int id)async{
    try {
      return right(await _db.delete('tasks',where: 'id = ${id}'));
    }catch (e){
      print(e);
      return left('$e');
    }
  }

  Future<Either<String,int>> updateTask(int id,tt.Task task)async{
    try {
      return right( await _db.update('tasks', task.toJson(),where: 'id = $id'));
    }catch (e){
      print(e);
      return left('$e');
    }
  }

}