import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants.dart';

class EmptySpace extends StatefulWidget {
  const EmptySpace({
    Key? key,
  }) : super(key: key);

  @override
  State<EmptySpace> createState() => _EmptySpaceState();
}

class _EmptySpaceState extends State<EmptySpace> {
  List? produits = [];
  @override
  void initState() {
    super.initState();
    this.fetchProduits();
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
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'La Liste Des Produits :',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Divider(
                  thickness: 3,
                ),
              ),
              DataTable(
                columnSpacing: 180,
                columns: <DataColumn>[
                  DataColumn(
                    label: Flexible(
                      child: Text(
                        "Nom du produit",
                        maxLines: 5,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Flexible(
                      child: Text(
                        "Quantité",
                        maxLines: 5,
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
