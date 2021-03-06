import 'package:flutter/material.dart';
import 'package:gmc_erp/screens/login.dart';
import 'package:gmc_erp/screens/project_dashboard.dart';
import 'package:gmc_erp/screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/signin': (context) => WelcomeScreen()
      },
      home: WelcomeScreen(),
    );
  }
}

