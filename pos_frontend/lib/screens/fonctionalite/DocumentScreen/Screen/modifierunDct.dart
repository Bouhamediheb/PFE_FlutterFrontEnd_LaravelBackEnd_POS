//import 'package:projetpfe/screens/fonctionalite/DocumentScreen/Widget/input_doc_produit_ref_nom.dart';
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../../main/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:projetpfe/constants.dart';

import '../Widget/seqDocNumero.dart';

class modifierUnDocument extends StatefulWidget {
  List<TextEditingController> controllers = [];
  List<TextEditingController> controllers2 = [];
  int? documentId;
  int ligneDocumentId;
  int typeDoc;
  modifierUnDocument(this.ligneDocumentId, this.documentId, this.typeDoc);

  @override
  State<modifierUnDocument> createState() => _modifierUnDocumentState();
}

class _modifierUnDocumentState extends State<modifierUnDocument>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    this.fetchDocuments();
    this.fetchLigneDocuments();
    this.fetchProduits();
  }

  List<dynamic> refProduits = [];
  List? produits = [];
  String? selectedProduit;
  String? nomProduit;

  modifierDocument(int? id, double totalDoc) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/document/total/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{'totalDoc': totalDoc}),
    );
    if (response.statusCode == 200) {
      print('Total Document Modifié');
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  modifierLigneDocument(int id, String refProd, String nomProd, double qteProd,
      double prixProd, tvaProd) async {
    final response = await http.put(
      Uri.parse("http://127.0.0.1:8000/api/lignedocument/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'refProd': refProd,
        'nomProd': nomProd,
        'qteProd': qteProd,
        'prixProd': prixProd,
        'tvaProd': tvaProd
      }),
    );
    if (response.statusCode == 200) {
      print("Ligne Document Modifié");
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  fetchProduits() async {
    var idFournisseur;
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/produit'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        produits = items;
      });
    } else {
      throw Exception('Error!');
    }
    for (var i = 0; i < produits!.length; i++) {
      if (ligneDocuments![0]['refProd'] == produits![i]['refProd']) {
        idFournisseur = produits![i]['id_fournisseur'];
        break;
      }
      break;
    }
    for (var i = 0; i < produits!.length; i++) {
      setState(() {
        if (widget.typeDoc == 1 || widget.typeDoc == 2) {
          if (produits![i]['id_fournisseur'] == idFournisseur) {
            refProduits.add(produits![i]['refProd']);
          }
        } else {
          refProduits.add(produits![i]['refProd']);
        }
      });
      print(refProduits);
    }
  }

  String totalDoc = "0";
  final DateTime date = new DateTime.now();
  String? numSeqDocument;
  int? idDoc;
  Map<String, dynamic> documents = {};
  String? dateDoc;
  String? numDoc;
  bool confirmButton = true;

  List? ligneDocuments = [];
  List<TextEditingController> stockInitial = [];
  Map<int, DataRow> ligneDoc = {};
  TextEditingController totalDocument = TextEditingController(text: '0');

  ajoutLigneDocument(int? idDoc, String refProd, String nomProd, double qteProd,
      double prixProd, double tvaProd) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/lignedocument"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_doc': idDoc,
        'refProd': refProd,
        'nomProd': nomProd,
        'qteProd': qteProd,
        'prixProd': prixProd,
        'tvaProd': tvaProd
      }),
    );
    if (response.statusCode == 200) {
      print("Ligne Document Ajouté");
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  supprimerLigneDocument(int id) async {
    final response = await http.delete(
        Uri.parse("http://127.0.0.1:8000/api/lignedocument/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
  }

  modificationStock(String refProd, double stock) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/produit/stock/$refProd"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'stock': stock,
      }),
    );
    if (response.statusCode == 200) {
      print("Quantité du Produit Modifié");
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  fetchDocuments() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/document/${widget.documentId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);

      setState(() {
        documents = items;
        print(documents.toString());
        totalDocument.text = documents['totalDoc'].toStringAsFixed(3);
      });
    } else {
      throw Exception('Error!');
    }
  }

  List<TextEditingController> totalTTCDocument = [];
  List<TextEditingController> idsToRemove = [];

  fetchLigneDocuments() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/lignedocument'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        ligneDocuments = items;
      });
    } else {
      throw Exception('Error!');
    }
    for (var i = 0; i < ligneDocuments!.length; i++) {
      if (ligneDocuments![i]['id_doc'] == widget.ligneDocumentId) {
        var idligne = ligneDoc.length + 1;

        setState(() {
          TextEditingController qteInitial = TextEditingController(
              text: ligneDocuments![i]['qteProd'].toString());
          stockInitial.add(qteInitial);
          TextEditingController idController = new TextEditingController();
          widget.controllers.add(idController);
          idController.text = ligneDocuments![i]['id'].toString();
          TextEditingController referenceController =
              new TextEditingController();
          widget.controllers.add(referenceController);
          referenceController.text = ligneDocuments![i]['refProd'].toString();
          TextEditingController nomController = new TextEditingController();
          widget.controllers.add(nomController);
          nomController.text = ligneDocuments![i]['nomProd'].toString();
          TextEditingController quantiteController =
              new TextEditingController();
          widget.controllers.add(quantiteController);
          quantiteController.text = ligneDocuments![i]['qteProd'].toString();
          TextEditingController prixController = new TextEditingController();
          widget.controllers.add(prixController);
          prixController.text =
              ligneDocuments![i]['prixProd'].toStringAsFixed(3);

          TextEditingController tvaController = new TextEditingController();
          widget.controllers.add(tvaController);
          tvaController.text = ligneDocuments![i]['tvaProd'].toString();
          TextEditingController totalHTController = new TextEditingController();
          totalHTController.text = (double.parse(prixController.text) *
                  double.parse(quantiteController.text))
              .toStringAsFixed(3);
          TextEditingController totalTTCController =
              new TextEditingController();
          totalTTCController.text = (double.parse(totalHTController.text) *
                  (1 + double.parse(tvaController.text) / 100))
              .toStringAsFixed(3);
          totalTTCDocument.add(totalTTCController);
          ligneDoc[idligne] = DataRow(
            cells: <DataCell>[
              DataCell(
                SearchField(
                  hasOverlay: true,
                  hint: "Taper la référence du produit",
                  searchStyle: TextStyle(color: Colors.white),
                  controller: referenceController,
                  searchInputDecoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 190, 190, 190),
                        fontSize: 14),
                  ),
                  suggestionItemDecoration: BoxDecoration(
                      color: Color(0xFF2A2D3E),
                      border: Border.all(color: Colors.white, width: 1.0)),
                  suggestions: refProduits
                      .map((e) => SearchFieldListItem<dynamic>(e, item: e))
                      .toList(),
                  maxSuggestionsInViewPort: 6,
                  suggestionsDecoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  suggestionState: Suggestion.expand,
                  textInputAction: TextInputAction.next,
                  onSubmit: (value) {
                    print(value);
                    setState(() {
                      selectedProduit = value;
                      for (var i = 0; i < produits!.length; i++) {
                        if (selectedProduit == produits![i]['refProd']) {
                          nomProduit = produits![i]['nomProd'];
                          nomController.text = nomProduit.toString();
                          prixController.text =
                              produits![i]['prixProd'].toStringAsFixed(3);
                          tvaController.text =
                              produits![i]['tvaProd'].toString();
                        }
                      }
                    });
                  },
                ),
              ),
              DataCell(
                TextFormField(
                  enabled: false,
                  controller: nomController,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "Nom du Produit",
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 190, 190, 190),
                        fontSize: 14),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              DataCell(
                Container(
                  width: 145,
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        setState(() {
                          totalHTController.text =
                              (double.parse(quantiteController.text) *
                                      double.parse(prixController.text))
                                  .toStringAsFixed(3);
                        });

                        setState(() {
                          totalTTCController
                              .text = (double.parse(totalHTController.text) *
                                  (1 +
                                      (double.parse(tvaController.text) / 100)))
                              .toStringAsFixed(3);
                        });

                        setState(() {
                          var total = 0.0;
                          for (var i = 0; i < totalTTCDocument.length; i++) {
                            if (totalTTCDocument[i].text != "" ||
                                totalTTCDocument[i].text.isNotEmpty) {
                              total += double.parse(totalTTCDocument[i].text);
                            }
                          }
                          totalDocument.text = total.toStringAsFixed(3);
                        });
                      }
                    },
                    child: TextFormField(
                      controller: quantiteController,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "Taper la quantité",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 190, 190, 190),
                            fontSize: 14),
                        fillColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(
                Container(
                  width: 145,
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        setState(() {
                          totalHTController.text =
                              (double.parse(quantiteController.text) *
                                      double.parse(prixController.text))
                                  .toStringAsFixed(3);
                        });

                        setState(() {
                          totalTTCController
                              .text = (double.parse(totalHTController.text) *
                                  (1 +
                                      (double.parse(tvaController.text) / 100)))
                              .toStringAsFixed(3);
                        });

                        setState(() {
                          var total = 0.0;
                          for (var i = 0; i < totalTTCDocument.length; i++) {
                            if (totalTTCDocument[i].text != "" ||
                                totalTTCDocument[i].text.isNotEmpty) {
                              total += double.parse(totalTTCDocument[i].text);
                            }
                          }
                          totalDocument.text = total.toStringAsFixed(3);
                        });
                      }
                    },
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      enabled: true,
                      controller: prixController,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "Taper le Prix",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 190, 190, 190),
                            fontSize: 14),
                        fillColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 145,
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        setState(() {
                          totalTTCController
                              .text = (double.parse(totalHTController.text) *
                                  (1 +
                                      (double.parse(tvaController.text) / 100)))
                              .toString();
                        });
                        var total = 0.0;
                        for (var i = 0; i < totalTTCDocument.length; i++) {
                          total =
                              total + double.parse(totalTTCDocument[i].text);
                        }
                        totalDocument.text = total.toString();
                      }
                    },
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      enabled: false,
                      controller: tvaController,
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        suffixText: "%",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "Taper le TVA",
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 190, 190, 190),
                            fontSize: 14),
                        fillColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 145,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    enabled: false,
                    controller: totalHTController,
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      suffixText: 'DT',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: "Total HT",
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 190, 190, 190),
                          fontSize: 14),
                      fillColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 145,
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    enabled: false,
                    controller: totalTTCController,
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      suffixText: 'DT',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: "Total TTC",
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 190, 190, 190),
                          fontSize: 14),
                      fillColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              DataCell(IconButton(
                  icon: Icon(
                    Icons.highlight_remove,
                    color: Colors.red,
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      ligneDoc.remove(idligne);
                      idsToRemove.add(idController);
                      stockInitial.remove(qteInitial);
                      widget.controllers.remove(idController);
                      widget.controllers.remove(referenceController);
                      widget.controllers.remove(nomController);
                      widget.controllers.remove(quantiteController);
                      widget.controllers.remove(prixController);
                      widget.controllers.remove(tvaController);
                      totalTTCDocument.remove(totalTTCController);
                    });
                    setState(() {
                      var total = 0.0;
                      for (var i = 0; i < totalTTCDocument.length; i++) {
                        if (totalTTCDocument[i].text != "" ||
                            totalTTCDocument[i].text.isNotEmpty) {
                          total += double.parse(totalTTCDocument[i].text);
                        }
                      }
                      totalDocument.text = total.toStringAsFixed(3);
                    });
                  }))
            ],
          );
        });
      }
    }
  }

  void ajouterLigne() {
    var idligne = ligneDoc.length + 1;
    setState(() {
      confirmButton = true;
    });

    TextEditingController referenceController = TextEditingController();
    widget.controllers2.add(referenceController);
    TextEditingController nomController = TextEditingController();
    widget.controllers2.add(nomController);
    TextEditingController quantiteController = TextEditingController();
    widget.controllers2.add(quantiteController);
    TextEditingController prixController = TextEditingController();
    widget.controllers2.add(prixController);
    TextEditingController tvaController = new TextEditingController();
    widget.controllers2.add(tvaController);
    TextEditingController totalHTController = new TextEditingController();
    TextEditingController totalTTCController = new TextEditingController();
    totalTTCDocument.add(totalTTCController);
    ligneDoc[idligne] = DataRow(
      cells: <DataCell>[
        DataCell(
          SearchField(
            hasOverlay: true,
            hint: "Taper la référence du produit",
            searchStyle: const TextStyle(color: Colors.white),
            controller: referenceController,
            validator: (value) {
              if (value!.isEmpty || value == "") {
                return 'Référence obligatoire';
              } else {
                return "";
              }
            },
            searchInputDecoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
            ),
            suggestionItemDecoration: BoxDecoration(
                color: const Color(0xFF2A2D3E),
                border: Border.all(color: Colors.white, width: 1.0)),
            suggestions: refProduits
                .map((e) => SearchFieldListItem<dynamic>(e, item: e))
                .toList(),
            maxSuggestionsInViewPort: 6,
            suggestionsDecoration: const BoxDecoration(
              color: Colors.white,
            ),
            suggestionState: Suggestion.expand,
            textInputAction: TextInputAction.next,
            onSubmit: (value) {
              print(value);
              setState(() {
                selectedProduit = value;
                for (var i = 0; i < produits!.length; i++) {
                  if (selectedProduit == produits![i]['refProd']) {
                    nomProduit = produits![i]['nomProd'];
                    nomController.text = nomProduit.toString();
                    prixController.text =
                        produits![i]['prixVenteHT'].toStringAsFixed(3);
                    tvaController.text = produits![i]['tvaProd'].toString();
                  }
                }
              });
            },
          ),
        ),
        DataCell(
          TextFormField(
            enabled: false,
            controller: nomController,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
              hintText: "Commencez par taper la référence à gauche",
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
              fillColor: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 145,
            child: Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  setState(() {
                    totalHTController.text =
                        (double.parse(quantiteController.text) *
                                double.parse(prixController.text))
                            .toStringAsFixed(3);
                  });

                  setState(() {
                    totalTTCController.text =
                        (double.parse(totalHTController.text) *
                                (1 + (double.parse(tvaController.text) / 100)))
                            .toStringAsFixed(3);
                  });

                  setState(() {
                    var total = 0.0;
                    for (var i = 0; i < totalTTCDocument.length; i++) {
                      if (totalTTCDocument[i].text != "" ||
                          totalTTCDocument[i].text.isNotEmpty) {
                        total += double.parse(totalTTCDocument[i].text);
                      }
                    }
                    totalDocument.text = total.toStringAsFixed(3);
                  });
                }
              },
              child: TextFormField(
                controller: quantiteController,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Quantité obligatoire';
                  } else {
                    return "";
                  }
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Taper la quantité",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 145,
            child: Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  setState(() {
                    totalHTController.text =
                        (double.parse(quantiteController.text) *
                                double.parse(prixController.text))
                            .toStringAsFixed(3);
                  });

                  setState(() {
                    totalTTCController.text =
                        (double.parse(totalHTController.text) *
                                (1 + (double.parse(tvaController.text) / 100)))
                            .toStringAsFixed(3);
                  });

                  setState(() {
                    var total = 0.0;
                    for (var i = 0; i < totalTTCDocument.length; i++) {
                      if (totalTTCDocument[i].text != "" ||
                          totalTTCDocument[i].text.isNotEmpty) {
                        total += double.parse(totalTTCDocument[i].text);
                      }
                    }
                    totalDocument.text = total.toStringAsFixed(3);
                  });
                }
              },
              child: TextFormField(
                textInputAction: TextInputAction.done,
                enabled: true,
                controller: prixController,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  suffixText: "DT",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Taper le Prix",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 145,
            child: Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  setState(() {
                    totalTTCController.text =
                        (double.parse(totalHTController.text) *
                                (1 + (double.parse(tvaController.text) / 100)))
                            .toStringAsFixed(3);
                  });
                  setState(() {
                    var total = 0.0;
                    for (var i = 0; i < totalTTCDocument.length; i++) {
                      if (totalTTCDocument[i].text != "" ||
                          totalTTCDocument[i].text.isNotEmpty) {
                        total = total + double.parse(totalTTCDocument[i].text);
                      }
                      totalDocument.text = total.toStringAsFixed(3);
                    }
                  });
                }
              },
              child: TextFormField(
                textInputAction: TextInputAction.done,
                enabled: false,
                controller: tvaController,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  suffixText: "%",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Taper le TVA",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 145,
            child: TextFormField(
              textInputAction: TextInputAction.done,
              enabled: false,
              controller: totalHTController,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                suffixText: 'DT',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.0),
                hintText: "Total HT",
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
                fillColor: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 145,
            child: TextFormField(
              textInputAction: TextInputAction.done,
              enabled: false,
              controller: totalTTCController,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                suffixText: 'DT',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10.0),
                hintText: "Total TTC",
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
                fillColor: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
        DataCell(IconButton(
            icon: Icon(
              Icons.highlight_remove,
              color: Colors.red,
              size: 24,
            ),
            onPressed: () {
              setState(() {
                ligneDoc.remove(idligne);
                widget.controllers2.remove(referenceController);
                widget.controllers2.remove(nomController);
                widget.controllers2.remove(quantiteController);
                widget.controllers2.remove(prixController);
                widget.controllers2.remove(tvaController);
                totalTTCDocument.remove(totalTTCController);
              });
              setState(() {
                var total = 0.0;
                for (var i = 0; i < totalTTCDocument.length; i++) {
                  if (totalTTCDocument[i].text != "" ||
                      totalTTCDocument[i].text.isNotEmpty) {
                    total += double.parse(totalTTCDocument[i].text);
                  }
                }
                totalDocument.text = total.toStringAsFixed(3);
              });
            }))
      ],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) &&
            event.isKeyPressed(LogicalKeyboardKey.f1)) {
          setState(() {
            ajouterLigne();
          });
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
          child: Form(
            key: _formKey,
            child: Card(
              shadowColor: Color.fromARGB(255, 255, 255, 255),
              color: bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 0,
              child: Container(
                width: 1300,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Modification du document",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            SeqDoc(
                                label: 'Numero de Séquence',
                                content: '${documents['numDoc']}',
                                label2: 'Date',
                                label3: 'Liste des Fournisseurs'),
                            Divider(
                              thickness: 3,
                            ),
                            SizedBox(
                              height: 500,
                              child: DataTable2(
                                showCheckboxColumn: true,
                                dataRowHeight: 50,
                                columnSpacing: 30,
                                columns: [
                                  DataColumn2(
                                    label: Text(
                                      "Référence Produit",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      "Nom Produit",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    label: Text(
                                      "Quantité",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    label: Text(
                                      "Prix HT Unitaire",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    label: Text(
                                      "TVA",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    label: Text(
                                      "Total HT",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    label: Text(
                                      "Total TTC",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    label: Text(
                                      "",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                rows: ligneDoc.values.toList(),
                              ),
                            ),

                            //Membership Widget from the widgets folder

                            SizedBox(
                              width: 1300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  MaterialButton(
                                    height: 53,
                                    color: Color.fromARGB(255, 253, 0, 0),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Annuler",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  MaterialButton(
                                    height: 53,
                                    color: Color.fromARGB(255, 112, 112, 112),
                                    onPressed: () {
                                      ajouterLigne();
                                    },
                                    child: Text(
                                      "Ajouter une ligne",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  MaterialButton(
                                    height: 53,
                                    color: Color.fromARGB(255, 75, 100, 211),
                                    onPressed: () async {
                                      if (confirmButton) {
                                        var j = 0;
                                        for (var i = 5;
                                            i < widget.controllers.length;
                                            i = i + 6) {
                                          print(stockInitial[j].text);
                                          if (widget.controllers[i - 5].text
                                                  .isNotEmpty ||
                                              widget.controllers[i - 4].text
                                                  .isNotEmpty ||
                                              widget.controllers[i - 3].text
                                                  .isNotEmpty ||
                                              widget.controllers[i - 2].text
                                                  .isNotEmpty ||
                                              widget.controllers[i - 1].text
                                                  .isNotEmpty ||
                                              widget.controllers[i].text
                                                  .isNotEmpty) {
                                            modifierLigneDocument(
                                                int.parse(widget
                                                    .controllers[i - 5].text),
                                                widget.controllers[i - 4].text,
                                                widget.controllers[i - 3].text,
                                                double.parse(widget
                                                    .controllers[i - 2].text),
                                                double.parse(widget
                                                    .controllers[i - 1].text),
                                                double.parse(widget
                                                    .controllers[i].text));
                                            if (widget.typeDoc == 2) {
                                              double stockToModify = (double
                                                      .parse(widget
                                                          .controllers[i - 2]
                                                          .text) -
                                                  double.parse(
                                                      stockInitial[j].text));

                                              modificationStock(
                                                  (widget.controllers[i - 4]
                                                          .text)
                                                      .toString(),
                                                  stockToModify);
                                              j = j + 1;
                                            } else if (widget.typeDoc == 6) {
                                              double stockToModify = (double
                                                      .parse(widget
                                                          .controllers[i - 2]
                                                          .text) -
                                                  double.parse(
                                                      stockInitial[j].text));

                                              modificationStock(
                                                  (widget.controllers[i - 4]
                                                          .text)
                                                      .toString(),
                                                  (stockToModify * -1));
                                              j = j + 1;
                                            }
                                          }
                                        }
                                        for (var i = 0;
                                            i < idsToRemove.length;
                                            i++) {
                                          supprimerLigneDocument(
                                              int.parse(idsToRemove[i].text));
                                        }
                                        modifierDocument(widget.documentId,
                                            double.parse(totalDocument.text));

                                        for (var i = 4;
                                            i < widget.controllers2.length;
                                            i = i + 5) {
                                          if (widget.controllers2[i - 4].text
                                                  .isNotEmpty ||
                                              widget.controllers2[i - 3].text
                                                  .isNotEmpty ||
                                              widget.controllers2[i - 2].text
                                                  .isNotEmpty ||
                                              widget.controllers2[i - 1].text
                                                  .isNotEmpty ||
                                              widget.controllers2[i].text
                                                  .isNotEmpty) {
                                            ajoutLigneDocument(
                                                widget.documentId,
                                                widget.controllers2[i - 4].text,
                                                widget.controllers2[i - 3].text,
                                                double.parse(widget
                                                    .controllers2[i - 2].text),
                                                double.parse(widget
                                                    .controllers2[i - 1].text),
                                                double.parse(widget
                                                    .controllers2[i].text));
                                            if (widget.typeDoc == 2) {
                                              modificationStock(
                                                  widget
                                                      .controllers2[i - 4].text,
                                                  double.parse(widget
                                                      .controllers2[i - 2]
                                                      .text));
                                            } else if (widget.typeDoc == 6) {
                                              modificationStock(
                                                  widget
                                                      .controllers2[i - 4].text,
                                                  (double.parse(widget
                                                          .controllers2[i - 2]
                                                          .text) *
                                                      -1));
                                            }
                                          }
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarSucces);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MainScreen(
                                                  DashboardScreen())),
                                        );
                                      }
                                      ;
                                    },
                                    child: Text(
                                      "Confirmer",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 300,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      "Montant Total :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: TextFormField(
                                        controller: totalDocument,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          hintText: '$totalDoc',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade400,
                                          ),
                                          prefixIcon: Icon(
                                              Icons.attach_money_outlined,
                                              color: Colors.grey.shade400),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 1,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 1,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade400,
                                              width: 1,
                                            ),
                                          ),
                                          contentPadding:
                                              EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
