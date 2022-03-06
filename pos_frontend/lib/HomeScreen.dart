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
import 'components/side_menu_mobile.dart';
import 'components/topBar.dart';
import 'Responsive.dart';

class HomeScreen extends StatefulWidget {
  Widget newScreen;

  HomeScreen( this.newScreen);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Desktop View
           if(Responsive.isDesktop(context))
               Column(
                 children: [
                   Expanded(
                     flex: 2,
                     child: SideMenu(),
                   ),

                 ],
               ),
            //Tablet View
            if(Responsive.isTablet(context))
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: SideMenu(),
                  ),

                ],
              ),
          // Mobile View
            if(Responsive.isMobile(context))
              Expanded(
                flex: 2,
                child: side_menu_mobile (),
              ),
          ],
        ),

            /*  Expanded(
              flex:10,
              child: Column(
                children:[
              SizedBox(
                  height: 50,
                  width: 1000,
                  child: searchField()),
              Expanded(
                flex: 5,
                child:Padding(
                  padding: const EdgeInsets.fromLTRB(10,100,30,30),
                  child: widget.newScreen,
                )
              )
  ]
              ),
            )*/

      )
    );
  }
}