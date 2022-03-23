import 'package:admin/screens/Login/Screen/CreationCompte.dart';
import 'package:admin/screens/Login/Screen/Network.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dashboard/dashboard_screen.dart';
import '../../main/main_screen.dart';

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
      backgroundColor: Color(0xFF2A2D3E),
      content: Text(msg, style: TextStyle(color: Colors.white)),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(DashboardScreen())),
      );
    } else {
      _showMsg(body['message']);
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
      backgroundColor: Color(0xFF2A2D3E),
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
                shadowColor: Color.fromARGB(255, 122, 120, 120),
                color: Color(0xFF2A2D3E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                elevation: 5.0,
                child: Container(
                  width: 500,
                  height: 600,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      child: Text(
                        "Connectez-Vous",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Veuillez remplir l'entrée ci-dessous",
                      style: TextStyle(
                        color: Color.fromARGB(255, 179, 179, 179),
                      ),
                    ),
                    SizedBox(height: 100),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (emailValue) {
                          if (emailValue == null || emailValue.isEmpty) {
                            return 'Ce champs est obligatoire';
                          }
                          email = emailValue;
                          return null;
                        },
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF2A2D3E)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (passwordValue) {
                          if (passwordValue == null || passwordValue.isEmpty) {
                            return 'Ce champs est obligatoire';
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
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF2A2D3E)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFF2A2D3E),
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: MaterialButton(
                          height: 70,
                          minWidth: 200,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _login();
                            }
                          },
                          color: Colors.blue[800],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          child: Text(
                            _isLoading ? 'Connexion en Cours' : "Connexion",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Vous n'avez pas de compte ? Inscrivez-vous ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreationCompte()),
                              );
                            },
                            child: Text("ici",
                                style: TextStyle(color: Colors.blue[800])))
                      ],
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
