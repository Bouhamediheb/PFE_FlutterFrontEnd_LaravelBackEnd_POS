// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BonEntree extends StatefulWidget {
  int? ligneDocumentId;
  String? dateDoc;
  num? totalDoc;
  String? numDoc;
  BonEntree(this.ligneDocumentId, this.dateDoc, this.totalDoc, this.numDoc);

  @override
  State<BonEntree> createState() => _BonEntreeState();
}

class _BonEntreeState extends State<BonEntree> {
  List? ligneDocuments = [];
  @override
  void initState() {
    super.initState();
    fetchLigneDocuments();
  }

  fetchLigneDocuments() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/lignedocument'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        ligneDocuments = items;
      });
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
            height: 53,
            color: const Color.fromARGB(255, 75, 100, 211),
            onPressed: () async {},
            child: Text("Transformer en Bon de d'entrée",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white))),
        MaterialButton(
            height: 53,
            color: const Color.fromARGB(255, 253, 0, 0),
            onPressed: () async {},
            child: Text("Annuler",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white))),
      ],
    );
  }
}
