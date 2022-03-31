import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:searchfield/searchfield.dart';

class InputRefNomProduit extends StatefulWidget {
  final String label, label2, label3, label4;
  final String content, content2, content3, content4;
  var fieldController = TextEditingController();
  var fieldController2 = TextEditingController();
  var fieldController3 = TextEditingController();
  var fieldController4 = TextEditingController();
  FormFieldValidator<String> fieldValidator = (_) {};
  InputRefNomProduit(
      {this.label,
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
      this.fieldController4});

  @override
  State<InputRefNomProduit> createState() => _InputRefNomProduitState();
}

class _InputRefNomProduitState extends State<InputRefNomProduit> {
  var fieldController = TextEditingController();
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
                  controller: fieldController,
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
                  controller: fieldController,
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
                child: TextFormField(
                  controller: fieldController,
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
                child: TextFormField(
                  enabled: true,
                  controller: fieldController,
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
          ],
        );
      },
    );
  }
}
