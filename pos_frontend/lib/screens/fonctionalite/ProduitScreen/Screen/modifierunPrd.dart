import 'package:flutter/material.dart';
import '../Widgets/input_field.dart';
import '../Widgets/input_field_description.dart';
import 'package:admin/constants.dart';
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
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final refProduit = TextEditingController();
  final nomProduit = TextEditingController();
  final prixAchatProduit = TextEditingController();
  final prixVenteProduit = TextEditingController();
  final descriptionProduit = TextEditingController();

  File? uploadimage;
  String? baseimage;

  Future<void> chooseImage() async {
    final ImagePicker picker = ImagePicker();
    var choosedimage =
        await (picker.pickImage(source: ImageSource.gallery) as XFile);
    final File convertimage = File(choosedimage.path);
    setState(() {
      uploadimage = convertimage;
      List<int> imageBytes = uploadimage!.readAsBytesSync();
      baseimage = base64Encode(imageBytes);
    });
  }

  List produit = [];

  Future<http.Response?> ajoutProduit(
      String refProduit,
      String nomProduit,
      double prixAchatProduit,
      double prixVenteProduit,
      String descriptionProduit,
      File? imageProduit) async {
    List? produits = [];
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/produit/'),
      headers: <String, String>{'Content-Type': 'multipart/form-data'},
      body: jsonEncode(<String, dynamic>{
        'refProd': refProduit,
        'nomProd': nomProduit,
        'prixAchat': prixAchatProduit,
        'prixVente': prixVenteProduit,
        'descriptionProd': descriptionProduit,
        'imageProd': imageProduit,
      }),
    );
    if (response.statusCode == 200) {
      return produits = jsonDecode(response.body);
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  Future<dynamic>? future;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Card(
          shadowColor: Color.fromARGB(255, 122, 120, 120),
          color: Color(0xFF2A2D3E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 0.0,
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
                                    content: "La Référende du produit",
                                    fieldController: refProduit,
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
                                    fieldController: nomProduit,
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
                                      fieldController: prixAchatProduit,
                                      fieldValidator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Ce Champ est obligatoire";
                                        }
                                        return null;
                                      }),
                                  SizedBox(height: 20),
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
                                  SizedBox(height: 20),
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
                            SizedBox(width: 25),
                            Expanded(
                              flex: 3,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Séléctionnez une Image",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        SizedBox(width: 25),
                                        Container(
                                          child: OutlinedButton(
                                            onPressed: () {
                                              chooseImage();
                                            },
                                            child: Icon(
                                              Icons.add,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    future = ajoutProduit(
                                        refProduit.text,
                                        nomProduit.text,
                                        double.parse(prixAchatProduit.text),
                                        double.parse(prixVenteProduit.text),
                                        descriptionProduit.text,
                                        uploadimage);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: (secondaryColor),
                                        content: Text(
                                          'Produit Ajouté',
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
    );
  }
}
