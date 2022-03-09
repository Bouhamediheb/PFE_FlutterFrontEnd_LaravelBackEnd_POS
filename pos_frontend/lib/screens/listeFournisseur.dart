// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, dead_code, avoid_unnecessary_containers, unnecessary_new

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pos_frontend/HomeScreen.dart';

class listeFournisseur extends StatefulWidget {
  @override
  _listeFournisseurState createState() => _listeFournisseurState();
}

class _listeFournisseurState extends State<listeFournisseur> {
  int fournisseurId = 1;

  List fournisseurs = [];
  @override
  void initState() {
    super.initState();
    this.fetchUsers();
  }

  fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/fournisseur'));

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        fournisseurs = items;
        print(fournisseurs[0]['raisonSociale']);
      });
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      elevation: 10,
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
                child: Container(
              height: 20,
              child: Center(
                child: Text(
                  'La Liste Des Fournisseurs :',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
          ),
          Divider(
            thickness: 3,
          ),
          SizedBox(
            height: 30,
          ),
          for (var i = 0; i < fournisseurs.length; i++)
            Card(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                ListTile(
                  title: Text(fournisseurs[i]['raisonSociale']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            fournisseurId = fournisseurs[i]['id'];
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(Text('Ajouti Dialog'))))
                                .then((value) => setState(
                                      () {
                                        listeFournisseur();
                                      },
                                    ));
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            fournisseurId = fournisseurs[i]['id'];
                            print(fournisseurId);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(Text('DELETED'))));
                            print(fournisseurId);
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
      ),
    );
  }
}
