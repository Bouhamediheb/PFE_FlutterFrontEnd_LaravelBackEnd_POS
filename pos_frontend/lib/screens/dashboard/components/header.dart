// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables


import 'package:projetpfe/controllers/MenuController.dart';
import 'package:projetpfe/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projetpfe/screens/dashboard/dashboard_screen.dart';
import 'package:projetpfe/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../Login/Screen/Login.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Bienvenue dans votre tableau de bord",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        if (!Responsive.isMobile(context))
          Spacer(),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late List? users = [];
  late var token;
  late Map<String, dynamic>? user;
  late  bool isSwitched = false;


  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    token = jsonDecode(prefs.getString('access_token') as String);
    setState(() {
      user = json.decode(prefs.getString('user') as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (dynamic value) {
          if (value == 2) logout();
        },
        offset: const Offset(0, 56.0),
        color: secondaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: 60,
          width: 225,
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/profile_pic.png",
                height: 38,
              ),
              Text(user!["name"].toString())
            ],
          ),
        ),
        itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("Profile")),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.logout, color: Colors.red),
                        Text("Se Déconnecter",
                            style: TextStyle(color: Colors.red))
                      ])),
                                       

            ]);
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Recherche..",
        fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration:  BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
