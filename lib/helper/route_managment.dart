import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_storge/view/screen/add_task.dart';
import 'package:local_storge/view/screen/home.dart';

class RouteManagment {
  static Route<dynamic>? routeApp(RouteSettings route){
    switch(route.name){
      case '/home':return MaterialPageRoute(builder: (context) => HomePage(),);
      case '/addTask':{
        route.arguments;
        return MaterialPageRoute(

            builder: (context) => AddTask(),settings: RouteSettings(arguments: route.arguments));};
      default:return null;
    }
  }
}