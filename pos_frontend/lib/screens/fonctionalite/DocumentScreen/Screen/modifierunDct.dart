import 'package:admin/constants.dart';
import 'package:admin/models/Raccourcis.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/disabled_date.dart';
//import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/input_doc_produit_ref_nom.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/seqDocNumero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../../main/main_screen.dart';
import '../../FournisseurScreen/Widgets/input_tick_check.dart';
import '../Widget/input_doctype.dart';
import '../Widget/input_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class modifierUnDocument extends StatefulWidget {
  List<TextEditingController> controllers = [];
  List<TextEditingController> controllers2 = [];
  int documentId;
  int ligneDocumentId;
  modifierUnDocument(this.ligneDocumentId, this.documentId);

  @override
  State<modifierUnDocument> createState() => _modifierUnDocumentState();
}

class _modifierUnDocumentState extends State<modifierUnDocument> {
  double total = 0;
  String totalDoc = "0";
  bool confirmButton = true;
  TextEditingController totalDocument = TextEditingController(text: '0');
  List documents = [];
  List ligneDocuments = [];
  List stockInitial = [];
  @override
  void initState() {
    super.initState();
    this.fetchDocuments();
    this.fetchLigneDocuments();
  }

  fetchDocuments() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/document'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      documents = jsonDecode(response.body);
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
    for (var i = 0; i < ligneDocuments.length; i++) {
      if (ligneDocuments[i]['id_doc'] == widget.ligneDocumentId) {
        setState(() {
          TextEditingController idController = new TextEditingController();
          widget.controllers.add(idController);
          idController.text = ligneDocuments[i]['id'].toString();
          TextEditingController refController = new TextEditingController();
          widget.controllers.add(refController);
          refController.text = ligneDocuments[i]['refProd'].toString();
          TextEditingController nomController = new TextEditingController();
          widget.controllers.add(nomController);
          nomController.text = ligneDocuments[i]['nomProd'].toString();
          TextEditingController qteController = new TextEditingController();
          widget.controllers.add(qteController);
          qteController.text = ligneDocuments[i]['qteProd'].toString();
          TextEditingController prixController = new TextEditingController();
          widget.controllers.add(prixController);
          prixController.text = ligneDocuments[i]['prixProd'].toString();
          TextEditingController totalProdController =
              new TextEditingController();
          totalProdController.text = (double.parse(prixController.text) *
                  double.parse(qteController.text))
              .toString();

          _cardList.add(InputRefNomProduit(
            totalDoc: totalDoc,
            totalDocument: totalDocument,
            total: total,
            controllers: widget.controllers,
            label: 'Référence',
            label2: 'Nom du produit',
            label3: 'Quantité',
            label4: 'Prix',
            label5: 'Total par Produit',
            fieldController: refController,
            fieldController2: nomController,
            fieldController3: qteController,
            fieldController4: prixController,
            fieldController5: totalProdController,
          ));
        });
      }
    }

