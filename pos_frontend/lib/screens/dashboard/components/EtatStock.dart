// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants.dart';

class EtatStock extends StatefulWidget {
  const EtatStock({
    Key? key,
  }) : super(key: key);

  @override
  State<EtatStock> createState() => _EtatStockState();
}

class _EtatStockState extends State<EtatStock> {
  List? produits = [];
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
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'La Liste Des Produits :',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Divider(
                  thickness: 3,
                ),
              ),
              DataTable(
                columnSpacing: 100,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Flexible(
                      flex: 2,
                      child: Text(
                        "Produit",
                        maxLines: 5,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Flexible(
                      flex: 2,
                      child: Text(
                        "Quantité",
                        maxLines: 5,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Flexible(
                      flex: 1,
                      child: Text(
                        "Etat",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
                rows: <DataRow>[
                  for (var i = 0; i < produits!.length; i++)
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(produits![i]['nomProd']),
                        ),
                        DataCell(
                          Text(produits![i]['stock'].toString()),
                        ),
                        // if produit stock is less than 5 then show red icon
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
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
