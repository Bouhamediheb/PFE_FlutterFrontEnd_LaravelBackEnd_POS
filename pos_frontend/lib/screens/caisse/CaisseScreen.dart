import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Login/Screen/Login.dart';
import 'Produit.dart';
import 'Panier.dart';

class Caisse extends StatefulWidget {
  const Caisse({Key? key}) : super(key: key);

  @override
  State<Caisse> createState() => _CaisseState();
}

class _CaisseState extends State<Caisse> {
  late var token;
  Map<String, dynamic> user = {};
  @override
  initState() {
    super.initState();
    fillListePanier();
    getUserData();
  }

  void fillListePanier() {
    setState(() {
      for (var i = 1; i <= nbTotalesTables; i++) {
        listePanier[i] = [];
      }
    });
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    token = jsonDecode(prefs.getString('access_token') as String);
    setState(() {
      user = json.decode(prefs.getString('user') as String);
    });
  }

  Map<int, List<Panier>> listePanier = {};
  List<Produit> listeProduits = [
    Produit(
        nom: 'Coca-Cola',
        prix: 2.5,
        quantite: 0,
        image: "assets/images/coca.jpg"),
    Produit(
        nom: 'Fanta', prix: 2.5, quantite: 0, image: "assets/images/fanta.jpg"),
    Produit(
        nom: 'Pepsi', prix: 2.5, quantite: 0, image: "assets/images/pepsi.jpg"),
    Produit(
        nom: 'Sprite',
        prix: 2.5,
        quantite: 0,
        image: "assets/images/sprite.jpg"),
    Produit(
        nom: 'Eau Minérale',
        prix: 2.5,
        quantite: 0,
        image: "assets/images/eau.jpg"),
    Produit(
      nom: 'Citronade',
      prix: 2.5,
      quantite: 0,
      image: "assets/images/citronade.jpg",
    ),
    Produit(
      nom: "Jus d'orange",
      prix: 2.5,
      quantite: 0,
      image: "assets/images/jus.png",
    ),
  ];
  int selectedTable = 1;
  int nbTotalesTables = 20;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF331f61),
          elevation: 0,
          centerTitle: false,
          actions: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Table : $selectedTable / $nbTotalesTables",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: PopupMenuButton(
                  onSelected: (dynamic value) {
                    if (value == 2) logout();
                  },
                  offset: const Offset(0, 50.0),
                  color: Color(0xFF331f61),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 56,
                    width: 225,
                    decoration: BoxDecoration(
                        color: Color(0xFF462c86),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/profile_pic.png",
                          height: 38,
                        ),
                        Text(user["name"].toString())
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                        const PopupMenuItem(value: 1, child: Text("Profile")),
                        PopupMenuItem(
                            value: 2,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.logout, color: Colors.red),
                                  Text("Se Déconnecter",
                                      style: TextStyle(color: Colors.red))
                                ])),
                      ]),
            ),
          ]),
      backgroundColor: const Color(0xFF331f61),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Expanded(
                child: SizedBox(
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
                                  primary: const Color(0xFF462c86),
                                  fixedSize: const Size(50, 50),
                                  shape: const CircleBorder(),
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
                      color: const Color(0xFF462c86),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FittedBox(
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
                        const SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: const Text("Boissons",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFe9d8ff),
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: const Text("Aliments",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFe9d8ff),
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {},
                          child: const Text("Viennoiserie",
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
                    height: MediaQuery.of(context).size.height / 2.1,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF462c86),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelText: "0",
                            labelStyle: TextStyle(
                                color: Color(0xFFac98de),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          style: TextStyle(
                              color: Color(0xFFac98de),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NumberButton(
                              number: 7,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                            NumberButton(
                              number: 8,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                            NumberButton(
                              number: 9,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NumberButton(
                              number: 4,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                            NumberButton(
                              number: 5,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                            NumberButton(
                              number: 6,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NumberButton(
                              number: 1,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                            NumberButton(
                              number: 2,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                            NumberButton(
                              number: 3,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(
                                Icons.keyboard_return,
                                color: Color(0xFF09c569),
                              ),
                              iconSize: 50,
                            ),
                            NumberButton(
                              number: 0,
                              color: Color(0xFFac98de),
                              size: 60,
                              controller: controller,
                            ),
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(
                                Icons.backspace,
                                color: Color(0xFF09c569),
                              ),
                              iconSize: 50,
                            ),
                          ],
                        ),
                      ],
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
                color: const Color(0xFF462c86),
                borderRadius: BorderRadius.circular(25),
              ),
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                primary: false,
                padding: const EdgeInsets.all(20),
                children: <Widget>[
                  for (var i = 0; i < listeProduits.length; i++)
                    FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 1,
                            ),
                          ],
                          color: const Color(0xFF553b93),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 5.7,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25)),
                                child: Image.asset(
                                  "${listeProduits[i].image}",
                                  //height: MediaQuery.of(context).size.height / 3,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${listeProduits[i].nom}",
                                  style: const TextStyle(
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
                        margin: const EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                          boxShadow: const [
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[800],
                                      fixedSize: const Size(40, 40),
                                      shape: const CircleBorder(),
                                      side: const BorderSide(
                                        color: Colors.white,
                                      )),
                                  onPressed: () {
                                    if (listeProduits[i].quantite! > 0) {
                                      setState(() {
                                        listeProduits[i].quantite =
                                            listeProduits[i].quantite! - 1;
                                      });
                                    }
                                  },
                                  child: const Icon(Icons.remove),
                                ),
                                Text(listeProduits[i].quantite.toString(),
                                    style: const TextStyle(fontSize: 36)),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[800],
                                      fixedSize: const Size(40, 40),
                                      shape: const CircleBorder(),
                                      side: const BorderSide(
                                        color: Colors.white,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      listeProduits[i].quantite =
                                          listeProduits[i].quantite! + 1;
                                    });
                                  },
                                  child: const Icon(Icons.add),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[800],
                                fixedSize: const Size(200, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    if (listeProduits[i].quantite! > 0) {
                                      listePanier.appendToList(
                                          selectedTable,
                                          Panier(
                                              nomProd: listeProduits[i].nom,
                                              prixProd: listeProduits[i].prix! *
                                                  listeProduits[i].quantite!,
                                              quantiteProd:
                                                  listeProduits[i].quantite));
                                    }
                                  },
                                );
                              },
                              child: const Text("Ajouter au Panier",
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
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF462c86),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        const Align(
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
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Table",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "#$selectedTable",
                            style: const TextStyle(
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
                            columns: const [
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
                                        "${listePanier[selectedTable]!.elementAt(i).nomProd}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "${listePanier[selectedTable]!.elementAt(i).quantiteProd}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "${listePanier[selectedTable]!.elementAt(i).prixProd} DT",
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
                        const Divider(
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
                            Text(getTotal().toString() + " DT",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
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
                              primary: const Color(0xFF09c569),
                              fixedSize: const Size(200, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("Confirmer",
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Container(
                      padding: const EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 4.5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF462c86),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  primary: const Color(0xFF09c569),
                                  fixedSize: const Size(140, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Foncionnalité 1",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  primary: const Color(0xFF09c569),
                                  fixedSize: const Size(140, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Foncionnalité 2",
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  primary: const Color(0xFF09c569),
                                  fixedSize: const Size(140, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Foncionnalité 3",
                                    style: TextStyle(fontSize: 16)),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  primary: const Color(0xFF09c569),
                                  fixedSize: const Size(140, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Foncionnalité 4",
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double getTotal() {
    double total = 0;
    for (var i = 0; i < listePanier[selectedTable]!.length; i++) {
      total += listePanier[selectedTable]!.elementAt(i).prixProd!;
    }
    return total;
  }
}

extension AppendToListOnMapWithListsExtension<K, V> on Map<K, List<V>> {
  void appendToList(K key, V value) =>
      update(key, (list) => list..add(value), ifAbsent: () => [value]);
}

class NumberButton extends StatelessWidget {
  final int number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size / 2),
          ),
        ),
        onPressed: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
