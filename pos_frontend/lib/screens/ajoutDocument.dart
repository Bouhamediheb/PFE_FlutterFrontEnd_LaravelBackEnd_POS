import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:async';

class ajoutDocument extends StatefulWidget {
  const ajoutDocument({Key key}) : super(key: key);

  @override
  State<ajoutDocument> createState() => _ajoutDocumentState();
}

String dropdownvalue = "Bon de Commande";
String dropdownvalue2 = "Fournisseur 1";

class _ajoutDocumentState extends State<ajoutDocument> {
  String DateNow = new DateTime.now().toString().substring(0, 19);
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1950, 1),
      lastDate: DateTime(2030, 12),
      helpText: "",
      cancelText: "Annuler",
      confirmText: "Confirmer",
      builder: (BuildContext context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  final _formKey = GlobalKey<FormState>();
  int typeDocument;
  final numeroDocument = TextEditingController();
  final dateDocument = TextEditingController();
  final totalDocument = TextEditingController();

  List document = [];

  Future<http.Response> ajoutDocument(int typeDocument, String numeroDocument,
      String dateDocument, String totalDocument) async {
    List documents = [];
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/document/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'type': typeDocument,
        'numDoc': numeroDocument,
        'dateDoc': dateDocument,
        'totalDoc': totalDocument,
      }),
    );
    if (response.statusCode == 200) {
      return documents = jsonDecode(response.body);
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  Future<dynamic> future;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Informations Documents',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              margin: EdgeInsets.all(50),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Type",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 200),
                            child: Text(
                              "Tier",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: DropdownButton<String>(
                              onChanged: (newvalue) => setState(() {
                                dropdownvalue = newvalue;
                                if (newvalue == 'DEVIS') {
                                  typeDocument = 1;
                                } else if (newvalue == 'Bon de Commande') {
                                  typeDocument = 2;
                                } else if (newvalue == 'Bon de Livraison') {
                                  typeDocument = 3;
                                } else if (newvalue == 'Ticket') {
                                  typeDocument = 4;
                                }
                              }),
                              items: <String>[
                                'DEVIS',
                                'Bon de Commande',
                                'Bon de Livraison',
                                'Ticket',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      )),
                                );
                              }).toList(),
                              focusColor: Colors.white,
                              value: dropdownvalue,
                              alignment: Alignment.center,
                              underline: SizedBox(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: DropdownButton<String>(
                              onChanged: (newvalue) => setState(() {
                                dropdownvalue2 = newvalue;
                              }),
                              items: <String>[
                                'Fournisseur 1',
                                'Fournisseur 2',
                                'Fournisseur 3',
                                'Fournisseur 4',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      )),
                                );
                              }).toList(),
                              focusColor: Colors.white,
                              value: dropdownvalue2,
                              alignment: Alignment.center,
                              underline: SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Numéro",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: numeroDocument,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Numéro de Document',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400,
                          ),
                          prefixIcon: Icon(Icons.confirmation_num,
                              color: Colors.grey.shade400),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey.shade200),
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
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        ),
                        style: TextStyle(
                            fontFamily: 'Montserrat', color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Date",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: TextFormField(
                              controller: dateDocument,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText:
                                    '${currentDate.toString().substring(0, 19)}',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                    fontSize: 14),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            child: Text(
                              "Sélectionner une Date",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Montserrat',
                                color: Colors.grey.shade600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Color(0xFFFFFFFE),
                                minimumSize: Size(200, 60),
                                side: BorderSide(color: Colors.grey.shade400),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Montant Total :",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: TextFormField(
                              controller: totalDocument,
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
                                prefixIcon: Icon(Icons.attach_money_outlined,
                                    color: Colors.grey.shade400),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey.shade200),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (() {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                future = ajoutDocument(
                                  typeDocument,
                                  numeroDocument.text,
                                  currentDate.toString().substring(0, 19),
                                  totalDocument.text,
                                );
                              });
                            }
                          }),
                          child: Text(
                            "Confirmer",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Color.fromARGB(255, 41, 17, 173),
                              minimumSize: Size(150, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
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
    ));
  }
}
