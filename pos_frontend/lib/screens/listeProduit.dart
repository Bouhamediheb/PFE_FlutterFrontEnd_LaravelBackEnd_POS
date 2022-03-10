// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, dead_code, avoid_unnecessary_containers, unnecessary_new

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_frontend/screens/modificationProduit.dart';
import 'package:pos_frontend/screens/suppressionProduit.dart';
import 'dart:convert';
import '../screens/modificationDocument.dart';
import '../screens/suppressionDocument.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:pos_frontend/HomeScreen.dart';

class listeProduit extends StatefulWidget {
  @override
  _listeProduitState createState() => _listeProduitState();
}

class _listeProduitState extends State<listeProduit> {
  int produitId;

  List produits = [];
  @override
  void initState() {
    super.initState();
    this.fetchProduits();
  }

  fetchProduits() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/produit'));
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        produits = items;
        print(produits);
      });
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Center(
              child: Container(
            height: 20,
            child: Center(
              child: Text(
                'La Liste Des Produits :',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          )),
        ),
        SizedBox(
          height: 30,
        ),
        for (var i = 0; i < produits.length; i++)
          Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                title: Text("NOM: " +
                    produits[i]['nomProd'] +
                    " REF: " +
                    produits[i]['refProd']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          produitId = produits[i]['id'];
                          showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                insetPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: Container(
                                    width: 800,
                                    child: modificationProduit(produitId)),
                              );
                            },
                            animationType: DialogTransitionType.fadeScale,
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(seconds: 1),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          produitId = produits[i]['id'];
                          showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                insetPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: Container(
                                    width: 400,
                                    height: 100,
                                    child: suppressionProduit(produitId)),
                              );
                            },
                            animationType: DialogTransitionType.fadeScale,
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(seconds: 1),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        Column(children: [
          SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 216, 216, 216),
                borderRadius: BorderRadius.circular(10)),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(Text("HOME"))));
              },
              child: Text(
                'Retour au Menu',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ]),
      ]),
    );
  }
}
