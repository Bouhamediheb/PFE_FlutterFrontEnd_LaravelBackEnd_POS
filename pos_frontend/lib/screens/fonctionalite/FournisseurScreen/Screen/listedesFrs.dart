import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../../main/main_screen.dart';
import 'modifierunFrs.dart';
import 'supprimerunFrs.dart';

class listeFournisseur extends StatefulWidget {
  @override
  State<listeFournisseur> createState() => _listeFournisseurState();
}

class _listeFournisseurState extends State<listeFournisseur> {
  int fournisseurId;
  List fournisseurs = [];
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
        print(fournisseurs[0]['raisonSociale']);
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
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xFF2A2D3E),
          elevation: 10,
          child: Container(
            width: double.infinity,
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
                        child: Text("Raison Sociale",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Adresse",
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
                        child: Text("Matricule Fiscale",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Timbre Fiscale",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                              child: Text("Actions",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                    rows: <DataRow>[
                      for (var i = 0; i < fournisseurs.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(fournisseurs[i]['raisonSociale'])),
                            DataCell(Text(fournisseurs[i]['adresse'])),
                            DataCell(Text(fournisseurs[i]['tel'])),
                            DataCell(Text(fournisseurs[i]['email'])),
                            DataCell(Text(fournisseurs[i]['mf'])),
                            DataCell(Text(
                                fournisseurs[i]['timbreFiscal'].toString())),
                            DataCell(
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                            Icons.mode_edit_outline_outlined,
                                            color: Colors.green),
                                        onPressed: () async {
                                          fournisseurId = fournisseurs[i]['id'];
                                          print(fournisseurs);
                                          await showAnimatedDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Color(0xFF2A2D3E),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                content: Container(
                                                    width: 800,
                                                    child:
                                                        modifierUnFournisseur(
                                                            fournisseurId)),
                                              );
                                            },
                                            animationType:
                                                DialogTransitionType.fadeScale,
                                            curve: Curves.fastOutSlowIn,
                                            duration: Duration(seconds: 1),
                                          );
                                          await setState(() {
                                            fetchFournisseurs();
                                          });
                                        }),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline,
                                          color: Colors.red),
                                      onPressed: () async {
                                        fournisseurId = fournisseurs[i]['id'];
                                        await showAnimatedDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10),
                                              backgroundColor:
                                                  Color(0xFF2A2D3E),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              content: Container(
                                                  width: 400,
                                                  height: 110,
                                                  child: supprimerUnFournisseur(
                                                      fournisseurId)),
                                            );
                                          },
                                          animationType:
                                              DialogTransitionType.fadeScale,
                                          curve: Curves.fastOutSlowIn,
                                          duration: Duration(seconds: 1),
                                        );
                                        await setState(() {
                                          fetchFournisseurs();
                                        });
                                      },
                                    ),
                                  ]),
                            ),
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
