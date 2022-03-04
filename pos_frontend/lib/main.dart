import 'package:flutter/material.dart';
import 'Login.dart';
import 'AjoutFournisseur.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(child: AjoutFournisseur()),
    ));
  }
}
