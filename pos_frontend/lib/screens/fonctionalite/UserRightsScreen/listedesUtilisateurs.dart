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
  String? _chosenValue ;
static const snackBar = SnackBar(
  content: Text('Tâche effectuée avec succès'),
);
  int? fournisseurId;
  List? fournisseurs = [];
  @override
  void initState() {
    super.initState();
    this.fetchFournisseurs();
  }

  fetchFournisseurs() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/fournisseur'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        fournisseurs = items;
      });
    } else {
      throw Exception('Error!');
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
                        child: Text("Numéro de Téléphone",
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
                      for (var i = 0; i < fournisseurs!.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text("TEST VALUE")),
                           DataCell(Text("TEST VALUE")),
                           DataCell(Text("TEST VALUE")),
                           DataCell(Text("TEST VALUE")),
                            DataCell(
                              DropdownButton<String>(
            value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),

            items: <String>[
              'Administrateur',
              'Agent de bureau',
              'Caissier',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "Liste des rôles ..",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
               
                  ),
            ),
            onChanged: (String? value) {
              setState(() {
                _chosenValue = value!;
                print(_chosenValue);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

              });
            },
          ),)
                            
                           
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
