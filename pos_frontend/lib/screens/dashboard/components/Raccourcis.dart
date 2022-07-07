// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../constants.dart';

class ListeRaccourcis extends StatefulWidget {
  const ListeRaccourcis({
    Key? key,
  }) : super(key: key);

  @override
  State<ListeRaccourcis> createState() => _ListeRaccourcisState();
}

class _ListeRaccourcisState extends State<ListeRaccourcis> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration:  BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'La liste des raccourcis :',
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
                  const SizedBox(height: 10),
                  DataTable(
                    columnSpacing: 70,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Flexible(
                          child: Text(
                            "Raccourcis",
                            maxLines: 5,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Flexible(
                          flex: 4,
                          child: Text(
                            "Actions",
                            maxLines: 5,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              children: [
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                                const SizedBox(width: 5),
                                const Text("+", style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 5),
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                              ],
                            ),
                          ),
                          const DataCell(
                            Text("Bon de commande", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              children: [
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                                const SizedBox(width: 5),
                                const Text("+", style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 5),
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                              ],
                            ),
                          ),
                          const DataCell(
                            Text("Bon de livraison", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              children: [
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                                const SizedBox(width: 5),
                                const Text("+", style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 5),
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                              ],
                            ),
                          ),
                          const DataCell(
                            Text("Liste des produits", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              children: [
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                                const SizedBox(width: 5),
                                const Text("+", style: TextStyle(fontSize: 20)),
                                const SizedBox(width: 5),
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                              ],
                            ),
                          ),
                          const DataCell(
                            Text("Liste des fournisseurs", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
