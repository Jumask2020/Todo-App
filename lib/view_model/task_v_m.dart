import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:local_storge/helper/local_db.dart';
import 'package:local_storge/moedel/task.dart' as tt;


class TaskVM {
  LocalDb _db = LocalDb.instance;
  List<Task> tasks = [];
  Future<Either<String,List<tt.Task>>> fetchAllTask()async {
    debugPrint('-----------------------3');
    try {
      var tasks = await _db.select(
          'SELECT * FROM tasks');
      debugPrint('-----------------------2');

      return right(tasks.map((t) => tt.Task.fromJson(t)).toList());
    } catch (e) {
      print(e);
      return left('$e');
    }
  }
  Future<Either<String,int>> addTask(tt.Task task)async{
    debugPrint('-----------------------3');
    try {
       return right( await _db.insert('tasks',task.toJson()));
    }catch (e){
      print(e);
      return left('$e');
    }

  }

  Future<Either<String,int>> deleteTask(int id)async{
    debugPrint('-----------------------3');
    try {
      return right( await _db.delete('tasks',where: 'id = ${id}'));
    }catch (e){
      print(e);
      return left('$e');
    }}
  Future<Either<String,int>> updateTask(int id,tt.Task task)async{
    debugPrint('-----------------------3');
    try {
      return right( await _db.update('tasks', task.toJson(),where: 'id = $id'));
    }catch (e){
      print(e);
      return left('$e');
    }}
}