import 'dart:convert';
import 'dart:io';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:projetpfe/constants.dart';
import 'package:projetpfe/screens/caisse/previewPDF.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../Login/Screen/Login.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'Produit.dart';
import 'Panier.dart';
import 'package:printing/printing.dart';



class Caisse extends StatefulWidget {
  const Caisse({Key? key}) : super(key: key);

  @override
  State<Caisse> createState() => _CaisseState();
}

class _CaisseState extends State<Caisse> {
  late var token;
   int cat =1;
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

  
  imprimerCommande() async {
    var pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('POS360', style: pw.TextStyle(fontSize: 4)),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Commande n° 001',
                            style: pw.TextStyle(fontSize: 1)),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                            'Date : ${DateTime.now().toString().substring(0, 19)}',
                            style: pw.TextStyle(fontSize: 1)),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Expanded(
                      flex: 2,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Caissier : ${user['name']}',
                            style: pw.TextStyle(fontSize: 1)),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text('Table : $selectedTable',
                            style: pw.TextStyle(fontSize: 1)),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 2),
                pw.Column(
                  children: [
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Quantité',
                              style: pw.TextStyle(fontSize: 1)),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Désignation',
                              style: pw.TextStyle(fontSize: 1)),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Prix Unitaire',
                              style: pw.TextStyle(fontSize: 1)),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Total',
                              style: pw.TextStyle(fontSize: 1)),
                        ),
                      ),
                    ]),
                    pw.SizedBox(height: 0.5),
                    pw.Text(
                        '----------------------------------------------------------------------------------------------------------------------',
                        style: pw.TextStyle(fontSize: 1)),
                    pw.SizedBox(height: 0.5),
                    for (var i = 0; i < listePanier[selectedTable]!.length; i++)
                      pw.SizedBox(
                        height: 2,
                        child: pw.Row(children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                  '${listePanier[selectedTable]!.elementAt(i).quantiteProd}',
                                  style: pw.TextStyle(fontSize: 1)),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                  '${listePanier[selectedTable]!.elementAt(i).nomProd}',
                                  style: pw.TextStyle(fontSize: 1)),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                  '${(listePanier[selectedTable]!.elementAt(i).prixProd! / listePanier[selectedTable]!.elementAt(i).quantiteProd!).toStringAsFixed(3)}',
                                  style: pw.TextStyle(fontSize: 1)),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                  '${(listePanier[selectedTable]!.elementAt(i).prixProd)!.toStringAsFixed(3)}',
                                  style: pw.TextStyle(fontSize: 1)),
                            ),
                          ),
                        ]),
                      ),
                    pw.SizedBox(height: 0.5),
                    pw.Text(
                        '----------------------------------------------------------------------------------------------------------------------',
                        style: pw.TextStyle(fontSize: 1)),
                    pw.SizedBox(height: 0.5),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text('Total',
                                  style: pw.TextStyle(
                                      fontSize: 2,
                                      fontWeight: pw.FontWeight.bold)),
                            ),
                          ),
                          pw.Expanded(
                            flex: 2,
                            child: pw.Align(
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                  '${getTotal().toStringAsFixed(3)} DT',
                                  style: pw.TextStyle(
                                      fontSize: 2,
                                      fontWeight: pw.FontWeight.bold)),
                            ),
                          ),
                        ]),
                    pw.SizedBox(height: 0.5),
                    pw.Text(
                        '----------------------------------------------------------------------------------------------------------------------',
                        style: pw.TextStyle(fontSize: 1)),
                    pw.SizedBox(height: 0.5),
                  ],
                ),
              ],
            ),
          );
        },
        pageFormat: PdfPageFormat(40, 80),
      ),
    );
    final file = File("lib/Commande.pdf");
    file.writeAsBytesSync(await pdf.save());
    PdfPreview(
      build: (format) => pdf.save(),
    );
  }

  Map<int, List<Panier>> listePanier = {};

