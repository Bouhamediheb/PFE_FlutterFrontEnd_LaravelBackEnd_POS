import 'package:admin/constants.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/seqDocNumero.dart';
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

  ajouterUnDocument(this.id, this.doctype);
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

  double total = 0;
  String totalDoc = "0";
  final DateTime date = new DateTime.now();
  String? numSeqDocument;
  int? idDoc;
  List? documents = [];
  String? dateDoc;
  String? numDoc;
  bool confirmButton = true;
  int idligne = -1;

  TextEditingController totalDocument = TextEditingController(text: '0');

  Future<http.Response?> ajoutDocument(
      int type, String? numeroDoc, String? dateDoc, double totalDoc) async {
    List? documents = [];
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
    this.fetchDocuments();
    this.fetchProduits();
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

  List<Widget> _cardList = [];

  void CalculTotal() {
    print("function mchet");
    total = total + double.tryParse(widget.controllers.last.text)!;
    print("hedha total : " + total.toString());
    print("hedhe totalDoc" + totalDocument.toString());
    setState(() {
      totalDocument.text = total.toString();
    });
  }

  String seqDocument() {
    print(idDoc);
    if (idDoc == null) idDoc = 1;
    return numSeqDocument =
        date.toString().substring(0, 10) + '/DOC' + idDoc.toString();
  }

  void TestFonction() {
    print("Hello");
  }

  void _addCardWidgetExp() {
    setState(() {
      TextEditingController refController = new TextEditingController();
      widget.controllers.add(refController);
      TextEditingController nomController = new TextEditingController();
      widget.controllers.add(nomController);
      TextEditingController qteController = new TextEditingController();
      widget.controllers.add(qteController);
      TextEditingController prixController = new TextEditingController();
      widget.controllers.add(prixController);

      _cardList.add(SizedBox(height: 10));
      Divider(
        thickness: 2,
        color: Colors.white,
      );

      _cardList.add(InputRefNomProduit(
          totalDoc: totalDoc,
          totalDocument: totalDocument,
          total: total,
          controllers: widget.controllers,
          label: 'Référence',
          content: 'Taper la référence',
          label2: 'Nom du produit',
          content2: '',
          label3: 'Quantité',
          content3: 'Taper la quantité',
          label4: 'Prix',
          content4: 'Taper le prix unitaire',
          content5: 'Prix Total',
          Prix: TestFonction,
          fieldController: refController,
          fieldController2: nomController,
          fieldController3: qteController,
          fieldController4: prixController));
    });
  }

  List<DataRow> ligneDoc = [];
  LocalKey? key;

  void ajouterLigne() {
    idligne++;
    var id = idligne;

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
        backgroundColor: Color(0xFF2A2D3E),
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
                        content: Container(
                            width: 350,
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: Image.asset("images/f1.jpg"),
                                  trailing: Text("Ajoutez une Ligne"),
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                                ListTile(
                                    leading: Image.asset("images/f8.jpg"),
                                    trailing: Text("Confirmer")),
                              ],
                            )));
                  });
            },
            backgroundColor: primaryColor,
            child: Icon(
              Icons.navigation,
              color: Colors.white,
            )),
        body: Padding(
          padding: EdgeInsets.only(
              top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
          child: Form(
            key: _formKey,
            child: Card(
              shadowColor: Color.fromARGB(255, 255, 255, 255),
              color: Color(0xFF2A2D3E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 10.0,
              child: Container(
                width: 1500,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 0.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.doctype,
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            SeqDoc(
                              label: 'Numero de Séquence',
                              content: numDoc = seqDocument(),
                              label2: 'Date',
                            ),
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
                                  DataColumn2(
                                    size: ColumnSize.S,
                                    label: Text(""),
                                  )
                                ],
                                rows: ligneDoc,
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
                                        numDoc = seqDocument();
                                        print(numDoc);
                                        print(widget.id);
                                        dateDoc =
                                            date.toString().substring(0, 10);
                                        print(dateDoc);
                                        if (true)
                                          await {
                                            future = ajoutDocument(
                                                widget.id,
                                                numSeqDocument,
                                                dateDoc,
                                                double.parse(
                                                    totalDocument.text))
                                          };
                                        for (var i = 3;
                                            i < widget.controllers.length;
                                            i = i + 4) {
                                          future = ajoutLigneDocument(
                                              idDoc,
                                              widget.controllers[i - 3].text,
                                              widget.controllers[i - 2].text,
                                              double.parse(widget
                                                  .controllers[i - 1].text),
                                              double.parse(
                                                  widget.controllers[i].text));
                                          future = modificationStock(
                                              widget.controllers[i - 3].text,
                                              double.parse(widget
                                                      .controllers[i - 1]
                                                      .text) *
                                                  -1);
                                        }
                                      }
                                      ;
                                      Navigator.of(context).pop();
                                      setState(() {
                                        confirmButton = false;
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen(DashboardScreen())),
                                      );
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

class InputRefNomProduit extends StatefulWidget {
  double total = 0;
  String? totalDoc = "Hello";
  TextEditingController totalDocument;

  final String? label, label2, label3, label4;
  final String? content, content2, content3, content4, content5;
  TextEditingController? fieldController = TextEditingController();
  TextEditingController? fieldController2 = TextEditingController();
  TextEditingController? fieldController3 = TextEditingController();
  TextEditingController? fieldController4 = TextEditingController();
  TextEditingController? fieldController5 = TextEditingController();
  List<TextEditingController> controllers = [];
  VoidCallback? Prix;
  FormFieldValidator<String>? fieldValidator = (_) {};
  InputRefNomProduit({
    required this.total,
    required this.controllers,
    this.label,
    this.content,
    this.label2,
    this.content2,
    this.label3,
    this.content3,
    this.label4,
    this.content4,
    this.fieldController,
    this.fieldController2,
    this.fieldValidator,
    this.fieldController3,
    this.fieldController4,
    this.fieldController5,
    this.content5,
    this.Prix,
    this.totalDoc,
    required this.totalDocument,
  });

  @override
  State<InputRefNomProduit> createState() => _InputRefNomProduitState();
}

class _InputRefNomProduitState extends State<InputRefNomProduit> {
  bool hasFocus = false;
  String? nomProduit;
  String? selectedProduit;
  int? produitId;
  List? produits = [];
  List<SearchFieldListItem<dynamic>> refProduits = [];
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
    for (var i = 0; i < produits!.length; i++) {
      setState(() {
        refProduits.add(produits![i]['refProd']);
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
                    searchStyle: TextStyle(color: Colors.black),
                    controller: widget.fieldController,
                    validator: widget.fieldValidator,
                    searchInputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 190, 190, 190),
                          fontSize: 14),
                    ),
                    suggestionItemDecoration: BoxDecoration(
                        color: Color(0xFF2A2D3E),
                        border: Border.all(color: Colors.white, width: 1.0)),
                    suggestions: refProduits.toList(),
                    maxSuggestionsInViewPort: 6,
                    suggestionsDecoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    suggestionState: Suggestion.expand,
                    textInputAction: TextInputAction.next,
                    onSubmit: (value) {
                      setState(() {
                        selectedProduit = value;
                        for (var i = 0; i < produits!.length; i++) {
                          if (selectedProduit == produits![i]['refProd']) {
                            nomProduit = produits![i]['nomProd'];
                            widget.fieldController4!.text =
                                produits![i]['prixVente'].toString();
                            widget.fieldController2!.text =
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
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      widget.total = 0;
                      for (var i = 3;
                          i <= widget.controllers.length;
                          i = i + 4) {
                        widget.total = widget.total +
                            (double.tryParse(widget.controllers[i].text)! *
                                double.tryParse(
                                    widget.controllers[i - 1].text)!);
                        setState(() {
                          widget.totalDoc = widget.total.toString();
                          widget.totalDocument.text = widget.total.toString();
                          widget.fieldController5!.text =
                              (double.parse(widget.controllers[i - 1].text) *
                                      double.parse(widget.controllers[i].text))
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
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      widget.fieldController5!.text =
                          (double.parse(widget.fieldController4!.text) *
                                  double.parse(widget.fieldController3!.text))
                              .toString();
                      widget.total = 0;
                      for (var i = 3;
                          i <= widget.controllers.length;
                          i = i + 4) {
                        widget.total = widget.total +
                            (double.tryParse(widget.controllers[i].text)! *
                                double.tryParse(
                                    widget.controllers[i - 1].text)!);
                        setState(() {
                          widget.totalDoc = widget.total.toString();
                          widget.totalDocument.text = widget.total.toString();
                          print(widget.fieldController5!.text);
                        });
                      }
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
                      hintText: "${widget.content4}",
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
          ],
        );
      },
    );
  }
}
