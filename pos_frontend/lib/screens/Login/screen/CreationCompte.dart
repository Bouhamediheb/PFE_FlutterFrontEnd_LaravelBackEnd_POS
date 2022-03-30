import 'package:admin/screens/Login/Screen/Login.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../dashboard/dashboard_screen.dart';
import '../../main/main_screen.dart';

class CreationCompte extends StatefulWidget {
  @override
  State<CreationCompte> createState() => _CreationCompteState();
}

class _CreationCompteState extends State<CreationCompte> {
  Future<http.Response> ajoutCompte(
      String nom, String email, String password) async {
    List comptes = [];
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'name': nom, 'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return comptes = jsonDecode(response.body);
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  Future<dynamic> future;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "Créer un Compte",
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
                    SizedBox(height: 50),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champs est obligatoire';
                          }
                          return null;
                        },
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Nom & Prénom',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
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
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champs est obligatoire';
                          }
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
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champs est obligatoire';
                          }
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
                    SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champs est obligatoire';
                          }
                          return null;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Confirmez votre Mot de Passe',
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
                    SizedBox(height: 35),
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
                              setState(() {
                                future = ajoutCompte(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text);
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            }
                          },
                          color: Colors.blue[800],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          child: Text(
                            "Inscrivez-Vous",
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
                          "Vous avez déja un compte ? Connectez-vous ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 179, 179, 179),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
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
