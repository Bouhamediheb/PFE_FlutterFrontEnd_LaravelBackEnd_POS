import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flip_card/flip_card.dart';
import 'package:data_table_2/data_table_2.dart';
import 'Produit.dart';

class Caisse extends StatefulWidget {
  Caisse({Key? key}) : super(key: key);

  @override
  State<Caisse> createState() => _CaisseState();
}

class _CaisseState extends State<Caisse> {
  @override
  initState() {
    super.initState();
    fillListePanier();
  }

  void fillListePanier() {
    setState(() {
      for (var i = 1; i <= nbTotalesTables; i++) {
        listePanier[i] = [];
      }
    });
  }

  List<Produit> Test = [];
  Map<int, List<Produit>> listePanier = {};
  List<Produit> listeProduits = [
    Produit(
      nom: 'Coca Cola',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Fanta',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Sprite',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Pepsi',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Coca Cola',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Fanta',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Sprite',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Pepsi',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Coca Cola',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Fanta',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Sprite',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Pepsi',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Coca Cola',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Fanta',
      prix: 2.5,
      quantite: 10,
    ),
    Produit(
      nom: 'Sprite',
      prix: 2.5,
      quantite: 10,
    ),
  ];
  int quantite = 0;
  int selectedTable = 1;
  int nbTotalesTables = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF331f61),
          elevation: 0,
          centerTitle: false,
          actions: [
            Text(
              "Table : $selectedTable / $nbTotalesTables",
              style: TextStyle(fontSize: 16),
            ),
          ]),
      backgroundColor: Color(0xFF331f61),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                        itemCount: nbTotalesTables,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF462c86),
                                  fixedSize: Size(50, 50),
                                  shape: CircleBorder(),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedTable = index++;
                                  });
                                },
                                child: Text("${index = index + 1}")),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width / 7,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF462c86),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Produits",
                            style: TextStyle(
                                color: Color(0xFFac98de),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Boissons",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFe9d8ff),
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Aliments",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFe9d8ff),
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Viennoiserie",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFe9d8ff),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 7,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                      color: Color(0xFF462c86),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 20),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.75,
              decoration: BoxDecoration(
                color: Color(0xFF462c86),
                borderRadius: BorderRadius.circular(25),
              ),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                primary: false,
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  for (var i = 0; i < listeProduits.length; i++)
                    FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 1,
                            ),
                          ],
                          color: Color(0xFF553b93),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                              child: Image.asset(
                                "assets/images/jus.png",
                                //height: MediaQuery.of(context).size.height / 3,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${listeProduits[i].nom}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${listeProduits[i].prix}DT",
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      back: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 1,
                            ),
                          ],
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Quantite(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey[800],
                                  fixedSize: Size(200, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  side: BorderSide(
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                setState(
                                  () {
                                    listePanier.appendToList(
                                        selectedTable, listeProduits[i]);
                                  },
                                );
                              },
                              child: Text("Ajouter au Panier",
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, bottom: 20),
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                  color: Color(0xFF462c86),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Ticket",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Table",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "#$selectedTable",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.75,
                      child: DataTable2(
                        columnSpacing: 10,
                        columns: [
                          DataColumn2(
                            label: Text(
                              "Nom",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataColumn2(
                            label: Text(
                              "Quantité",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Text(
                              "Prix",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          for (var i = 0;
                              i < listePanier[selectedTable]!.length;
                              i++)
                            DataRow2(
                              cells: [
                                DataCell(
                                  Text(
                                    "${listePanier[selectedTable]!.elementAt(i).nom}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "${listePanier[selectedTable]!.elementAt(i).quantite}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "${listePanier[selectedTable]!.elementAt(i).prix} DT",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("2 DT",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          primary: Color(0xFF09c569),
                          fixedSize: Size(200, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          //print(listePanier.values);
                          print(listePanier.length);
                        },
                        child:
                            Text("Confirmer", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row Quantite() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.grey[800],
              fixedSize: Size(40, 40),
              shape: CircleBorder(),
              side: BorderSide(
                color: Colors.white,
              )),
          onPressed: () {
            if (quantite > 0) {
              setState(() {
                quantite = quantite - 1;
              });
            }
          },
          child: Icon(Icons.remove),
        ),
        Text('$quantite', style: TextStyle(fontSize: 36)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.grey[800],
              fixedSize: Size(40, 40),
              shape: CircleBorder(),
              side: BorderSide(
                color: Colors.white,
              )),
          onPressed: () {
            setState(() {
              quantite = quantite + 1;
              print(quantite);
            });
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}

extension AppendToListOnMapWithListsExtension<K, V> on Map<K, List<V>> {
  void appendToList(K key, V value) =>
      update(key, (list) => list..add(value), ifAbsent: () => [value]);
}
