import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/fonctionalite/DocumentScreen/Screen/choixDct.dart';
import 'package:admin/screens/fonctionalite/FournisseurScreen/Screen/ajouterunFrs.dart';
import 'package:admin/screens/fonctionalite/ProduitScreen/Screen/ajouterunPrd.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class listeUtlisateurs extends StatefulWidget {
  @override
  State<listeUtlisateurs> createState() => _listeUtlisateursState();
}

class _listeUtlisateursState extends State<listeUtlisateurs> {
  String? _chosenValue;
  static const snackBar = SnackBar(
    content: Text('Tâche effectuée avec succès'),
  );
  List? users = [];
  @override
  void initState() {
    super.initState();
    this.fetchUsers();
  }

  fetchUsers() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/users'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        users = items;
        print(users);
      });
    } else {
      throw Exception('Error!');
    }
  }

  attribuerRole(int id, int role) async {
    final reponse = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/role/$id'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'role': role,
      }),
    );
    if (reponse.statusCode == 200) {
      print('success');
    } else {
      print('error');
    }
  }

  Text typeAcc(int y) {
    if (users![y]['role'] == 1) {
      return Text('Administrateur');
    } else if (users![y]['role'] == 2)
      return Text("Agent de Bureau");
    else if (users![y]['role'] == 3)
      return Text("Caissier");
    else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xFF2A2D3E),
          elevation: 10,
          child: Container(
            width: double.infinity,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Container(
                  height: 25,
                  child: Center(
                    child: Text(
                      'La Liste Des Utlisateurs :',
                      style: TextStyle(
                          //fontFamily: 'Montserrat',
                          color: Colors.white,
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
              SizedBox(
                height: 600,
                child: SingleChildScrollView(
                    child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                        label: Flexible(
                      child: Text("Identifiant",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    DataColumn(
                        label: Flexible(
                      child: Text("Nom et prénom",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    DataColumn(
                        label: Flexible(
                      child: Text("E-mail",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )),
                    DataColumn(
                        label: Flexible(
                            child: Text("Droit d'accès",
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                  ],
                  rows: <DataRow>[
                    for (var i = 0; i < users!.length; i++)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(users![i]['id'].toString())),
                          DataCell(Text(users![i]['name'])),
                          DataCell(Text(users![i]['email'])),
                          DataCell(
                            PopupMenuButton<int>(
                              onSelected: (dynamic value) {
                                if (value == 1) {
                                  attribuerRole(users![i]['id'], 1);
                                  setState(() {
                                    fetchUsers();
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                if (value == 2) {
                                  attribuerRole(users![i]['id'], 2);
                                  setState(() {
                                    fetchUsers();
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                if (value == 3) {
                                  attribuerRole(users![i]['id'], 3);
                                  setState(() {
                                    fetchUsers();
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              color: Color(0xFF247b9c),
                              offset: Offset(0, 30),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                                width: 150,
                                child: Row(
                                  children: [
                                    typeAcc(i),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: Text('Administrateur'),
                                ),
                                PopupMenuDivider(
                                  height: 5,
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Text('Agent de Bureau'),
                                ),
                                PopupMenuDivider(
                                  height: 5,
                                ),
                                PopupMenuItem(
                                  value: 3,
                                  child: Text('Caissier'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                )),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