// Catégorie 1 ---> Boisson
// Catégorie 2 ---> Viennoiserie
// Catégorie 3 ---> Plat
// Catégorie 4 ---> Chicha
// Catégorie 5 ---> Café



  List<Produit> listeProduits = [
    Produit(
        nom: 'Coca-Cola 33Cl',
        prix: 2.5,
        quantite: 0,
        image: "assets/images/coca.png",
        categorie: 1),
    Produit(
        nom: 'Fanta 33Cl',
         prix: 2.5,
          quantite: 0,
           image: "assets/images/fanta.jpg",
           categorie: 1
           ),
    Produit(
        nom: 'Pepsi 33Cl', prix: 2.5, quantite: 0, image: "assets/images/pepsi.jpg",           categorie: 1
),
    Produit(
        nom: 'Sprite',
        prix: 2.5,
        quantite: 0,
        image: "assets/images/sprite.jpg",           categorie: 1
),
    Produit(
        nom: 'Eau Minérale 1.5L',
        prix: 2.5,
        quantite: 0,
        image: "assets/images/eau.jpg",           categorie: 1
),
    Produit(
      nom: 'Citronade',
      prix: 3.5,
      quantite: 0,
      image: "assets/images/citronade.jpg",           categorie: 1
,
    ),
    Produit(
      nom: "Jus d'orange",
      prix: 4.5,
      quantite: 0,
      image: "assets/images/jus.png",
                 categorie: 1

    ),
    Produit(
      nom:"Chicha Menthe",
      prix:10.0,
      quantite:0,
      image:"assets/images/chicha.jpeg",
      categorie: 4,
    ),
    Produit(
      nom:"Chicha Raisin",
      prix:10.0,
      quantite:0,
      image:"assets/images/chicha.jpeg",
      categorie: 4,
    ),
    Produit(
      nom:"Chicha Pomme",
      prix:10.0,
      quantite:0,
      image:"assets/images/chicha.jpeg",
      categorie: 4,
    ),
    Produit(
      nom:"Chicha Cerise",
      prix:10.0,
      quantite:0,
      image:"assets/images/chicha.jpeg",
      categorie: 4,
    ),
    Produit(
      nom:"Croissant",
      prix:2.0,
      quantite:0,
      image:"assets/images/croissant.jpg",
      categorie: 2,
    ),
    Produit(
      nom:"Gateau",
      prix:8.0,
      quantite:0,
      image:"assets/images/gateau.jpg",
      categorie: 2,
    ),
    Produit(
      nom:"Plat escaloppe pané",
      prix:16.0,
      quantite:0,
      image:"assets/images/platesc.jpg",
      categorie: 3,
    ),
    Produit(
      nom:"Plat escaloppe grillé",
      prix:15.0,
      quantite:0,
      image:"assets/images/platespg.jpeg",
      categorie: 3,
    ),
    Produit(
      nom:"Plat grillade mixte",
      prix:20.0,
      quantite:0,
      image:"assets/images/grillade.jpg",
      categorie: 3,
    ),
     Produit(
      nom:"Plat cordon bleu",
      prix:14.0,
      quantite:0,
      image:"assets/images/cordon.jpg",
      categorie: 3,
    ),
     Produit(
      nom:"Plat kebab",
      prix:17.0,
      quantite:0,
      image:"assets/images/kebab.jpg",
      categorie: 3,
    ),
       Produit(
      nom:"Plat dorade grillé",
      prix:23.0,
      quantite:0,
      image:"assets/images/dorade.jpg",
      categorie: 3,
    ),
       Produit(
      nom:"Café Express",
      prix:5.0,
      quantite:0,
      image:"assets/images/cafe.jpg",
      categorie: 6,
    ),
    Produit(
      nom:"Café au lait",
      prix:5.5,
      quantite:0,
      image:"assets/images/cafe.jpg",
      categorie: 6,
    ),
    Produit(
      nom:"Café grand créme",
      prix:6,
      quantite:0,
      image:"assets/images/cafe.jpg",
      categorie: 6,
    ),
  ];
  int selectedTable = 1;
  int nbTotalesTables = 15;

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
          automaticallyImplyLeading: false,
          backgroundColor:Colors.grey[100],
          elevation: 0,
          centerTitle: false,
          actions: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Table : $selectedTable / $nbTotalesTables",
                style: const TextStyle(color: Colors.black,fontSize: 18),
              ),
            ),
            SizedBox(width: 20,),
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
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    height: 70,
                    width: 225,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: Colors.black)
  ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/profile_pic.png",
                          height: 38,
                        ),
                        Text(user["name"].toString(),style: TextStyle(color: Colors.black),)
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
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
      backgroundColor: Colors.grey[100],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:5),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 100,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: true),
                      child: ListView.builder(
                          itemCount: nbTotalesTables,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 3),
                              child: Stack(children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: bgColor,
                                    fixedSize:  Size(60, 60),
                                    shape:  CircleBorder(),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedTable = index++;
                                    });
                                  },
                                  child: Text(
                                    "${index = index + 1}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                if (listePanier[index]!.isNotEmpty)
                                  Positioned(
                                    right: 5,
                                    top: -5,
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.red,
                                    ),
                                  )
                              ]),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Card(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width / 6.5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                      child:Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Text(
                              "Catégories",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  ),
                            ),
                            
                          
                          Divider(thickness: 1,color: Colors.black,),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                              TextButton(
                                
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cat = 1;
                                  });
                                },
                                child:  Text("Boissons",
                                    style: TextStyle(
                                        fontSize: 18, 
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                               
                               SizedBox(
                                height: 25,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cat = 3;
                                  });
                                },
                                child: const Text("Plats",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cat = 2;
                                  });
                                },
                                child: const Text("Viennoiserie",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cat = 6;
                                  });
                                },
                                child: const Text("Cafés",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cat = 6;
                                  });
                                },
                                child: const Text("Cafés",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cat = 6;
                                  });
                                },
                                child: const Text("Cafés",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              
                              const SizedBox(
                                height: 25,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cat = 4;
                                  });
                                },
                                child: const Text("Chicha",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              ],),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32,),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 2),
                    child: Container(
                      
                      width: MediaQuery.of(context).size.width / 6.5,
                      height: MediaQuery.of(context).size.height / 2.1,
                      padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                      child: Column(
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            enabled: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              labelText: "0.000 DT",
                              
                    
                              labelStyle: TextStyle(
                                
                                  color: Colors.black,
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
                                color: Colors.white,
                                size: 60,
                                controller: controller,
                              ),
                              NumberButton(
                                number: 8,
                                color: Colors.white,
                                size: 60,
                                controller: controller,
                              ),
                              NumberButton(
                                number: 9,
                                color: Colors.white,
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
                                color: Colors.white,
                                size: 60,
                                controller: controller,
                              ),
                              NumberButton(
                                number: 5,
                                color: Colors.white,
                                size: 60,
                                controller: controller,
                              ),
                              NumberButton(
                                number: 6,
                                color: Colors.white,
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
                                color: Colors.white,
                                size: 60,
                                controller: controller,
                              ),
                              NumberButton(
                                number: 2,
                                color: Colors.white,
                                size: 60,
                                controller: controller,
                              ),
                              NumberButton(
                                number: 3,
                                color: Colors.white,
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
                                color: Colors.white,
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
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(left: 15, bottom: 18),
            child: Card(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              child: Container(
                
                width: MediaQuery.of(context).size.width / 2,
                
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  primary: false,
                  padding: const EdgeInsets.fromLTRB(35 , 35, 35, 35),
                  children: <Widget>[
                    for (var i = 0; i < listeProduits.length; i++)
                    if(listeProduits[i].categorie == cat)
                      FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            
                                    decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                            
                                SizedBox(
                                  height: MediaQuery.of(context).size.height /8,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius:  BorderRadius.all(Radius.circular(1)),
                                        
                                    child: 
                                      FittedBox(
                                        child: Image.asset("${listeProduits[i].image}"),
                                        fit: BoxFit.cover,
                                      ),
                                      
                                      //height: MediaQuery.of(context).size.height / 3,
                                      
                                    
                                    
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only( top:15),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Center(
                                      child: Text(
                                        "${listeProduits[i].nom}",
                                        style:  TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(                                    "${listeProduits[i].prix}00DT",
            style:TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        back: Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: bgColor,
                                            fixedSize: const Size(40, 40),
                                            shape: CircleBorder(),
                                            side: BorderSide(
                                              color: bgColor,
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
                                          style: TextStyle(fontSize: 35,color: bgColor)),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: bgColor,
                                            fixedSize: const Size(40, 40),
                                            shape:  CircleBorder(),
                                            side: BorderSide(
                                              color: bgColor,
                                            )),
                                        onPressed: () {
                                          setState(() {
                                            listeProduits[i].quantite =
                                                listeProduits[i].quantite! + 1;
                                          });
                                        },
                                        child:  Icon(Icons.add,color: Colors.white,),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: bgColor,
                                      fixedSize: const Size(200, 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2)),
                                      side: BorderSide(
                                        color: bgColor,
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
                                    child: const Text("Ajouter au panier",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      width: MediaQuery.of(context).size.width / 3.9,
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                      child: Column(
                        children: [
                          
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 60,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Table",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                    
                          ),
                          
                          Divider(
                            thickness: 2,
                            color: Colors.grey[500],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "#$selectedTable",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 120,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.75,
                            child: DataTable2(
                              columnSpacing: 10,
                              columns:  [
                                DataColumn2(
                                                size: ColumnSize.L,
                    
                                  label: Center(
                                    child: Text(
                                      "Article",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                  
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn2(
                                  size: ColumnSize.L,
                                  numeric: true,
                                  label: Center(
                                    child: Text(
                                      "Quantité",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn2(
                                  label: Center(
                                    child: Text(
                                      "Montant",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                  
                                      ),
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
                                        Center(
                                          child: Text(
                                            "${listePanier[selectedTable]!.elementAt(i).nomProd}",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            "${listePanier[selectedTable]!.elementAt(i).quantiteProd}",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            "${listePanier[selectedTable]!.elementAt(i).prixProd}00 DT",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                            ),
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
                            color: Colors.black,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Text(
                                "Montant total :",
                               style: TextStyle(color: Colors.black,fontSize: 20),),
                    
                    
                              
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                              Text(getTotal().toStringAsFixed(3) + " DT",
                                  style: TextStyle(fontFamily: 'Digital',fontSize: 35,color: Colors.black)),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          
                          Row(
                            children: [
                              Align(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary:bgColor,
                                    fixedSize: const Size(200, 60),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  onPressed: () async {
                                   await imprimerCommande();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PreviewPDF()
                                      ),
                                    );                      
                    
                                  },
                                  child:  Center(
                                    child: Text("Passer la commande",textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 18,)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 30,
                              ),
                              Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 10,
                                primary: const Color(0xFF09c569),
                                fixedSize: const Size(180, 60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Payer",
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Card(
                    color: Color.fromARGB(255, 250, 250, 250),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      
                        padding: const EdgeInsets.all(2.0),
                      width: MediaQuery.of(context).size.width / 3.9,
                        height: MediaQuery.of(context).size.height / 4.5,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 250, 250, 250),
                    ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: secondaryColor,
                                    fixedSize: const Size(140, 70),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  onPressed: () {
                  
                                  },
                                  child:  Row(
                                    children: [
                                     
                                        Icon(Icons.menu_open,
                                            size: 20, color: Colors.white),
                                            SizedBox(width: 5,),
                                     Text("Ouv. Tirroir",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                                
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: secondaryColor,
                                    fixedSize: const Size(140, 70),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child:  Row(
                                    children: [
                                     
                                        Icon(Icons.note,
                                            size: 20, color: Colors.white),
                                            SizedBox(width: 10,),
                                     Text("Notes",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: secondaryColor,
                                    fixedSize: const Size(140, 70),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child:  Row(
                                    children: [
                                     
                                        Icon(Icons.comment_bank_outlined,
                                            size: 20, color: Colors.white),
                                            SizedBox(width: 5,),
                                     Text("Chéques",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: secondaryColor,
                                    fixedSize: const Size(140, 70),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child:  Row(
                                    children: [
                                     
                                        Icon(Icons.note_alt,
                                            size: 20, color: Colors.white),
                                            SizedBox(width: 5,),
                                     Text("Tick. Resto",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: secondaryColor,
                                    fixedSize: const Size(140, 70),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child:  Row(
                                    children: [
                                     
                                        Icon(Icons.apple,
                                            size: 20, color: Colors.white),
                                            SizedBox(width: 5,),
                                     Text("Apple Pay",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    primary: secondaryColor,
                                    fixedSize: const Size(140, 70),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child:  Row(
                                    children: [
                                     
                                        Icon(Icons.phone_android,
                                            size: 20, color: Colors.white),
                                            SizedBox(width: 5,),
                                     Text(" Samsung \n Pay",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
              ),
               ),     ],
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
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
