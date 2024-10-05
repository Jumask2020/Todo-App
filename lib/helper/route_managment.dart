
import 'package:flutter/material.dart';
import 'package:local_storge/core/view/screen/add_task.dart';
import 'package:local_storge/core/view/screen/home.dart';
import 'package:local_storge/core/model/task.dart' as tt ;


class RouteManagment {
  static Route<dynamic>? routeApp(RouteSettings route){
    switch(route.name){
      case '/home':return MaterialPageRoute(
        builder: (context) => HomePage());
      case '/addTask': {
        final tt.Task? task = route.arguments as tt.Task?;
        return MaterialPageRoute(
          builder: (context) => AddTask(task: task),
        );
      }
      default:return null;
  }
}}