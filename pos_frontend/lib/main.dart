import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'Login.dart';
import 'HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: Scaffold(
      body: SafeArea(child: HomeScreen(Text("THIS IS THE HOME SCREEN"))),
    ));
  }
}
