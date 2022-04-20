import 'package:admin/screens/fonctionalite/DocumentScreen/Screen/supprimerunDct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../../dashboard/dashboard_screen.dart';
import '../../../main/main_screen.dart';
import 'listeligneDct.dart';
import 'modifierunDct.dart';

class listeDocument extends StatefulWidget {
  @override
  State<listeDocument> createState() => _listeDocumentState();
}

class _listeDocumentState extends State<listeDocument> {
  int documentId;
  List documents = [];
  @override
  void initState() {
    super.initState();
    this.fetchDocuments();
  }

  fetchDocuments() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/document'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        documents = items;
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
                      'La Liste Des Documents :',
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
                height: 840,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                          label: Flexible(
                        child: Text("Numéro Document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Date Document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Total Document",
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
                      for (var i = 0; i < documents.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(InkWell(
                                onTap: () {
                                  showAnimatedDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          backgroundColor: Color(0xFF2A2D3E),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          content: Container(
                                              width: 800,
                                              child: listeLigneDocument(
                                                  documents[i]['id'])));
                                    },
                                    animationType:
                                        DialogTransitionType.fadeScale,
                                    curve: Curves.fastOutSlowIn,
                                    duration: Duration(seconds: 1),
                                  );
                                },
                                child: Text(documents[i]['numDoc']))),
                            DataCell(Text(documents[i]['dateDoc'].toString())),
                            DataCell(Text(documents[i]['totalDoc'].toString())),
                            DataCell(
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                            Icons.mode_edit_outline_outlined,
                                            color: Colors.green),
                                        onPressed: () async {
                                          documentId = documents[i]['id'];
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
                                                    width: 1300,
                                                    child: modifierUnDocument(
                                                        documents[i]['id'],
                                                        documentId)),
                                              );
                                            },
                                            animationType:
                                                DialogTransitionType.fadeScale,
                                            curve: Curves.fastOutSlowIn,
                                            duration: Duration(seconds: 1),
                                          );
                                          await setState(() {
                                            fetchDocuments();
                                          });
                                        }),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline,
                                          color: Colors.red),
                                      onPressed: () async {
                                        documentId = documents[i]['id'];
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
                                                  child: supprimerUnDocument(
                                                      documentId)),
                                            );
                                          },
                                          animationType:
                                              DialogTransitionType.fadeScale,
                                          curve: Curves.fastOutSlowIn,
                                          duration: Duration(seconds: 1),
                                        );
                                        await setState(() {
                                          fetchDocuments();
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
