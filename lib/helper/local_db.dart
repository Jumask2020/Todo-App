import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDb {
  LocalDb._();
  static LocalDb? _db;
  static LocalDb get  instance{
    if(_db == null){ _db = LocalDb._();}
      return _db!;
  }

  Database? _dbInstance;
  Future<Database?> get connect async{
    if(_dbInstance == null) _dbInstance = await _connectionDb();
    return _dbInstance;
  }


  Future<Database> _connectionDb()async{
      String pathFolder =await getDatabasesPath();
      String nameDb = 'todoDb.db';
      String path = join(pathFolder,nameDb);
      // deleteDatabase(path);
      return await openDatabase(path, onCreate: _onCreate ,version: 1);
    }

  Future<void> _onCreate(Database db,int version) async{
   await db.execute('''Create table tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title text NOT NULL,
          des TEXT,
          isCompleted INTEGER DEFAULT 0
        );
   ''');
   debugPrint('Created Table ================');
  }

  Future<List<Map<String, dynamic>>> select(String sql,)async{
    Database?db = await connect;
    return await db!.rawQuery(sql);
  }

  Future<int> insert(String table,Map<String, Object?> values)async{
    Database?db = await connect;
   return await db!.insert(table, values);
  }

  Future<int> update(String table,   Map<String, Object?> values, {   String? where})async{
    Database?db = await connect;
    return await db!.update(table,values,where: where);
  }

  Future<int> delete(String table, {   String? where,   List<Object?>? whereArgs, })async{
    Database?db = await connect;
    return await db!.delete(table,where: where,whereArgs: whereArgs);
  }

}