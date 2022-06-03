import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          height: 650,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'La Liste Des Raccourcis :',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Divider(
                      thickness: 3,
                    ),
                  ),
                  SizedBox(height: 20),
                  DataTable(
                    columnSpacing: 180,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Flexible(
                          child: Text(
                            "Actions",
                            maxLines: 5,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
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
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Row(
                              children: [
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                                SizedBox(width: 5),
                                Text("+", style: TextStyle(fontSize: 20)),
                                SizedBox(width: 5),
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                              ],
                            ),
                          ),
                          DataCell(
                            Text("xxxxxxxx", style: TextStyle(fontSize: 20)),
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
                                SizedBox(width: 5),
                                Text("+", style: TextStyle(fontSize: 20)),
                                SizedBox(width: 5),
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                              ],
                            ),
                          ),
                          DataCell(
                            Text("xxxxxxxx", style: TextStyle(fontSize: 20)),
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
                                SizedBox(width: 5),
                                Text("+", style: TextStyle(fontSize: 20)),
                                SizedBox(width: 5),
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                              ],
                            ),
                          ),
                          DataCell(
                            Text("xxxxxxxx", style: TextStyle(fontSize: 20)),
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
                                SizedBox(width: 5),
                                Text("+", style: TextStyle(fontSize: 20)),
                                SizedBox(width: 5),
                                Image.asset("assets/images/f1png.png",
                                    width: 35, height: 35, color: Colors.white),
                              ],
                            ),
                          ),
                          DataCell(
                            Text("xxxxxxxx", style: TextStyle(fontSize: 20)),
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
