import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Screen/ajouterunDct.dart';
import 'package:admin/screens/fonctionalite/FournisseurScreen/Screen/ajouterunFrs.dart';
import 'package:admin/screens/fonctionalite/ProduitScreen/Screen/ajouterunPrd.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: MainScreen(DashboardScreen()),
      ),
    );
  }
}
