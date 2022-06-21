// ignore_for_file: must_be_immutable

import 'package:projetpfe/constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Widgets/input_field.dart';

class modifierUnFournisseur extends StatefulWidget {
  int? fournisseurId;
  modifierUnFournisseur(this.fournisseurId);
  @override
  State<modifierUnFournisseur> createState() => _modifierUnFournisseurState();
}

class _modifierUnFournisseurState extends State<modifierUnFournisseur> {
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
  bool isSwitched = true;
  bool? isTicked = false;
  Map<String, dynamic>? fournisseurs;

  @override
  void initState() {
    super.initState();
    getFournisseur();
  }

  Future<http.Response?> getFournisseur() async {
    print(widget.fournisseurId);
    final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/api/fournisseur/${widget.fournisseurId}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      fournisseurs = json.decode(response.body);
    } else {
      throw Exception('Error!');
    }
    setState(() {
      raisonSocialeFournisseur.text = fournisseurs!['raisonSociale'].toString();
      paysFournisseur.text = fournisseurs!['pays'].toString();
      villeFournisseur.text = fournisseurs!['ville'].toString();
      emailFournisseur.text = fournisseurs!['email'].toString();
      numeroFournisseur.text = fournisseurs!['tel'].toString();
      matriculeFiscaleFournisseur.text = fournisseurs!['mf'].toString();
      addressFournisseur.text = fournisseurs!['adresse'].toString();
      if (fournisseurs!['timbreFiscal'] != 0) {
        isSwitched = true;
      } else {
        isSwitched = false;
      }
      if (fournisseurs!['exoTVA'] != 0) {
        isTicked = true;
      } else {
        isTicked = false;
      }
    });
    return null;
  }

  Future<http.Response?> ajoutFournisseur(
      int? id,
      String numeroFournisseur,
      String emailFournisseur,
      String addressFournisseur,
      String matriculeFiscaleFournisseur,
      String raisonSocialeFournisseur,
      String paysFournisseur,
      String villeFournisseur,
      double? timbreFiscaleFournisseur,
      bool? exoTVA) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/fournisseur/$id'),
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
      print("Fournisseur Modifié");
    } else {
      throw Exception('Erreur base de données!');
    }
    return null;
  }

  Future<dynamic>? future;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        shadowColor: Color.fromARGB(255, 138, 102, 102),
        color: bgColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 0,
        child: SizedBox(
          //width: 1000,
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "MODIFIER UN FOURNISSEUR",
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
                                  fieldController: matriculeFiscaleFournisseur,
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
                                        contentPadding: const EdgeInsets.all(0),
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
                          const SizedBox(
                            width: 20.0,
                          ),
                          MaterialButton(
                            height: 50,
                            color: const Color.fromARGB(255, 75, 100, 211),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  future = ajoutFournisseur(
                                      widget.fournisseurId,
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

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: (secondaryColor),
                                      content: Text(
                                        'Fournisseur Ajouté',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 250, 253, 255)),
                                      )),
                                );
                              }
                            },
                            child: const Text(
                              "Appliquer",
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
    );
  }
}
