import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:projetpfe/constants.dart';
import 'package:projetpfe/screens/fonctionalite/ProduitScreen/Screen/supprimerunPrd.dart';
import 'modifierunPrd.dart';

class listeProduit extends StatefulWidget {
  @override
  State<listeProduit> createState() => listeProduitState();
}

class listeProduitState extends State<listeProduit> {
  int? produitId;
  int? fournisseurId;
  List? produits = [];
  Timer? t;
  @override
  void initState() {
    super.initState();
    fetchProduits();
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
        width: double.infinity,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: bgColor,
          elevation: 10,
          child: SizedBox(
            width: double.infinity,
            child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(5),
                child: Center(
                    child: SizedBox(
                  height: 45,
                  child: Center(
                    child: Text(
                      'La liste des produits :',
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
                height: 600,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                          label: Flexible(
                        child: Text("Référence du produit",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Nom du produit",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                     DataColumn(
                          label: Flexible(
                        child: Text("Description du produit",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Prix d'achat",
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
                      for (var i = 0; i < produits!.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(produits![i]['refProd'].toString())),
                            DataCell(Text(produits![i]['nomProd'].toString())),
                            DataCell(
                                Text(produits![i]['descriptionProd'].toString())),
                            DataCell(
                                Text(produits![i]['prixAchatHT'].toString())),
                            
                            
                            DataCell(
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: const Icon(
                                            Icons.mode_edit_outline_outlined,
                                            color: Colors.green),
                                        onPressed: () async {
                                          produitId = produits![i]['id'];
                                          fournisseurId = produits![i]['id_fournisseur'];
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
                                                    width: 1000,
                                                    child: modifierUnProduit(
                                                        produitId)),
                                              );
                                            },
                                            animationType:
                                                DialogTransitionType.fadeScale,
                                            curve: Curves.fastOutSlowIn,
                                            duration:
                                                const Duration(seconds: 1),
                                          );
                                          setState(() {
                                            fetchProduits();
                                          });
                                        }),
                                    if (produits![i]['stock'] == 0)
                                      IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () async {
                                            produitId = produits![i]['id'];
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
                                                      height: 130,
                                                      width: 320,
                                                      child: supprimerUnProduit(
                                                          produitId)),
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
                                              fetchProduits();
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
