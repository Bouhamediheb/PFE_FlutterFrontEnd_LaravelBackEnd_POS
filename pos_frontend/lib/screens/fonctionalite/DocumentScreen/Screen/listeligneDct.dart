import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class listeLigneDocument extends StatefulWidget {
  int? ligneDocumentId;
  listeLigneDocument(this.ligneDocumentId);

  @override
  State<listeLigneDocument> createState() => _listeLigneDocumentState();
}

class _listeLigneDocumentState extends State<listeLigneDocument> {
  List? ligneDocuments = [];
  @override
  void initState() {
    super.initState();
    this.fetchLigneDocuments();
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
    return DataTable(columns: <DataColumn>[
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
        child: Text("Quantité Produit",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold)),
      )),
      DataColumn(
          label: Flexible(
        child: Text("Prix Produit",
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold)),
      )),
    ], rows: <DataRow>[
      for (var i = 0; i < ligneDocuments!.length; i++)
        if (ligneDocuments![i]['id_doc'] == widget.ligneDocumentId)
          DataRow(cells: <DataCell>[
            DataCell(Text(ligneDocuments![i]['refProd'].toString())),
            DataCell(Text(ligneDocuments![i]['nomProd'].toString())),
            DataCell(Text(ligneDocuments![i]['qteProd'].toString())),
            DataCell(Text(ligneDocuments![i]['prixProd'].toString()))
          ])
    ]);
  }
}
