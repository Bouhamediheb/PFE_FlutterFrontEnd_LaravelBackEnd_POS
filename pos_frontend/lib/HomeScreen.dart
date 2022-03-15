// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//import 'package:responsive_builder/responsive_builder.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_frontend/screens/accueil.dart';
import 'package:pos_frontend/screens/ajoutFournisseur.dart';
import './components/side_menu.dart';
import 'Animation/FadeAnimation.dart';
import 'components/side_menu_mobile.dart';
import 'components/topBar.dart';
import 'Responsive.dart';

class HomeScreen extends StatefulWidget {
  Widget newScreen;

  HomeScreen(this.newScreen);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        //Desktop View
        if (constraints.maxWidth > 1200) {
          return new Scaffold(
            key: _scaffoldKey,
            endDrawerEnableOpenDragGesture: false,
            drawer: SideMenu(),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () =>
                    _scaffoldKey.currentState.openDrawer(), // And this!
              ),
              backgroundColor: Colors.white,
              title: Text(
                "MENU",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: FadeAnimation(2, widget.newScreen),
          );
        } else if (constraints.maxWidth > 800) {
          return new Scaffold(
            key: _scaffoldKey,
            endDrawerEnableOpenDragGesture: false,
            drawer: SideMenu(),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () =>
                    _scaffoldKey.currentState.openDrawer(), // And this!
              ),
              backgroundColor: Colors.white,
              title: Text(
                "MENU",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Center(
              child: SizedBox(height: 800, width: 800, child: widget.newScreen),
            ),
          );
        } else {
          return new Scaffold(
            key: _scaffoldKey,
            endDrawerEnableOpenDragGesture: true,
            drawer: side_menu_mobile(),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () =>
                    _scaffoldKey.currentState.openDrawer(), // And this!
              ),
              backgroundColor: Colors.white,
              title: Text(
                "MENU",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Center(
              child: SizedBox(height: 800, width: 800, child: widget.newScreen),
            ),
          );
        }
      }),
    );
  }
}
