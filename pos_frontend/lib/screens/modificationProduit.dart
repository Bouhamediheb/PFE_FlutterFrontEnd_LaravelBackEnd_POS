import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class modificationProduit extends StatefulWidget {
  int produitId;
  modificationProduit(this.produitId);

  @override
  State<modificationProduit> createState() => _modificationProduitState();
}

class _modificationProduitState extends State<modificationProduit> {
  final _formKey = GlobalKey<FormState>();
  final refProduit = TextEditingController();
  final nomProduit = TextEditingController();
  final prixAchatProduit = TextEditingController();
  final prixVenteProduit = TextEditingController();
  final descriptionProduit = TextEditingController();
  //  final ficheTechnique ;
  // final qrProduit;

  List produit = [];

  Future<http.Response> modificationProduit(
    int id,
    String refProduit,
    String nomProduit,
    double prixAchatProduit,
    double prixVenteProduit,
    String descriptionProduit,
  ) async {
    List produits = [];
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/produit/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'refProd': refProduit,
        'nomProd': nomProduit,
        'prixAchat': prixAchatProduit,
        'prixVente': prixVenteProduit,
        'descriptionProd': descriptionProduit,
      }),
    );
    if (response.statusCode == 200) {
      return produits = jsonDecode(response.body);
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  Future<dynamic> future;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Informations Du Produit',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          thickness: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Référence Produit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: refProduit,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Référence du Produit',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Icon(Icons.confirmation_number_outlined,
                      color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Nom du Produit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: nomProduit,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Nom du Produit',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Icon(Icons.drive_file_rename_outline,
                      color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Prix Achat du Produit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: prixAchatProduit,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Prix Achat du Produit',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Icon(Icons.attach_money, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Prix Vente du Produit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: prixVenteProduit,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Prix Vente du Produit',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Icon(Icons.money_off, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Description du Produit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: descriptionProduit,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champs est obligatoire';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Description du Produit',
                  hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: Icon(Icons.text_snippet, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                ),
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: ElevatedButton(
                onPressed: (() {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    setState(() {
                      future = modificationProduit(
                        widget.produitId,
                        refProduit.text,
                        nomProduit.text,
                        double.parse(prixAchatProduit.text),
                        double.parse(prixVenteProduit.text),
                        descriptionProduit.text,
                      );
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ajout en cours')),
                    );
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
            ),
          ]),
        )
      ]),
    ));
  }
}
