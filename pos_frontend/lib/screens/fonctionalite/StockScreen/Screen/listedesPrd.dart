import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projetpfe/constants.dart';

class EtatStockGlobal extends StatefulWidget {
  @override
  State<EtatStockGlobal> createState() => EtatStockGlobalState();
}

class EtatStockGlobalState extends State<EtatStockGlobal> {
  int? produitId;
  List? produits = [];

  Timer? t;

  @override
  void initState() {
    super.initState();
    t = new Timer.periodic(timeDelay, (t) => fetchProduits());
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
  void dispose() {
    t?.cancel();
    super.dispose();
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
                      'La Liste Des Produits :',
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
                        child: Text("Référence Produit",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Nom Produit",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Stock",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Prix Achat",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("Prix Vente",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                        child: Text("TVA",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                              child: Text("Etat",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                    rows: <DataRow>[
                      for (var i = 0; i < produits!.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(produits![i]['refProd'].toString())),
                            DataCell(Text(produits![i]['nomProd'].toString())),
                            DataCell(Text(produits![i]['stock'].toString())),
                            DataCell(
                                Text(produits![i]['prixAchat'].toString())),
                            DataCell(
                                Text(produits![i]['prixVente'].toString())),
                            DataCell(
                                Text("${produits![i]['TVA'].toString()}%")),
                            produits![i]['stock'] <= 5
                                ? const DataCell(
                                    Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  )
                                : const DataCell(
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
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
