// ignore_for_file: unused_local_variable, invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import '../Widgets/input_field.dart';
import '../Widgets/input_field_description.dart';
import 'package:admin/constants.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class ajouterUnProduit extends StatefulWidget {
  const ajouterUnProduit({Key? key}) : super(key: key);

  @override
  State<ajouterUnProduit> createState() => _ajouterUnProduitState();
}

class _ajouterUnProduitState extends State<ajouterUnProduit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final refProduit = TextEditingController();
  final nomProduit = TextEditingController();
  final prixAchatProduit = TextEditingController();
  final prixVenteProduit = TextEditingController();
  final descriptionProduit = TextEditingController();
  final stockProduit = TextEditingController();
  final tvaProduit = TextEditingController();

  late File uploadimage;

  Future chooseImage() async {
    XFile? choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    uploadimage = File(choosedimage!.path);
    setState(() {});
  }

  Future upload(
    double tvaProduit,
    String refProduit,
    String nomProduit,
    double prixAchatProduit,
    double prixVenteProduit,
    String descriptionProduit,
    double stockProduit,
  ) async {
    
    FormData data = FormData.fromMap({
     
      'refProd': refProduit,
      'nomProd': nomProduit,
      'prixAchat': prixAchatProduit,
      'prixVente': prixVenteProduit,
      'descriptionProd': descriptionProduit,
      'stock': stockProduit,
      'TVA': tvaProduit,
    });

    Dio dio = Dio();

    await dio
        .post('http://127.0.0.1:8000/api/produit',
            data: data, options: Options(contentType: 'multipart/form-data'))
        .then((response) {
      var jsonResponse = jsonDecode(response.toString());
    }).catchError((error) => print(error));
  }

  List produit = [];

  Future<dynamic>? future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A2D3E),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(120, 60, 120, 60),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Card(
              shadowColor: const Color.fromARGB(255, 122, 120, 120),
              color: const Color(0xFF2A2D3E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 5.0,
              child: SizedBox(
                width: 1800,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              "AJOUTER UN PRODUIT",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
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
                                      const SizedBox(height: 10),
                                      InputField(
                                        label: "Référence Produit",
                                        content: "La Référende du produit",
                                        fieldController: refProduit,
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      InputField(
                                        label: "Nom du produit",
                                        content: "Le Nom du produit",
                                        fieldController: nomProduit,
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      InputField(
                                          label: "Prix Achat",
                                          content: "Prix Achat du Produit",
                                          fieldController: prixAchatProduit,
                                          fieldValidator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Ce Champ est obligatoire";
                                            }
                                            return null;
                                          }),
                                      const SizedBox(height: 20),
                                      InputField(
                                        label: "Prix Vente",
                                        content: "Prix Vente du Produit",
                                        fieldController: prixVenteProduit,
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      InputField(
                                        label: "TVA",
                                        content: "TVA du Produit",
                                        fieldController: tvaProduit,
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      InputFieldDescription(
                                        content: 'La Description du Produit',
                                        label: 'Description du Produit',
                                        fieldController: descriptionProduit,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Séléctionnez une Image",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                            ),
                                            const SizedBox(width: 100),
                                            Container(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  chooseImage();
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 25),
                                        InputField(
                                          content: 'La Quantité de Produit',
                                          label: 'Quantité',
                                          fieldController: stockProduit,
                                          fieldValidator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Ce Champ est obligatoire";
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 315)
                                      ]),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
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
                                  color: const Color.fromARGB(255, 75, 100, 211),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        future = upload(
                                          double.parse(tvaProduit.text),
                                            refProduit.text,
                                            nomProduit.text,
                                            double.parse(prixAchatProduit.text),
                                            double.parse(prixVenteProduit.text),
                                            descriptionProduit.text,
                                            double.parse(stockProduit.text)
                                            );
                                      });
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            backgroundColor: (secondaryColor),
                                            content: Text(
                                              'Produit Ajouté',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 250, 253, 255)),
                                            )),
                                      );
                                      setState(() {});
                                    }
                                  },
                                  child: const Text(
                                    "Ajouter Produit",
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
