// ignore_for_file: camel_case_types, must_be_immutable, depend_on_referenced_packages

import 'package:projetpfe/constants.dart';
import 'package:projetpfe/screens/fonctionalite/DocumentScreen/Widget/seqDocNumero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../../main/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:data_table_2/data_table_2.dart';

class ajouterUnDocument2 extends StatefulWidget {
  final int id;
  final String doctype;

  List<TextEditingController> controllers = [];

  ajouterUnDocument2(this.id, this.doctype, {Key? key}) : super(key: key);
  @override
  State<ajouterUnDocument2> createState() => _ajouterUnDocumentState();
}

class _ajouterUnDocumentState extends State<ajouterUnDocument2>
    with SingleTickerProviderStateMixin {
  List<dynamic> refProduits = [];
  List? produits = [];
  String? selectedProduit;
  String? nomProduit;
  late List fournisseurs = [];
  String? dropdownvalue;
  late Map<int, String> raisonSocialeFournisseur = {};
  late int idFournisseur;

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
          raisonSocialeFournisseur[fournisseurs[i]['id']] =
              fournisseurs[i]['raisonSociale'];
        }
      });
    } else {
      throw Exception('Error!');
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
      });
    } else {
      throw Exception('Error!');
    }
    for (var i = 0; i < produits!.length; i++) {
      setState(() {
        if (widget.id == 1 || widget.id == 2) {
          if (produits![i]['id_fournisseur'] == idFournisseur)
            refProduits.add(produits![i]['refProd']);
        } else {
          refProduits.add(produits![i]['refProd']);
        }
      });
    }
  }

  double total = 0;
  String totalDoc = "0";
  final DateTime date = DateTime.now();
  String? numSeqDocument;
  int? idSeq;
  late int idDoc;
  List? documents = [];
  String? dateDoc;
  String? numDoc;
  bool confirmButton = false;
  int idligne = -1;
  bool selectionFrs = false;
  /*
static const snackBarSucces = SnackBar(
    content: Text('Tâche effectuée avec succès'),
  );

static const snackBarStockError = SnackBar(
    content: Text('Certains articles ont un stock insuffisant'),
  );
*/
  TextEditingController totalDocument = TextEditingController(text: '0');

  late num? Stokkkkk;

  ajoutDocument(
      int type, String? numeroDoc, String? dateDoc, double totalDoc) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/document"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'type': type,
        'numDoc': numeroDoc,
        'dateDoc': dateDoc,
        'totalDoc': totalDoc
      }),
    );
    if (response.statusCode == 200) {
      return documents = jsonDecode(response.body);
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  ajoutLigneDocument(int idDoc, String refProd, String nomProd, double qteProd,
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

  getidDoc() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/document'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        if (items.isEmpty)
          idDoc = 1;
        else {
          idDoc = items[items.length - 1]['id'] + 1;
        }
      });
    }
  }

  Future<int> getStock(String refProd) async {
    int stok = 0;
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/produit/stock/$refProd"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        stok = jsonDecode(response.body);
      });
      return stok;
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

  updateSeqDocument() async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/seqdoc/${widget.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      print("Numéro de Document Modifié");
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSequence();
    fetchProduits();
    fetchFours();
    getidDoc();
  }

  fetchSequence() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/seqdoc/${widget.id}'),
      headers: <String, String>{
        'Accept': 'application/json; charset=utf-8',
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        idSeq = items['seq_id'] + 1;
      });
    }
  }

  Future<dynamic>? future;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String seqDocument() {
    if (widget.id == 1) {
      idSeq ??= 1;
      return numSeqDocument = '${date.toString().substring(0, 10)}/BC$idSeq';
    } else if (widget.id == 2) {
      idSeq ??= 1;
      return numSeqDocument = '${date.toString().substring(0, 10)}/BE$idSeq';
    } else if (widget.id == 3) {
      idSeq ??= 1;
      return numSeqDocument = '${date.toString().substring(0, 10)}/BR$idSeq';
    } else if (widget.id == 6) {
      idSeq ??= 1;
      return numSeqDocument = '${date.toString().substring(0, 10)}/BS$idSeq';
    } else
      return numSeqDocument = 'Vérifier Base de Données';
  }

  Map<int, DataRow> ligneDoc = {};
  List<TextEditingController> totalTTCDocument = [];

  void ajouterLigne() {
    var idligne = ligneDoc.length + 1;
    setState(() {
      confirmButton = true;
    });

    TextEditingController referenceController = TextEditingController();
    widget.controllers.add(referenceController);
    TextEditingController nomController = TextEditingController();
    widget.controllers.add(nomController);
    TextEditingController quantiteController = TextEditingController();
    widget.controllers.add(quantiteController);
    TextEditingController prixController = TextEditingController();
    widget.controllers.add(prixController);
    TextEditingController tvaController = new TextEditingController();
    widget.controllers.add(tvaController);

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
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) &&
            event.isKeyPressed(LogicalKeyboardKey.f1)) {
          setState(() {
            if (selectionFrs == true)
              ajouterLigne();
            else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Séelectionner un fournisseur"),
              ));
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              showAnimatedDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        backgroundColor: bgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: SizedBox(
                            width: 350,
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Image.asset("images/f1.jpg"),
                                  trailing: const Text("Ajoutez une Ligne"),
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                    leading: Image.asset("images/f8.jpg"),
                                    trailing: const Text("Confirmer")),
                              ],
                            )));
                  });
            },
            backgroundColor: bgColor,
            child: const Icon(
              Icons.navigation,
              color: Colors.white,
            )),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            child: Card(
              color: bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 10.0,
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 0.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.doctype,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              thickness: 3,
                            ),
                            SeqDoc(
                              label: 'Numero de Séquence',
                              content: numDoc = seqDocument(),
                              label2: 'Date',
                            ),
                            if (widget.id == 1 || widget.id == 2)
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Liste des fournisseurs",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: DropdownButton(
                                        hint:
                                            Text("Sélectionner un Fournisseur"),
                                        borderRadius: BorderRadius.circular(5),

                                        underline: SizedBox(),
                                        // Initial Value
                                        value: dropdownvalue,

                                        // Down Arrow Icon

                                        //icon: const Icon(Icons.keyboard_arrow_down),

                                        // Array list of items
                                        items: raisonSocialeFournisseur.values
                                            .toList()
                                            .map((String
                                                raisonSocialeFournisseur) {
                                          return DropdownMenuItem(
                                            value: raisonSocialeFournisseur,
                                            child:
                                                Text(raisonSocialeFournisseur),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownvalue = newValue!;
                                            idFournisseur =
                                                raisonSocialeFournisseur
                                                    .keys
                                                    .firstWhere((element) =>
                                                        raisonSocialeFournisseur[
                                                            element] ==
                                                        newValue);
                                            selectionFrs = true;
                                            refProduits.clear();
                                            widget.controllers.clear();
                                            fetchProduits();
                                            ligneDoc.clear();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 2, child: Container()),
                                ],
                              ),
                            const Divider(
                              thickness: 3,
                            ),
                            Center(
                              child: SizedBox(
                                height: 500,
                                child: DataTable2(
                                  showCheckboxColumn: true,
                                  dataRowHeight: 50,
                                  columnSpacing: 30,
                                  columns: const [
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
                            ),

                            //Membership Widget from the widgets folder

                            SizedBox(
                              width: 1260,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  MaterialButton(
                                    height: 53,
                                    color: const Color.fromARGB(255, 253, 0, 0),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Annuler",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  MaterialButton(
                                    height: 53,
                                    color: const Color.fromARGB(
                                        255, 112, 112, 112),
                                    onPressed: () {
                                      if (selectionFrs == true)
                                        ajouterLigne();
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Sélectionner un fournisseur"),
                                        ));
                                      }
                                    },
                                    child: const Text(
                                      "Ajouter une ligne",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  MaterialButton(
                                    height: 53,
                                    color:
                                        const Color.fromARGB(255, 75, 100, 211),
                                    onPressed: () async {
                                      if (confirmButton == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarButtonError);
                                      }
                                      print(idDoc);
                                      if (confirmButton) {
                                        dateDoc =
                                            date.toString().substring(0, 10);

                                        await {
                                          ajoutDocument(
                                              widget.id,
                                              numSeqDocument,
                                              dateDoc,
                                              double.parse(totalDocument.text)),
                                          updateSeqDocument()
                                        };

                                        for (var i = 4;
                                            i < widget.controllers.length;
                                            i = i + 5) {
                                          if (widget.controllers[i - 4].text
                                                  .isNotEmpty ||
                                              widget.controllers[i - 3].text
                                                  .isNotEmpty ||
                                              widget.controllers[i - 2].text
                                                  .isNotEmpty ||
                                              widget.controllers[i - 1].text
                                                  .isNotEmpty) {
                                            ajoutLigneDocument(
                                                idDoc,
                                                widget.controllers[i - 4].text,
                                                widget.controllers[i - 3].text,
                                                double.parse(widget
                                                    .controllers[i - 2].text),
                                                double.parse(widget
                                                    .controllers[i - 1].text),
                                                double.parse(widget
                                                    .controllers[i].text));
                                            if (widget.id == 2) {
                                              modificationStock(
                                                  widget
                                                      .controllers[i - 4].text,
                                                  double.parse(widget
                                                      .controllers[i - 2]
                                                      .text));
                                            } else if (widget.id == 6) {
                                              double stockToModify =
                                                  (double.parse(widget
                                                          .controllers[i - 2]
                                                          .text) *
                                                      -1);
                                              modificationStock(
                                                  widget
                                                      .controllers[i - 4].text,
                                                  stockToModify);
                                            }
                                          }
                                        }
                                        setState(() {
                                          confirmButton = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBarSucces);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MainScreen(
                                                  DashboardScreen())),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "Confirmer",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 300,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: const Text(
                                      "Montant Total :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
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
                                          hintText: totalDoc,
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey.shade400,
                                          ),
                                          prefixIcon: Icon(
                                              Icons.attach_money_outlined,
                                              color: Colors.grey.shade400),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade200),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  15, 0, 15, 0),
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
