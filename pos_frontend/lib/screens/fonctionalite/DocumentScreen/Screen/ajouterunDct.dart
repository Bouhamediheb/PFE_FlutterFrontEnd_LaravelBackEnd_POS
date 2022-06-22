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

class ajouterUnDocument extends StatefulWidget {
  final int id;
  final String doctype;

  List<TextEditingController> controllers = [];

  ajouterUnDocument(this.id, this.doctype, {Key? key}) : super(key: key);
  @override
  State<ajouterUnDocument> createState() => _ajouterUnDocumentState();
}

class _ajouterUnDocumentState extends State<ajouterUnDocument>
    with SingleTickerProviderStateMixin {
  List<dynamic> refProduits = [];
  List? produits = [];
  String? selectedProduit;
  String? nomProduit;

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
        refProduits.add(produits![i]['refProd']);
      });
    }
  }

  double total = 0;
  String totalDoc = "0";
  final DateTime date = DateTime.now();
  String? numSeqDocument;
  int? idDoc;
  List? documents = [];
  String? dateDoc;
  String? numDoc;
  bool confirmButton = false;
  int idligne = -1;
  /*
static const snackBarSucces = SnackBar(
    content: Text('Tâche effectuée avec succès'),
  );

static const snackBarStockError = SnackBar(
    content: Text('Certains articles ont un stock insuffisant'),
  );
*/
  TextEditingController totalDocument = TextEditingController(text: '0');
  num Stokkkkk = 0;
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
      return documents = jsonDecode(response.body);
    } else {
      throw Exception('Erreur base de données!');
    }
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

  getStock(String refProd) async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/produit/$refProd"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        Stokkkkk = jsonDecode(response.body);
      });
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

  @override
  void initState() {
    super.initState();
    fetchDocuments();
    fetchProduits();
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
      });
    } else {
      throw Exception('Error!');
    }
  }

  Future<dynamic>? future;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String seqDocument() {
    print(idDoc);
    idDoc ??= 1;
    return numSeqDocument = '${date.toString().substring(0, 10)}/DOC$idDoc';
  }

  List<DataRow> ligneDoc = [];
  LocalKey? key;

  void ajouterLigne() {
    idligne++;
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
    ligneDoc.add(
      DataRow(
        key: key,
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
                  return "A7ala";
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
                    double total = 0;
                    for (var i = 3; i <= widget.controllers.length; i = i + 4) {
                      total = total +
                          (double.parse(widget.controllers[i].text) *
                              double.parse(widget.controllers[i - 1].text));
                      totalDocument.text = total.toString();
                    }
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
                      print("Quantité y weldi");
                      return 'Quantité obligatoire';
                    } else {
                      return "jawek behi";
                    }
                  },
                  decoration: const InputDecoration(
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
            SizedBox(
              width: 145,
              child: Focus(
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    double total = 0;
                    for (var i = 3; i <= widget.controllers.length; i = i + 4) {
                      total = total +
                          (double.parse(widget.controllers[i].text) *
                              double.parse(widget.controllers[i - 1].text));
                      totalDocument.text = total.toString();
                    }
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
                              typedoc: widget.id,
                              label: 'Numero de Séquence',
                              content: numDoc = seqDocument(),
                              label2: 'Date',
                              label3: 'Liste des fournisseurs',
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
                                      ajouterLigne();
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

                                      for (var j = 2;
                                          j < widget.controllers.length;
                                          j = j + 4) {
                                        getStock(
                                            widget.controllers[j - 2].text);
                                        if (widget
                                            .controllers[j].text.isNotEmpty) {
                                          if (double.parse(
                                                  widget.controllers[j].text) >
                                              Stokkkkk) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    snackBarStockError);
                                          }
                                        } else if (widget
                                            .controllers[j].text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBarStockError);
                                        } else {
                                          if (confirmButton) {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              numDoc = seqDocument();
                                              print(numDoc);
                                              print(widget.id);
                                              dateDoc = date
                                                  .toString()
                                                  .substring(0, 10);
                                              print(dateDoc);
                                              if (true) {
                                                {
                                                  future = ajoutDocument(
                                                      widget.id,
                                                      numSeqDocument,
                                                      dateDoc,
                                                      double.parse(
                                                          totalDocument.text));
                                                }
                                              }
                                              for (var i = 3;
                                                  i < widget.controllers.length;
                                                  i = i + 4) {
                                                future = ajoutLigneDocument(
                                                    idDoc,
                                                    widget.controllers[i - 3]
                                                        .text,
                                                    widget.controllers[i - 2]
                                                        .text,
                                                    double.parse(widget
                                                        .controllers[i - 1]
                                                        .text),
                                                    double.parse(widget
                                                        .controllers[i].text));
                                                future = modificationStock(
                                                    widget.controllers[i - 3]
                                                        .text,
                                                    double.parse(widget
                                                            .controllers[i - 1]
                                                            .text) *
                                                        -1);
                                              }
                                            }
                                            Navigator.of(context).pop();
                                            setState(() {
                                              confirmButton = false;
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBarSucces);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen(
                                                          DashboardScreen())),
                                            );
                                          }
                                        }
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
