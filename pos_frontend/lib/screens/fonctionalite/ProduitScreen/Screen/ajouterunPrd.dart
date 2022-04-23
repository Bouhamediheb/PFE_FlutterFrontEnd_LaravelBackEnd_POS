import 'package:flutter/material.dart';
import '../Widgets/input_field.dart';
import '../Widgets/input_field_description.dart';
import 'package:admin/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../Widgets/selectionner_image.dart';

class ajouterUnProduit extends StatefulWidget {
  const ajouterUnProduit({Key key}) : super(key: key);

  @override
  State<ajouterUnProduit> createState() => _ajouterUnProduitState();
}

class _ajouterUnProduitState extends State<ajouterUnProduit> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final refProduit = TextEditingController();
  final nomProduit = TextEditingController();
  final prixAchatProduit = TextEditingController();
  final prixVenteProduit = TextEditingController();
  final descriptionProduit = TextEditingController();
  final stockProduit = TextEditingController();

  File uploadimage;

  Future chooseImage() async {
    var choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final File convertedimage = File(choosedimage.path);
    setState(() {
      uploadimage = convertedimage;
    });
  }

  Future upload(
    String refProduit,
    String nomProduit,
    double prixAchatProduit,
    double prixVenteProduit,
    String descriptionProduit,
    double stockProduit,
  ) async {
    //String fileName = file.path.split('/').last;
    //print(fileName);

    FormData data = FormData.fromMap({
      /*"imageProd": await MultipartFile.fromFile(
       file.path,
      filename: fileName,
      ),
      */

      'refProd': refProduit,
      'nomProd': nomProduit,
      'prixAchat': prixAchatProduit,
      'prixVente': prixVenteProduit,
      'descriptionProd': descriptionProduit,
      'stock': stockProduit,
    });

    Dio dio = new Dio();

    await dio
        .post('http://127.0.0.1:8000/api/produit',
            data: data, options: Options(contentType: 'multipart/form-data'))
        .then((response) {
      var jsonResponse = jsonDecode(response.toString());
    }).catchError((error) => print(error));
  }

  List produit = [];

  Future<dynamic> future;

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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            SizedBox(width: 100),
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
                                        SizedBox(height: 25),
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
                                        SizedBox(height: 315)
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
                                      setState(() {
                                        future = upload(
                                            refProduit.text,
                                            nomProduit.text,
                                            double.parse(prixAchatProduit.text),
                                            double.parse(prixVenteProduit.text),
                                            descriptionProduit.text,
                                            double.parse(stockProduit.text));
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
