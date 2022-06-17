// ignore_for_file: unused_element, deprecated_member_use

import 'package:admin/screens/Login/Screen/Network.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/dashboard_screen.dart';
import '../../main/main_screen.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  var email;
  var password;
  _showMsg(msg) {
    final snackBar = SnackBar(
      backgroundColor: const Color(0xFF2A2D3E),
      content: Text(msg, style: const TextStyle(color: Colors.white)),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email, 'password': password};

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('access_token', json.encode(body['access_token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(DashboardScreen())),
      );
    } else {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(vertical: 10),
              backgroundColor: const Color(0xFF2A2D3E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.red)),
              content: SizedBox(
                width: 400,
                height: 110,
                child: Center(
                    child: Column(
                  children: const [
                    Text("Erreur d'authentification",
                        style: TextStyle(fontSize: 20)),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 20),
                    Center(
                        child: Text("Veuillez vérifier vos coordonnées",
                            style: TextStyle(fontSize: 15)))
                  ],
                )),
              ));
        },
        animationType: DialogTransitionType.fadeScale,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 1),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF2A2D3E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: secondaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shadowColor: const Color.fromARGB(255, 122, 120, 120),
                color: const Color(0xFF2A2D3E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                elevation: 5.0,
                child: SizedBox(
                  width: 500,
                  height: 600,
                  child: Column(children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(
                        "Connectez-Vous",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      "Veuillez remplir l'entrée ci-dessous",
                      style: TextStyle(
                        color: Color.fromARGB(255, 179, 179, 179),
                      ),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (emailValue) {
                          if (emailValue == null || emailValue.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          email = emailValue;
                          return null;
                        },
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Color(0xFF2A2D3E)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (passwordValue) {
                          if (passwordValue == null || passwordValue.isEmpty) {
                            return 'Ce champ est obligatoire';
                          }
                          password = passwordValue;
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Mot de Passe',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Color(0xFF2A2D3E)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: MaterialButton(
                          height: 70,
                          minWidth: 200,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          color: Colors.blue[800],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          child: Text(
                            _isLoading ? 'Connexion en Cours' : "Connexion",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
