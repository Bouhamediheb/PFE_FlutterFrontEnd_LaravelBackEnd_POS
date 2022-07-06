// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BonEntree extends StatefulWidget {
  int ligneDocumentId;
  double totalDoc;

  BonEntree(
    this.ligneDocumentId,
    this.totalDoc,
  );

  @override
  State<BonEntree> createState() => _BonEntreeState();
}

class _BonEntreeState extends State<BonEntree> {
  late int idDoc;
  List? ligneDocuments = [];
  int? idSeq;
  final DateTime date = DateTime.now();
  String? numSeqDocument;
  @override
  void initState() {
    super.initState();
    fetchLigneDocuments();
    getidDoc();
    fetchSequence();
  }

  ajoutDocument(
      int type, String? numeroDoc, String? dateDoc, double totalDoc) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/document"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'type': type,
        'numDoc': numeroDoc,
        'dateDoc': dateDoc,
        'totalDoc': totalDoc
      }),
    );
    if (response.statusCode == 200) {
      return "Document ajouté avec succès";
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  modificationStock(String refProd, double stock) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/produit/stock/$refProd"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'stock': stock,
      }),
    );
    if (response.statusCode == 200) {
      print("Quantité du Produit Modifié");
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  ajoutLigneDocument(int idDoc, String refProd, String nomProd, double qteProd,
      double prixProd, double tvaProd) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/lignedocument"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_doc': idDoc,
        'refProd': refProd,
        'nomProd': nomProd,
        'qteProd': qteProd,
        'prixProd': prixProd,
        'tvaProd': tvaProd
      }),
    );
    if (response.statusCode == 200) {
      print("Ligne Document Ajouté");
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  getidDoc() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/document'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        if (items.isEmpty)
          idDoc = 1;
        else {
          idDoc = items[items.length - 1]['id'] + 1;
          print(idDoc);
        }
      });
    }
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
        for (var i = 0; i < items.length; i++)
          if (items[i]['id_doc'] == widget.ligneDocumentId) {
            ligneDocuments!.add(items[i]);
          }
        print(ligneDocuments);
      });
    } else {
      throw Exception('Error!');
    }
  }

  updateSeqDocument() async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/seqdoc/2"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      print("Numéro de Document Modifié");
    } else {
      throw Exception('Erreur base de données!');
    }
  }

  fetchSequence() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/seqdoc/2'),
      headers: <String, String>{
        'Accept': 'application/json; charset=utf-8',
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        print(items['seq_id']);
        idSeq = items['seq_id'] + 1;
      });
    }
  }

  String seqDocument() {
    idSeq ??= 1;
    return numSeqDocument = '${date.toString().substring(0, 10)}/BE$idSeq';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
            height: 53,
            color: const Color.fromARGB(255, 75, 100, 211),
            onPressed: () async {
              String numDoc = seqDocument();
              await ajoutDocument(
                  2, numDoc, date.toString().substring(0, 10), widget.totalDoc);
              await updateSeqDocument();

              for (var i = 0; i < ligneDocuments!.length; i++) {
                ajoutLigneDocument(
                    idDoc,
                    ligneDocuments![i]['refProd'].toString(),
                    ligneDocuments![i]['nomProd'].toString(),
                    double.parse(ligneDocuments![i]['qteProd'].toString()),
                    double.parse(ligneDocuments![i]['prixProd'].toString()),
                    double.parse(ligneDocuments![i]['tvaProd'].toString()));
                modificationStock(ligneDocuments![i]['refProd'].toString(),
                    double.parse(ligneDocuments![i]['qteProd'].toString()));
              }
              Navigator.of(context).pop();
            },
            child: Text("Transformer en Bon de d'entrée",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white))),
        MaterialButton(
            height: 53,
            color: const Color.fromARGB(255, 253, 0, 0),
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Text("Annuler",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white))),
      ],
    );
  }
}
