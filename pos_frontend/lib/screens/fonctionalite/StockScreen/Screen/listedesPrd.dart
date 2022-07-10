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
  String? refProd;

  @override
  void initState() {
    super.initState();
    fetchProduits();
  }

  List <TextEditingController> _stockcontrollers = [];
  final nvStock = TextEditingController();

  Future<http.Response?> InventaireProd(
    String refProd,
    double nvStock,
  ) async {
    List? produits = [];
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/produit/stock/$refProd'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'stock':nvStock,
      }),
    );
    if (response.statusCode == 200) {
      print('Quantité Produit inventaire Modifié');
    } else {
      throw Exception('Erreur base de données!');
    }
    return null;
  }

  Future<dynamic>? future;



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
        for(var i =0; i<produits!.length; i++){
          _stockcontrollers.add(TextEditingController());
        }
      });
      print("length of controllers ="+_stockcontrollers.length.toString());
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
                      'Etat du stock :',
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
                        child: Text("Stock existant",
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
                        child: Text("Prix de Vente",
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      )),
                      DataColumn(
                          label: Flexible(
                              child: Text("Etat",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                                      DataColumn(
                          label: Flexible(
                              child: Text("Action",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                    rows: <DataRow>[
                      for (var i = 0; i < produits!.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(produits![i]['refProd'].toString())),
                            DataCell(Text(produits![i]['nomProd'].toString())),
                            DataCell(Center(
                              child: TextFormField(
                                controller: _stockcontrollers[i],
                                textAlign: TextAlign.center, 
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'erreur stock';
                                  }
                                  return null;
                                
                                },
                                decoration: InputDecoration(
                                      errorBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,

                                  hintText: produits![i]['stock'].toString(),
                                 hintStyle: 
                                  TextStyle(color: Colors.grey[600]),

                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                            )),

                            
                            DataCell(Text(
                                "${produits![i]['prixAchatHT'].toStringAsFixed(3)} DT")),
                            DataCell(Text(
                                "${produits![i]['prixVenteHT'].toStringAsFixed(3)} DT")),
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
                                  DataCell(
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: const Icon(
                                            Icons.save_as,
                                            color: Colors.yellow),
                                        onPressed: () {
                                          
                                    InventaireProd(
                                      produits![i]['refProd'].toString(),
                                      double.parse(_stockcontrollers[i].text.toString()),
                                    );
                                    //Show snackbar saying done
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: (secondaryColor),
                                        content: Text(
                                          "le stock du produit "+produits![i]['refProd'].toString()+" mis à jour",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 250, 253, 255)),
                                        )),
                                  );
                                    
                                    setState(() {
                                      
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
