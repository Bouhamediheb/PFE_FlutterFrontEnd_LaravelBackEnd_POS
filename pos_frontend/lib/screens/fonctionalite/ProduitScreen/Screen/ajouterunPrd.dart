import 'package:flutter/material.dart';
import '../Widgets/input_field.dart';
import '../Widgets/input_field_description.dart';
import 'package:admin/constants.dart';

import '../Widgets/selectionner_image.dart';

class ajouterUnProduit extends StatefulWidget {
  const ajouterUnProduit({Key key}) : super(key: key);

  @override
  State<ajouterUnProduit> createState() => _ajouterUnProduitState();
}

class _ajouterUnProduitState extends State<ajouterUnProduit> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2D3E),
      body: Padding(
        padding: EdgeInsets.fromLTRB(120, 60, 120, 60),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Card(
              shadowColor: Color.fromARGB(255, 122, 120, 120),
              color: Color(0xFF2A2D3E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 5.0,
              child: Container(
                width: 1800,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "AJOUTER UN PRODUIT",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      InputField(
                                        label: "Référence Produit",
                                        content: "La Référende fu produit",
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      InputField(
                                        label: "Nom du produit",
                                        content: "Le Nom du produit",
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      InputField(
                                          label: "Prix Achat",
                                          content: "Prix Achat du Produit",
                                          fieldValidator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Ce Champ est obligatoire";
                                            }
                                            return null;
                                          }),
                                      SizedBox(height: 20),
                                      InputField(
                                        label: "Prix Vente",
                                        content: "Prix Vente du Produit",
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20),
                                      InputFieldDescription(
                                        content: 'La Description du Produit',
                                        label: 'Description du Produit',
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
                                SizedBox(width: 25),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectionnerImage(),
                                        SizedBox(height: 400)
                                      ]),
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
                                  color: Colors.grey[200],
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Annuler",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                MaterialButton(
                                  color: Color.fromARGB(255, 75, 100, 211),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                  child: Text(
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
        ),
      ),
    );
  }
}