    for (var i = 0; i < documents.length; i++)
      if (documents[i]['id'] == widget.ligneDocumentId) {
        totalDocument.text = documents[i]['totalDoc'].toString();
      }
  }

  Future<http.Response> modifierDocument(int id, double totalDoc) async {
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

  Future<http.Response> modifierLigneDocument(int id, int idDoc, String refProd,
      String nomProd, double qteProd, double prixProd) async {
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

  Future<http.Response> modificationStock(String refProd, double stock) async {
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

  Future<http.Response> ajoutLigneDocument(int idDoc, String refProd,
      String nomProd, double qteProd, double prixProd) async {
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

  void _addCardWidgetExp() {
    setState(() {
      TextEditingController refController2 = new TextEditingController();
      widget.controllers2.add(refController2);
      TextEditingController nomController2 = new TextEditingController();
      widget.controllers2.add(nomController2);
      TextEditingController qteController2 = new TextEditingController();
      widget.controllers2.add(qteController2);
      TextEditingController prixController2 = new TextEditingController();
      widget.controllers2.add(prixController2);
      TextEditingController totalProdController2 = new TextEditingController();
      Divider(
        thickness: 2,
        color: Colors.white,
      );

      _cardList.add(InputRefNomProduit(
        totalDoc: totalDoc,
        totalDocument: totalDocument,
        total: total,
        controllers: widget.controllers2,
        label: 'Référence',
        content: 'Taper la référence',
        label2: 'Nom du produit',
        content2: '',
        label3: 'Quantité',
        content3: 'Taper la quantité',
        label4: 'Prix',
        content4: 'Taper le prix unitaire',
        label5: 'Total Par Produit',
        content5: 'Total TTC',
        fieldController: refController2,
        fieldController2: nomController2,
        fieldController3: qteController2,
        fieldController4: prixController2,
        fieldController5: totalProdController2,
      ));
    });
  }

  Future<dynamic> future;

  List<Widget> _cardList = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.controlLeft) &&
            event.isKeyPressed(LogicalKeyboardKey.f1)) {
          _addCardWidgetExp();
        }
      },
      child: Form(
        key: _formKey,
        child: Card(
          elevation: 0,
          shadowColor: Color.fromARGB(255, 255, 255, 255),
          color: Color(0xFF2A2D3E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          child: Container(
            width: 2000,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 20.0, bottom: 0.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Container(
                            child: Row(
                              //mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 450,
                                        width: 1200,
                                        child: ListView.builder(
                                          itemCount: _cardList.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              trailing: Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: _cardList[index],
                                                ),
                                              ),
                                              leading: Expanded(
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.close_sharp,
                                                      size: 28),
                                                  color: Colors.red,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                color: Color.fromARGB(255, 253, 0, 0),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Annuler",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              MaterialButton(
                                height: 53,
                                color: Color.fromARGB(255, 112, 112, 112),
                                onPressed: () {
                                  _addCardWidgetExp();
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
                                          int.parse(
                                              widget.controllers[i - 4].text),
                                          widget.documentId,
                                          widget.controllers[i - 3].text,
                                          widget.controllers[i - 2].text,
                                          double.parse(
                                              widget.controllers[i - 1].text),
                                          double.parse(
                                              widget.controllers[i].text));
                                      future = modificationStock(
                                          widget.controllers[i - 3].text,
                                          double.parse(widget
                                                  .controllers[i - 1].text) -
                                              stockInitial[j]);
                                      j++;
                                    }
                                    for (var i = 0; i < documents.length; i++) {
                                      if (documents[i]['id'] ==
                                          widget.ligneDocumentId) {
                                        modifierDocument(documents[i]['id'],
                                            double.parse(totalDocument.text));
                                      }
                                    }
                                    for (var i = 3;
                                        i < widget.controllers2.length;
                                        i = i + 4) {
                                      future = ajoutLigneDocument(
                                          widget.documentId,
                                          widget.controllers2[i - 3].text,
                                          widget.controllers2[i - 2].text,
                                          double.parse(
                                              widget.controllers2[i - 1].text),
                                          double.parse(
                                              widget.controllers2[i].text));
                                      future = modificationStock(
                                          widget.controllers2[i - 3].text,
                                          double.parse(
                                              widget.controllers2[i - 1].text));
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainScreen(DashboardScreen())),
                                    );
                                  }
                                  ;
                                  setState(() {
                                    confirmButton = false;
                                  });
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
                                    color: Color.fromARGB(255, 255, 255, 255),
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
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade200),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
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
    );
  }
}

class InputRefNomProduit extends StatefulWidget {
  double total = 0;
  String totalDoc = "Hello";
  TextEditingController totalDocument;
  double totalPrixUnitaire = 0;
  final String label, label2, label3, label4, label5;
  final String content, content2, content3, content4, content5;
  var fieldController = TextEditingController();
  var fieldController2 = TextEditingController();
  var fieldController3 = TextEditingController();
  var fieldController4 = TextEditingController();
  var fieldController5 = TextEditingController();
  List<TextEditingController> controllers = [];
  VoidCallback Prix;
  FormFieldValidator<String> fieldValidator = (_) {};
  InputRefNomProduit({
    @required this.total,
    @required this.controllers,
    this.label,
    this.content,
    this.label2,
    this.content2,
    this.label3,
    this.content3,
    this.label4,
    this.content4,
    this.content5,
    this.label5,
    this.fieldController,
    this.fieldController2,
    this.fieldValidator,
    this.fieldController3,
    this.fieldController4,
    this.fieldController5,
    this.Prix,
    this.totalDoc,
    @required this.totalDocument,
  });

