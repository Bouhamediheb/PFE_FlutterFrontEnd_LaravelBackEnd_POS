// ignore_for_file: unused_local_variable

import 'package:projetpfe/constants.dart';
import 'package:projetpfe/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../main/main_screen.dart';
import '../../ProduitScreen/Widgets/input_field.dart';

class ajouterUnFournisseur extends StatefulWidget {
  @override
  State<ajouterUnFournisseur> createState() => _ajouterUnFournisseurState();
}

class _ajouterUnFournisseurState extends State<ajouterUnFournisseur> {
  final raisonSocialeFournisseur = TextEditingController();
  final paysFournisseur = TextEditingController();
  final villeFournisseur = TextEditingController();
  final emailFournisseur = TextEditingController();
  final numeroFournisseur = TextEditingController();
  final matriculeFiscaleFournisseur = TextEditingController();
  final addressFournisseur = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? exoTVA;
  double? timbreFiscaleFournisseur;
  bool isSwitched = false;
  bool? isTicked = false;

  Future<http.Response?> ajoutFournisseur(
      String numeroFournisseur,
      String emailFournisseur,
      String addressFournisseur,
      String matriculeFiscaleFournisseur,
      String raisonSocialeFournisseur,
      String paysFournisseur,
      String villeFournisseur,
      double? timbreFiscaleFournisseur,
      bool? exoTVA) async {
    late List? fournisseurs = [];
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/fournisseur/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'tel': numeroFournisseur,
        'email': emailFournisseur,
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

  Future<dynamic>? future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(
            top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "AJOUTER UN FOURNISSEUR",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const Divider(
                          thickness: 3,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //InputField Widget from the widgets folder
                                  InputField(
                                    whattoAllow:
                                        RegExp('[a-z A-Z á-ú Á-Ú 0-9]'),
                                    fieldController: raisonSocialeFournisseur,
                                    label: "Raison Sociale",
                                    content: "Le nom du fournisseur",
                                    fieldValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce Champ est obligatoire";
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20.0),

                                  //Gender Widget from the widgets folder

                                  //InputField Widget from the widgets folder
                                  InputField(
                                    whattoAllow:
                                        RegExp('[a-z A-Z á-ú Á-Ú 0-9]'),
                                    fieldController: addressFournisseur,
                                    label: "Addresse",
                                    content: "Route ...",
                                    fieldValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce Champ est obligatoire";
                                      }
                                      return null;
                                    },
                                  ),

                                  //InputField Widget from the widgets folder

                                  const SizedBox(height: 20.0),

                                  //InputField Widget from the widgets folder
                                  InputField(
                                    whattoAllow: RegExp('[a-z A-Z á-ú Á-Ú ]'),
                                    fieldController: paysFournisseur,
                                    label: "Pays",
                                    content:
                                        "Vide si le fournisseur est en Tunisie",
                                    fieldValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce Champ est obligatoire";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20.0),

                                  InputField(
                                    whattoAllow: RegExp('[a-z A-Z á-ú Á-Ú ]'),
                                    fieldController: villeFournisseur,
                                    label: "Ville",
                                    content: "Ville du siége du fournisseur",
                                    fieldValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce Champ est obligatoire";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InputField(
                                    whattoAllow:
                                        RegExp('[a-z A-Z á-ú Á-Ú 0-9 /]'),
                                    fieldController:
                                        matriculeFiscaleFournisseur,
                                    label: "Matricule fiscale",
                                    content: "MAT1234",
                                    fieldValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce Champ est obligatoire";
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20.0),

                                  //InputField Widget from the widgets folder
                                  InputField(
                                    whattoAllow: RegExp("[a-z A-Z 0-9 @ .]"),
                                    fieldController: emailFournisseur,
                                    label: "Email",
                                    content: "foulen@mail.com",
                                    fieldValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce Champ est obligatoire";
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20.0),

                                  InputField(
                                    whattoAllow: RegExp('[0-9 +]'),
                                    fieldController: numeroFournisseur,
                                    label: "Numéro de téléphone",
                                    content: "+29000000000",
                                    fieldValidator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce Champ est obligatoire";
                                      }
                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 20.0),

                                  //InputField Widget from the widgets folder
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          title: const SizedBox(
                                            width: 50.0,
                                            child: Text(
                                              "Timbre Fiscale",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w900,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                            ),
                                          ),
                                          trailing: Switch(
                                              activeColor: const Color.fromARGB(
                                                  255, 41, 17, 173),
                                              value: isSwitched,
                                              onChanged: (value) {
                                                setState(() {
                                                  isSwitched = value;
                                                  if (isSwitched == false) {
                                                    timbreFiscaleFournisseur =
                                                        0.000;
                                                  } else {
                                                    timbreFiscaleFournisseur =
                                                        0.600;
                                                  }
                                                });
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: const Padding(
                                            padding: EdgeInsets.only(left: 1),
                                            child: SizedBox(
                                              width: 40.0,
                                              child: Text(
                                                "Exonération TVA",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w900,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                              ),
                                            ),
                                          ),
                                          trailing: Checkbox(
                                              activeColor: const Color.fromARGB(
                                                  255, 41, 17, 173),
                                              value: isTicked,
                                              onChanged: (value) async {
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 40.0,
                        ),

                        //Membership Widget from the widgets folder

                        const SizedBox(
                          height: 40.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            MaterialButton(
                              height: 53,
                              color: Colors.grey[200],
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Annuler",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            MaterialButton(
                              height: 53,
                              color: const Color.fromARGB(255, 75, 100, 211),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    future = ajoutFournisseur(
                                        numeroFournisseur.text,
                                        emailFournisseur.text,
                                        addressFournisseur.text,
                                        matriculeFiscaleFournisseur.text,
                                        raisonSocialeFournisseur.text,
                                        paysFournisseur.text,
                                        villeFournisseur.text,
                                        timbreFiscaleFournisseur,
                                        exoTVA);
                                  });

                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: (secondaryColor),
                                        content: Text(
                                          'Tâche effectuée avec succès',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 250, 253, 255)),
                                        )),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainScreen(DashboardScreen())),
                                  );
                                }
                              },
                              child: const Text(
                                "Ajouter",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
