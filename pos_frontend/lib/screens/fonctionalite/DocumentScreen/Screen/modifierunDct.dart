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
  int? ligneDocumentId;
  modifierUnDocument(this.ligneDocumentId, this.documentId);

  @override
  State<modifierUnDocument> createState() => _modifierUnDocumentState();
}

class _modifierUnDocumentState extends State<modifierUnDocument>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    this.fetchDocuments();
    this.fetchProduits();
    this.fetchLigneDocuments();
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

  modifierLigneDocument(int id, int? idDoc, String refProd, String nomProd,
      double qteProd, double prixProd) async {
    final response = await http.put(
      Uri.parse("http://127.0.0.1:8000/api/lignedocument/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_doc': idDoc,
        'refProd': refProd,
        'nomProd': nomProd,
        'qteProd': qteProd,
        'prixProd': prixProd,
      }),
    );
    if (response.statusCode == 200) {
      print("Ligne Document Modifié");
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  fetchProduits() async {
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
        print(produits);
      });
    } else {
      throw Exception('Error!');
    }
    for (var i = 0; i < produits!.length; i++) {
      setState(() {
        refProduits.add(produits![i]['refProd']);
      });
      print(refProduits);
    }
  }

  String totalDoc = "0";
  final DateTime date = new DateTime.now();
  String? numSeqDocument;
  int? idDoc;
  List? documents = [];
  String? dateDoc;
  String? numDoc;
  bool confirmButton = true;
  int idligne = -1;
  List? ligneDocuments = [];
  List stockInitial = [];
  List<DataRow> ligneDoc = [];
  TextEditingController totalDocument = TextEditingController(text: '0');

  Future<http.Response?> ajoutDocument(
      int type, String? numeroDoc, String? dateDoc, double totalDoc) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/document"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'type': type,
        'numDoc': numeroDoc,
        'dateDoc': dateDoc,
        'totalDoc': totalDoc
      }),
    );
    if (response.statusCode == 200) {
      print("Document Ajouté");
    } else {
      throw Exception('Erreur base de données!');
    }
    return null;
  }

  ajoutLigneDocument(int? idDoc, String refProd, String nomProd, double qteProd,
      double prixProd) async {
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
      }),
    );
    if (response.statusCode == 200) {
      print("Ligne Document Ajouté");
    } else {
      throw Exception('Erreur base de données!');
    }
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
      Uri.parse('http://127.0.0.1:8000/api/document'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        documents = items;
        idDoc = documents![documents!.length - 1]['id'] + 1;
        totalDocument.text =
            documents![widget.documentId! - 1]['totalDoc'].toString();
      });
    } else {
      throw Exception('Error!');
    }
  }

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
        for (var i = 0; i < items.length; i++) {
          stockInitial.add(items[i]['qteProd']);
          print(stockInitial);
        }
      });
    } else {
      throw Exception('Error!');
    }
    for (var i = 0; i < ligneDocuments!.length; i++) {
      if (ligneDocuments![i]['id_doc'] == widget.ligneDocumentId) {
        setState(() {
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
          prixController.text = ligneDocuments![i]['prixProd'].toString();
          TextEditingController totalProdController =
              new TextEditingController();
          totalProdController.text = (double.parse(prixController.text) *
                  double.parse(quantiteController.text))
              .toString();
          ligneDoc.add(
            DataRow(
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
                          double totalC1 = 0;
                          double totalC2 = 0;
                          double total = 0;
                          for (var i = 4;
                              i <= widget.controllers.length;
                              i = i + 5) {
                            totalC1 = totalC1 +
                                (double.parse(widget.controllers[i].text) *
                                    double.parse(
                                        widget.controllers[i - 1].text));
                          }
                          for (var i = 3;
                              i <= widget.controllers2.length;
                              i = i + 4) {
                            totalC2 = totalC2 +
                                (double.parse(widget.controllers2[i].text) *
                                    double.parse(
                                        widget.controllers2[i - 1].text));
                          }
                          setState(() {
                            total = totalC1 + totalC2;
                            totalDocument.text = total.toString();
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
                          double totalC1 = 0;
                          double totalC2 = 0;
                          double total = 0;
                          for (var i = 4;
                              i <= widget.controllers.length;
                              i = i + 5) {
                            totalC1 = totalC1 +
                                (double.parse(widget.controllers[i].text) *
                                    double.parse(
                                        widget.controllers[i - 1].text));
                          }
                          for (var i = 3;
                              i <= widget.controllers2.length;
                              i = i + 4) {
                            totalC2 = totalC2 +
                                (double.parse(widget.controllers2[i].text) *
                                    double.parse(
                                        widget.controllers2[i - 1].text));
                          }
                          setState(() {
                            total = totalC1 + totalC2;
                            totalDocument.text = total.toString();
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
              ],
            ),
          );
        });
      }
    }
  }

  Future<dynamic>? future;

  void ajouterLigne() {
    TextEditingController referenceController = TextEditingController();
    widget.controllers2.add(referenceController);
    TextEditingController nomController = TextEditingController();
    widget.controllers2.add(nomController);
    TextEditingController quantiteController = TextEditingController();
    widget.controllers2.add(quantiteController);
    TextEditingController prixController = TextEditingController();
    widget.controllers2.add(prixController);
    ligneDoc.add(
      DataRow(
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
                    color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
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
                    color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
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
                    double totalC1 = 0;
                    double totalC2 = 0;
                    double total = 0;
                    for (var i = 4; i <= widget.controllers.length; i = i + 5) {
                      totalC1 = totalC1 +
                          (double.parse(widget.controllers[i].text) *
                              double.parse(widget.controllers[i - 1].text));
                    }
                    for (var i = 3;
                        i <= widget.controllers2.length;
                        i = i + 4) {
                      totalC2 = totalC2 +
                          (double.parse(widget.controllers2[i].text) *
                              double.parse(widget.controllers2[i - 1].text));
                    }
                    setState(() {
                      total = totalC1 + totalC2;
                      totalDocument.text = total.toString();
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
                    double totalC1 = 0;
                    double totalC2 = 0;
                    double total = 0;
                    for (var i = 4; i <= widget.controllers.length; i = i + 5) {
                      totalC1 = totalC1 +
                          (double.parse(widget.controllers[i].text) *
                              double.parse(widget.controllers[i - 1].text));
                    }
                    for (var i = 3;
                        i <= widget.controllers2.length;
                        i = i + 4) {
                      totalC2 = totalC2 +
                          (double.parse(widget.controllers2[i].text) *
                              double.parse(widget.controllers2[i - 1].text));
                    }
                    setState(() {
                      total = totalC1 + totalC2;
                      totalDocument.text = total.toString();
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
                    suffixText: "DT",
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
        ],
      ),
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
                                content:
                                    '${documents![widget.documentId! - 1]['numDoc']}',
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
                                      "Prix",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                rows: ligneDoc,
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
                                        int j = 0;
                                        for (var i = 4;
                                            i < widget.controllers.length;
                                            i = i + 5) {
                                          future = modifierLigneDocument(
                                              int.parse(widget
                                                  .controllers[i - 4].text),
                                              widget.documentId,
                                              widget.controllers[i - 3].text,
                                              widget.controllers[i - 2].text,
                                              double.parse(widget
                                                  .controllers[i - 1].text),
                                              double.parse(
                                                  widget.controllers[i].text));
                                          future = modificationStock(
                                              widget.controllers[i - 3].text,
                                              (double.parse(widget
                                                      .controllers[i - 1]
                                                      .text) -
                                                  stockInitial[j]));
                                          j++;
                                        }
                                        for (var i = 0;
                                            i < documents!.length;
                                            i++) {
                                          if (documents![i]['id'] ==
                                              widget.ligneDocumentId) {
                                            modifierDocument(
                                                documents![i]['id'],
                                                double.parse(
                                                    totalDocument.text));
                                          }
                                        }
                                        for (var i = 3;
                                            i < widget.controllers2.length;
                                            i = i + 4) {
                                          future = ajoutLigneDocument(
                                              widget.documentId,
                                              widget.controllers2[i - 3].text,
                                              widget.controllers2[i - 2].text,
                                              double.parse(widget
                                                  .controllers2[i - 1].text),
                                              double.parse(
                                                  widget.controllers2[i].text));
                                          future = modificationStock(
                                              widget.controllers2[i - 3].text,
                                              double.parse(widget
                                                  .controllers2[i - 1].text));
                                        }
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
