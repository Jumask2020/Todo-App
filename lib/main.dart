import 'package:flutter/material.dart';
import 'package:local_storge/core/constants/app_color.dart';
import 'package:local_storge/helper/route_managment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteManagment.routeApp,
      initialRoute: '/home',
    );
  }
}
