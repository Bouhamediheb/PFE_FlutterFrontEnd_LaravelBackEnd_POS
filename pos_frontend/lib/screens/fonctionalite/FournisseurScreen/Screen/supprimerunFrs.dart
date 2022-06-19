// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class supprimerUnFournisseur extends StatefulWidget {
  int? fournisseurId;
  supprimerUnFournisseur(this.fournisseurId);
  @override
  State<supprimerUnFournisseur> createState() => _supprimerUnFournisseurState();
}

class _supprimerUnFournisseurState extends State<supprimerUnFournisseur> {
  suppressionFournisseur(id) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/fournisseur/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<dynamic>? future;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: const Color(0xFF2A2D3E),
        child: Column(
          children: [
            const Text('Voulez vous vraiment supprimer ce fournisseur ?'),
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                onPressed: (() {
                  setState(() {
                    future = suppressionFournisseur(widget.fournisseurId);
                  });
                  Navigator.of(context, rootNavigator: true).pop();
                }),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.red,
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: const Text(
                  "Supprimer",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (() {
                  Navigator.of(context).pop();
                }),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.white,
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  "Annuler",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ])
          ],
        ));
  }
}
