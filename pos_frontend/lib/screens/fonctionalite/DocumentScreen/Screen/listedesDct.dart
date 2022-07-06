import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:projetpfe/constants.dart';
import 'package:projetpfe/screens/fonctionalite/DocumentScreen/Screen/bonentree.dart';
import 'listeligneDct.dart';
import 'modifierunDct.dart';

class listeDocument extends StatefulWidget {
  @override
  State<listeDocument> createState() => _listeDocumentState();
}

class _listeDocumentState extends State<listeDocument> {
  int? documentId;
  List? documents = [];
  String dropdownvalue = 'Tous les Documents';
  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  String getDocType(int number) {
    if (number == 1) {
      return "Bon de commande";
    } else if (number == 2) {
      return "Bon d'entrée";
    } else if (number == 3) {
      return "Bon de retour";
    } else if (number == 4) {
      return "Ticket";
    } else if (number == 5) {
      return "Facture";
    }
    return "Devis";
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: bgColor,
          elevation: 10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                    child: SizedBox(
                  height: 45,
                  child: Center(
                    child: Text(
                      'La liste des documents :',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
              ),
              const Divider(
                thickness: 3,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                          label: Flexible(
                        child: Text("Type du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Numéro du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Date du document",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Montant total du document",
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
                      for (var i = 0; i < documents!.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Center(
                                  child:
                                      Text(getDocType(documents![i]['type']))),
                            ),
                            DataCell(InkWell(
                                onTap: () {
                                  showAnimatedDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          backgroundColor: bgColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          content: SizedBox(
                                              width: 800,
                                              child: listeLigneDocument(
                                                  documents![i]['id'])));
                                    },
                                    animationType:
                                        DialogTransitionType.fadeScale,
                                    curve: Curves.fastOutSlowIn,
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: Center(
                                    child: Text(documents![i]['numDoc'])))),
                            DataCell(Center(
                                child:
                                    Text(documents![i]['dateDoc'].toString()))),
                            DataCell(Center(
                                child: Text(
                                    "${documents![i]['totalDoc'].toString()} DT"))),
                            DataCell(
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: const Icon(
                                            Icons.mode_edit_outline_outlined,
                                            color: Colors.green),
                                        onPressed: () async {
                                          documentId = documents![i]['id'];
                                          print(documentId);
                                          await showAnimatedDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: bgColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                content: SizedBox(
                                                    width: 1300,
                                                    child: modifierUnDocument(
                                                        documents![i]['id'],
                                                        documentId)),
                                              );
                                            },
                                            animationType:
                                                DialogTransitionType.fadeScale,
                                            curve: Curves.fastOutSlowIn,
                                            duration:
                                                const Duration(seconds: 1),
                                          );
                                          setState(() {
                                            fetchDocuments();
                                          });
                                        }),
                                    if (documents![i]['type'] == 1)
                                      IconButton(
                                          icon: const Icon(
                                              Icons.description_rounded,
                                              color: Colors.blue),
                                          onPressed: () async {
                                            documentId = documents![i]['id'];
                                            await showAnimatedDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor: bgColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  content: SizedBox(
                                                      width: 325,
                                                      height: 75,
                                                      child: BonEntree(
                                                        documents![i]['id'],
                                                        documents![i]
                                                            ['totalDoc'],
                                                      )),
                                                );
                                              },
                                              animationType:
                                                  DialogTransitionType
                                                      .fadeScale,
                                              curve: Curves.fastOutSlowIn,
                                              duration:
                                                  const Duration(seconds: 1),
                                            );
                                            setState(() {
                                              fetchDocuments();
                                            });
                                          }),
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
