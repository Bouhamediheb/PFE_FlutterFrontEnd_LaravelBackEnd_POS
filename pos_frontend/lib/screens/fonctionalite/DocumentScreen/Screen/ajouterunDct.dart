import 'package:admin/constants.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/disabled_date.dart';
//import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/input_doc_produit_ref_nom.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/seqDocNumero.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../../FournisseurScreen/Widgets/input_tick_check.dart';
import '../Widget/input_doctype.dart';
import '../Widget/input_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ajouterUnDocument extends StatefulWidget {
  final int id;
  final String doctype;

  List<TextEditingController> controllers = [];

  ajouterUnDocument(this.id, this.doctype);
  @override
  State<ajouterUnDocument> createState() => _ajouterUnDocumentState();
}

class _ajouterUnDocumentState extends State<ajouterUnDocument> {
  double total = 0;
  String totalDoc = "0";
  final DateTime date = new DateTime.now();
  String numSeqDocument;
  int idDoc;
  List documents = [];
  String dateDoc;
  String numDoc;

  TextEditingController totalDocument = TextEditingController(text: '0');

  Future<http.Response> ajoutDocument(
      int type, String numeroDoc, String dateDoc, double totalDoc) async {
    List documents = [];
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

  @override
  void initState() {
    super.initState();
    this.fetchDocuments();
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
        idDoc = documents[documents.length - 1]['id'] + 1;
      });
    } else {
      throw Exception('Error!');
    }
  }

  Future<dynamic> future;

  List<Widget> _cardList = [];

  void CalculTotal() {
    print("function mchet");
    total = total + double.tryParse(widget.controllers.last.text);
    print("hedha total : " + total.toString());
    print("hedhe totalDoc" + totalDocument.toString());
    setState(() {
      totalDocument.text = total.toString();
    });
  }

  String seqDocument() {
    print(idDoc);
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
          Prix: TestFonction,
          fieldController: refController,
          fieldController2: nomController,
          fieldController3: qteController,
          fieldController4: prixController));
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2A2D3E),
      body: Padding(
        padding:
            EdgeInsets.only(top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
        child: Form(
          key: _formKey,
          child: Card(
            shadowColor: Color.fromARGB(255, 255, 255, 255),
            color: Color(0xFF2A2D3E),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            elevation: 10.0,
            child: Container(
              width: 1300,
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
                                                return _cardList[index];
                                              }),
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
                                  onPressed: () {
                                    numDoc = seqDocument();
                                    print(numDoc);
                                    print(widget.id);
                                    dateDoc = date.toString().substring(0, 10);
                                    print(dateDoc);
                                    future = ajoutDocument(
                                        widget.id,
                                        numSeqDocument,
                                        dateDoc,
                                        double.parse(totalDocument.text));
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
                                        focusedErrorBorder: OutlineInputBorder(
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
    );
  }
}

class InputRefNomProduit extends StatefulWidget {
  double total = 0;
  String totalDoc = "Hello";
  TextEditingController totalDocument;

  final String label, label2, label3, label4;
  final String content, content2, content3, content4;
  var fieldController = TextEditingController();
  var fieldController2 = TextEditingController();
  var fieldController3 = TextEditingController();
  var fieldController4 = TextEditingController();
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
    this.fieldController,
    this.fieldController2,
    this.fieldValidator,
    this.fieldController3,
    this.fieldController4,
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
                          widget.fieldController2.text = nomProduit.toString();
                        }
                      }
                    });
                  },
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
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) {
                      widget.total = 0;

                      print(
                          "total awel fonction  = " + widget.total.toString());

                      //print((widget.controllers[3].text));
                      for (var i = 3;
                          i <= widget.controllers.length;
                          i = i + 4) {
                        print("valeur eli f index " +
                            i.toString() +
                            " = " +
                            widget.controllers[i].text);
                        widget.total = widget.total +
                            (double.tryParse(widget.controllers[i].text) *
                                (double.tryParse(
                                    widget.controllers[i - 1].text)));
                        print("Total" + widget.total.toString());
                        print(widget.totalDoc);

                        setState(() {
                          print("Salem si bezi :" + widget.totalDoc);
                          widget.totalDoc = widget.total.toString();
                          print("hedha totalDoc" + widget.totalDoc);
                          print("----------------");
                          print("Salem si zebi :" +
                              widget.totalDocument.toString());
                          widget.totalDocument.text = widget.total.toString();
                          print("hedha totalDocument" +
                              widget.totalDocument.text);
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

                      print(
                          "total awel fonction  = " + widget.total.toString());

                      //print((widget.controllers[3].text));
                      for (var i = 3;
                          i <= widget.controllers.length;
                          i = i + 4) {
                        print("valeur eli f index " +
                            i.toString() +
                            " = " +
                            widget.controllers[i].text);
                        widget.total = widget.total +
                            (double.tryParse(widget.controllers[i].text) *
                                (double.tryParse(
                                    widget.controllers[i - 1].text)));
                        print("Total" + widget.total.toString());
                        print(widget.totalDoc);

                        setState(() {
                          print("Salem si bezi :" + widget.totalDoc);
                          widget.totalDoc = widget.total.toString();
                          print("hedha totalDoc" + widget.totalDoc);
                          print("----------------");
                          print("Salem si zebi :" +
                              widget.totalDocument.toString());
                          widget.totalDocument.text = widget.total.toString();
                          print("hedha totalDocument" +
                              widget.totalDocument.text);
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
          ],
        );
      },
    );
  }
}