  @override
  State<InputRefNomProduit> createState() => _InputRefNomProduitState();
}

class _InputRefNomProduitState extends State<InputRefNomProduit> {
  bool hasFocus = false;
  String nomProduit;
  String selectedProduit;
  int produitId;
  List produits = [];
  List<String> refProduits = [];
  @override
  void initState() {
    super.initState();
    this.fetchProduits();
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
    for (var i = 0; i < produits.length; i++) {
      setState(() {
        refProduits.add(produits[i]['refProd']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  "${widget.label}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Focus(
                  autofocus: true,
                  child: SearchField(
                    hint: "${widget.content}",
                    searchStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    controller: widget.fieldController,
                    validator: widget.fieldValidator,
                    searchInputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    suggestions: refProduits,
                    suggestionStyle:
                        TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    maxSuggestionsInViewPort: 6,
                    suggestionsDecoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    onTap: (value) {
                      setState(() {
                        selectedProduit = value as String;
                        for (var i = 0; i < produits.length; i++) {
                          if (selectedProduit == produits[i]['refProd']) {
                            nomProduit = produits[i]['nomProd'];
                            widget.fieldController2.text =
                                nomProduit.toString();
                          }
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: 50.0,
                child: Text(
                  "${widget.label2}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: TextFormField(
                  enabled: false,
                  controller: widget.fieldController2,
                  validator: widget.fieldValidator,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "${widget.content2}",
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 190, 190, 190),
                        fontSize: 14),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: 50.0,
                child: Text(
                  "${widget.label3}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      widget.total = 0;
                      for (var i = 4;
                          i <= widget.controllers.length;
                          i = i + 5) {
                        widget.total = widget.total +
                            (double.tryParse(widget.controllers[i].text) *
                                (double.tryParse(
                                    widget.controllers[i - 1].text)));
                        setState(() {
                          widget.totalDoc = widget.total.toString();
                          widget.totalDocument.text = widget.total.toString();
                          widget.fieldController5.text = (double.parse(
                                      widget.fieldController3.text) *
                                  double.parse(widget.fieldController4.text))
                              .toString();
                        });
                      }
                    }
                  },
                  child: TextFormField(
                    controller: widget.fieldController3,
                    validator: widget.fieldValidator,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: "${widget.content3}",
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 190, 190, 190),
                          fontSize: 14),
                      fillColor: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  "${widget.label4}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      widget.total = 0;
                      for (var i = 4;
                          i <= widget.controllers.length;
                          i = i + 5) {
                        widget.total = widget.total +
                            (double.tryParse(widget.controllers[i].text) *
                                (double.tryParse(
                                    widget.controllers[i - 1].text)));
                        setState(() {
                          widget.totalDoc = widget.total.toString();
                          widget.totalDocument.text = widget.total.toString();
                          widget.fieldController5.text = (double.parse(
                                      widget.controllers[i].text) *
                                  double.parse(widget.controllers[i - 1].text))
                              .toString();
                        });
                      }
                    }
                  },
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        widget.fieldController5.text =
                            (double.parse(widget.fieldController4.text) *
                                    double.parse(widget.fieldController3.text))
                                .toString();
                      }
                    },
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      enabled: true,
                      controller: widget.fieldController4,
                      validator: widget.fieldValidator,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        // hintText: widget.totalDocument.text,
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 190, 190, 190),
                            fontSize: 14),
                        fillColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: 50.0,
                child: Text(
                  "${widget.label5}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: TextFormField(
                  enabled: false,
                  controller: widget.fieldController5,
                  validator: widget.fieldValidator,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "${widget.content5}",
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 190, 190, 190),
                        fontSize: 14),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        );
      },
    );
  }
}
