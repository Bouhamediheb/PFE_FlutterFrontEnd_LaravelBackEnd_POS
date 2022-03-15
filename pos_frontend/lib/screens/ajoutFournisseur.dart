import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Animation/FadeAnimation.dart';

class ajoutFournisseur extends StatefulWidget {
  const ajoutFournisseur({Key key}) : super(key: key);

  @override
  State<ajoutFournisseur> createState() => _ajoutFournisseurState();
}

class _ajoutFournisseurState extends State<ajoutFournisseur> {
  bool isSwitched = false;
  bool isTicked = false;
  final _formKey = GlobalKey<FormState>();
  final raisonSocialeFournisseur = TextEditingController();
  final paysFournisseur = TextEditingController();
  final villeFournisseur = TextEditingController();
  final numeroFournisseur = TextEditingController();
  final matriculeFiscaleFournisseur = TextEditingController();
  final addressFournisseur = TextEditingController();
  double timbreFiscaleFournisseur = 0.0;
  bool exoTVA = false;

  List fournisseur = [];

  Future<http.Response> ajoutFournisseur(
      String numeroFournisseur,
      String addressFournisseur,
      String matriculeFiscaleFournisseur,
      String raisonSocialeFournisseur,
      String paysFournisseur,
      String villeFournisseur,
      double timbreFiscaleFournisseur,
      bool exoTVA) async {
    List fournisseurs = [];
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/fournisseur/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'tel': numeroFournisseur,
        'adresse': addressFournisseur,
        'mf': matriculeFiscaleFournisseur,
        'raisonSociale': raisonSocialeFournisseur,
        'pays': paysFournisseur,
        'ville': villeFournisseur,
        'timbreFiscal': timbreFiscaleFournisseur,
        'exoTVA': exoTVA,
      }),
    );
    if (response.statusCode == 200) {
      return fournisseurs = jsonDecode(response.body);
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  Future<dynamic> future;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            //Début Formulaire
            child: Container(
              width: MediaQuery.of(context).size.width * 0.99,
              height: 50,
              child: Center(
                child: Text(
                  'Informations Générales',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 450,
                    width: MediaQuery.of(context).size.width * 0.49,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Raison Sociale",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: raisonSocialeFournisseur,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Raison Sociale',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400,
                                ),
                                prefixIcon:
                                    Icon(Icons.analytics, color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 0, 15, 0),
                              ),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Pays",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: paysFournisseur,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Pays',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400,
                                ),
                                prefixIcon: Icon(Icons.location_on,
                                    color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 0, 15, 0),
                              ),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Ville/Région",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: villeFournisseur,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Ville/Région',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400,
                                ),
                                prefixIcon: Icon(Icons.location_city,
                                    color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 0, 15, 0),
                              ),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Numéro de Téléphone",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: numeroFournisseur,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ce champs est obligatoire';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Numéro de Téléphone',
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade400,
                                ),
                                prefixIcon:
                                    Icon(Icons.phone, color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(15, 0, 15, 0),
                              ),
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.49,
                      height: 450,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Matricule Fiscale",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: matriculeFiscaleFournisseur,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ce champs est obligatoire';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Matricule Fiscale',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade400,
                                  ),
                                  prefixIcon: Icon(Icons.analytics,
                                      color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15, 0, 15, 0),
                                ),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Adresse",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: addressFournisseur,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ce champs est obligatoire';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Adresse',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade400,
                                  ),
                                  prefixIcon:
                                      Icon(Icons.route, color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(15, 0, 15, 0),
                                ),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Timbre Fiscale",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: SizedBox(
                                        height: 48.0,
                                        child: TextField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText:
                                                '$timbreFiscaleFournisseur',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey.shade400,
                                            ),
                                            prefixIcon: Icon(Icons.money,
                                                color: Colors.black),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade200),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      trailing: Switch(
                                          activeColor:
                                              Color.fromARGB(255, 41, 17, 173),
                                          value: isSwitched,
                                          onChanged: (value) {
                                            setState(() {
                                              isSwitched = value;
                                              if (isSwitched == false) {
                                                timbreFiscaleFournisseur =
                                                    0.000;
                                                print(timbreFiscaleFournisseur);
                                              } else {
                                                timbreFiscaleFournisseur =
                                                    0.600;
                                                print(timbreFiscaleFournisseur);
                                              }
                                            });
                                          }),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Exonéré de TVA',
                                          style: TextStyle(
                                            fontFamily: 'MontSerrat',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Checkbox(
                                            activeColor: Color.fromARGB(
                                                255, 41, 17, 173),
                                            value: isTicked,
                                            onChanged: (value) {
                                              setState(() {
                                                isTicked = value;
                                                if (isTicked == false) {
                                                  exoTVA = false;
                                                } else {
                                                  exoTVA = true;
                                                }
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 45, bottom: 20),
                              child: ElevatedButton(
                                onPressed: (() {
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    setState(() {
                                      future = ajoutFournisseur(
                                          numeroFournisseur.text,
                                          addressFournisseur.text,
                                          matriculeFiscaleFournisseur.text,
                                          raisonSocialeFournisseur.text,
                                          paysFournisseur.text,
                                          villeFournisseur.text,
                                          timbreFiscaleFournisseur,
                                          exoTVA);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Fournisseur Ajouté')),
                                    );
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  }
                                }),
                                child: Text(
                                  "Confirmer",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Color.fromARGB(255, 41, 17, 173),
                                    minimumSize: Size(150, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
