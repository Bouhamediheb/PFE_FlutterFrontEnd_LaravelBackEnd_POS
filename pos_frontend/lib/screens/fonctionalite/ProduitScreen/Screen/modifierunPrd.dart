// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import '../Widgets/input_field.dart';
import '../Widgets/input_field_description.dart';
import 'package:projetpfe/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class modifierUnProduit extends StatefulWidget {
  int? produitId;

  modifierUnProduit(this.produitId);
  @override
  State<modifierUnProduit> createState() => _modifierUnProduitState();
}

class _modifierUnProduitState extends State<modifierUnProduit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final refProduit = TextEditingController();
  final nomProduit = TextEditingController();
  final prixAchatProduit = TextEditingController();
  final prixVenteProduit = TextEditingController();
  final descriptionProduit = TextEditingController();
  final tvaProduit = TextEditingController();

  File? uploadimage;
  String? baseimage;

  @override
  void initState() {
    super.initState();
    getProduit();
  }

  Future<void> chooseImage() async {
    final ImagePicker picker = ImagePicker();
    var choosedimage = (picker.pickImage(source: ImageSource.gallery) as XFile);
    final File convertimage = File(choosedimage.path);
    setState(() {
      uploadimage = convertimage;
      List<int> imageBytes = uploadimage!.readAsBytesSync();
      baseimage = base64Encode(imageBytes);
    });
  }

  getProduit() async {
    print(widget.produitId);
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/produit/${widget.produitId}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
    if (response.statusCode == 200) {
      produits = json.decode(response.body);
    } else {
      throw Exception('Error!');
    }
    setState(() {
      nomProduit.text = produits!['nomProd'].toString();
      prixAchatProduit.text = produits!['prixAchatHT'].toStringAsFixed(3);
      descriptionProduit.text = produits!['descriptionProd'];
      refProduit.text = produits!['refProd'];
      prixVenteProduit.text = produits!['prixVenteHT'].toStringAsFixed(3);
      tvaProduit.text = produits!['tvaProd'].toString();
    });
  }

  Map<String, dynamic>? produits;

  Future<http.Response?> ajoutProduit(
    String refProduit,
    String nomProduit,
    double prixAchatProduit,
    double prixVenteProduit,
    double tvaProduit,
    String descriptionProduit,
  ) async {
    List? produits = [];
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/produit/${widget.produitId}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'refProd': refProduit,
        'nomProd': nomProduit,
        'prixAchatHT': prixAchatProduit,
        'descriptionProd': descriptionProduit,
        'tvaProd': tvaProduit,
        'prixVenteHT': prixVenteProduit,
      }),
    );
    if (response.statusCode == 200) {
      print('Produit Modifié');
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
      child: SingleChildScrollView(
        child: Card(
          color: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          child: SizedBox(
            width: 1200,
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          "Modifier le produit",
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
                              flex: 2,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  InputField(
                                    whattoAllow:
                                        RegExp('[a-z A-Z á-ú Á-Ú 0-9]'),
                                    label: "Référence du produit",
                                    content: "La Référence du produit",
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
                                    whattoAllow:
                                        RegExp('[a-z A-Z á-ú Á-Ú 0-9]'),
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
                            const SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  InputField(
                                      whattoAllow: RegExp('[0-9 . ]'),
                                      label: "Prix d'achat HT",
                                      content: "Prix Achat du Produit",
                                      fieldController: prixAchatProduit,
                                      fieldValidator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Ce Champ est obligatoire";
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 20),
                                  InputField(
                                      whattoAllow: RegExp('[0-9 . ]'),
                                      label: "Prix de vente HT",
                                      content: "Prix de Vente du Produit",
                                      fieldController: prixVenteProduit,
                                      fieldValidator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Ce Champ est obligatoire";
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 20),
                                  InputField(
                                      label: "TVA",
                                      content: "TVA du produit",
                                      fieldController: tvaProduit,
                                      whattoAllow: RegExp('[0-9 . ]'),
                                      fieldValidator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Ce Champ est obligatoire";
                                        }
                                        return null;
                                      }),
                                  SizedBox(height: 100),
                                ],
                              ),
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
                                    ajoutProduit(
                                      refProduit.text,
                                      nomProduit.text,
                                      double.parse(prixAchatProduit.text),
                                      double.parse(prixVenteProduit.text),
                                      double.parse(tvaProduit.text),
                                      descriptionProduit.text,
                                    );
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
      ),
    );
  }
}
