// ignore_for_file: unused_local_variable, invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../../main/main_screen.dart';
import '../Widgets/input_field.dart';
import '../Widgets/input_field_description.dart';
import 'package:projetpfe/constants.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class ajouterUnProduit extends StatefulWidget {
  const ajouterUnProduit({Key? key}) : super(key: key);

  @override
  State<ajouterUnProduit> createState() => _ajouterUnProduitState();
}

class _ajouterUnProduitState extends State<ajouterUnProduit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController refProduit = TextEditingController();
  final TextEditingController nomProduit = TextEditingController();
  final TextEditingController prixAchatProduit = TextEditingController();
  final TextEditingController descriptionProduit = TextEditingController();
  final TextEditingController stockProduit = TextEditingController();
  final TextEditingController prixVenteProduit = TextEditingController();
  final TextEditingController tvaProduit = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFours();
  }

  late int idFournisseur;
  List fournisseurs = [];
  String? dropdownvalue;
  late Map<int, String> raisonSociale = {};

  fetchFours() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/fournisseur'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        fournisseurs = items;
        for (var i = 0; i < fournisseurs.length; i++) {
          raisonSociale[fournisseurs[i]['id']] =
              fournisseurs[i]['raisonSociale'];
        }
        ;
      });
    } else {
      throw Exception('Error!');
    }
  }

  late File uploadimage;

  Future chooseImage() async {
    XFile? choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    uploadimage = File(choosedimage!.path);
    setState(() {});
  }

  Future upload(
    String refProduit,
    String nomProduit,
    double prixAchatProduit,
    double prixVenteProduit,
    double tvaProduit,
    String descriptionProduit,
    double stockProduit,
    int idFournisseur,
  ) async {
    FormData data = FormData.fromMap({
      'refProd': refProduit,
      'nomProd': nomProduit,
      'prixAchatHT': prixAchatProduit,
      'prixVenteHT': prixVenteProduit,
      'descriptionProd': descriptionProduit,
      'stock': stockProduit,
      'tvaProd': tvaProduit,
      'id_fournisseur': idFournisseur
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
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(120, 60, 120, 60),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: 50.0, minHeight: 50.0),
                                        child: InputField(
                                          label: "Référence du produit",
                                          content:
                                              "Tapez la référence du produit",
                                          fieldController: refProduit,
                                          whattoAllow:
                                              RegExp('[a-z A-Z á-ú Á-Ú 0-9]'),
                                          fieldValidator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Ce Champ est obligatoire";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: 50.0, minHeight: 50.0),
                                        child: InputField(
                                          label: "Nom du produit",
                                          content: "Tapez le nom du produit",
                                          whattoAllow:
                                              RegExp('[a-z A-Z á-ú Á-Ú 0-9]'),
                                          fieldController: nomProduit,
                                          fieldValidator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Ce Champ est obligatoire";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: 150.0, minHeight: 150.0),
                                        child: InputFieldDescription(
                                          content:
                                              'Tapez la description du produit',
                                          label: 'Description du produit',
                                          fieldController: descriptionProduit,
                                          fieldValidator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Ce Champ est obligatoire";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 25),
                              Expanded(
                                flex: 2,
                                child: Column(children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: 50.0, minHeight: 50.0),
                                    child: InputField(
                                        label: "Prix d'achat HT",
                                        content: "Prix d'achat du produit HT",
                                        fieldController: prixAchatProduit,
                                        whattoAllow: RegExp('[0-9 . ]'),
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        }),
                                  ),
                                  const SizedBox(height: 20),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: 50.0, minHeight: 50.0),
                                    child: InputField(
                                        label: "Prix de vente HT",
                                        content: "Prix de vente du produit HT",
                                        fieldController: prixVenteProduit,
                                        whattoAllow: RegExp('[0-9 . ]'),
                                        fieldValidator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Ce Champ est obligatoire";
                                          }
                                          return null;
                                        }),
                                  ),
                                  const SizedBox(height: 20),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: 50.0, minHeight: 50.0),
                                    child: InputField(
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
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Fournisseur",
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 15),
                                          )),
                                      Expanded(
                                        flex: 3,
                                        child: DropdownButton(
                                          // Initial Value
                                          hint: Text(
                                              "Sélectionnez le fournisseur"),
                                          value: dropdownvalue,
                                          underline: SizedBox(),
                                          // Down Arrow Ico

                                          //icon: const Icon(Icons.keyboard_arrow_down),

                                          // Array list of items
                                          items: raisonSociale.values
                                              .toList()
                                              .map((String itemss) {
                                            return DropdownMenuItem(
                                              value: itemss,
                                              child: Text(itemss),
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                              idFournisseur = raisonSociale.keys
                                                  .firstWhere((element) =>
                                                      raisonSociale[element] ==
                                                      newValue);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(height: 20),
                                    ],
                                  )
                                ]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MaterialButton(
                                height: 55,
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
                                height: 55,
                                color: const Color.fromARGB(255, 75, 100, 211),
                                onPressed: () {
                                  print(dropdownvalue);
                                  if (dropdownvalue == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: (secondaryColor),
                                          content: Text(
                                            'Le champ fournisseur est obligatoire',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 250, 253, 255)),
                                          )),
                                    );
                                  }

                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      future = upload(
                                          refProduit.text,
                                          nomProduit.text,
                                          double.parse(prixAchatProduit.text),
                                          double.parse(prixVenteProduit.text),
                                          double.parse(tvaProduit.text),
                                          descriptionProduit.text,
                                          0.0,
                                          idFournisseur);
                                    });

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
    );
  }
}
