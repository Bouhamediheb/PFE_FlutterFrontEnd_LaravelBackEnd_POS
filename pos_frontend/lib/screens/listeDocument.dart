// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, dead_code, avoid_unnecessary_containers, unnecessary_new

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pos_frontend/HomeScreen.dart';

class listeDocument extends StatefulWidget {
  @override
  _listeDocumentState createState() => _listeDocumentState();
}

class _listeDocumentState extends State<listeDocument> {
  int documentId = 1;

  List documents = [];
  @override
  void initState() {
    super.initState();
    this.fetchUsers();
  }

  fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/document'));

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        documents = items;
        print(documents[2]['numDoc']);
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
                'La Liste Des Documents :',
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
        for (var i = 0; i < documents.length; i++)
          Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                title: Text(documents[i]['numDoc']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          documentId = documents[i]['id'];
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen(Text('EDITED'))))
                              .then((value) => setState(
                                    () {
                                      listeDocument();
                                    },
                                  ));
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          documentId = documents[i]['id'];
                          print(documentId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(Text('DELETED'))));
                          print(documentId);
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
