import 'package:admin/constants.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/disabled_date.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/input_doc_produit_ref_nom.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Widget/seqDocNumero.dart';
import 'package:flutter/material.dart';
import '../../FournisseurScreen/Widgets/input_tick_check.dart';
import '../Widget/input_doc_produit_quantite_prix.dart';
import '../Widget/input_doctype.dart';
import '../Widget/input_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ajouterUnDocument extends StatefulWidget {
  final int id;
  final String doctype;

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  ajouterUnDocument(this.id, this.doctype);
  @override
  State<ajouterUnDocument> createState() => _ajouterUnDocumentState();
}

class _ajouterUnDocumentState extends State<ajouterUnDocument> {
  Future<http.Response> ajoutDocument(int type, String numeroDoc,
      String dateDoc, double totalDoc, bool toucheStock) async {
    List documents = [];

    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/document"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );
    if (response.statusCode == 200) {
      return documents = jsonDecode(response.body);
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  Future<dynamic> future;

  List<Widget> _cardList = [
    (InputRefNomProduit(
      label: 'Référence',
      content: 'Taper la référence',
      label2: 'Nom du produit',
      content2: '',
      label3: 'Quantité',
      content3: 'Taper la quantité',
      label4: 'Prix',
      content4: 'Taper le prix unitaire',
    )),
  ];

  void _addCardWidgetExp() {
    setState(() {
      widget.controllers.add(TextEditingController());
      widget.controllers.add(TextEditingController());
      widget.controllers.add(TextEditingController());
      widget.controllers.add(TextEditingController());

      _cardList.add(SizedBox(height: 10));
      Divider(
        thickness: 2,
        color: Colors.white,
      );
      _cardList.add(InputRefNomProduit(
        label: 'Référence',
        content: 'Taper la référence',
        label2: 'Nom du produit',
        content2: '',
        label3: 'Quantité',
        content3: 'Taper la quantité',
        label4: 'Prix',
        content4: 'Taper le prix unitaire',
        fieldController: widget.controllers.first,
        fieldController2: widget.controllers[1],
        fieldController3: widget.controllers[2],
        fieldController4: widget.controllers.last,
      ));
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
                            content: '----------',
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
                                    print("Valeurs:");
                                    for (int i = 0;
                                        i < widget.controllers.length;
                                        i++) {
                                      print(widget.controllers[i].text);
                                    }
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
                                      //controller: totalDocument,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Total',
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

/*
 SizedBox(
                                        height: 530,
                                        width: 1200,
                                        child: ListView.builder(
                                            itemCount: _cardList.length,
                                            itemBuilder: (context, index) {
                                              return _cardList[index];
                                            }),
                                      ),

*/
