import 'package:flutter/material.dart';
import 'package:pos_frontend/FirstScreen.dart';
import 'HomeScreen.dart';
import 'Login.dart';
import 'HomeScreen.dart';
import '../screens/listeFournisseur.dart';

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
          body: SafeArea(child: FirstScreen()),
        ));
  }
}
