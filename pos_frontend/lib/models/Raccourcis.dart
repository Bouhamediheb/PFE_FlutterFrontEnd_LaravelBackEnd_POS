import 'package:admin/constants.dart';
import 'package:admin/screens/main/TestScreen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class Raccourcis {
  final String? imgSrc, title;
  final IconData? ico;
  final double? value;

  Raccourcis({this.imgSrc, this.title,this.ico,this.value, info});
}


List listeRaccourcis = [
  Raccourcis(
    title: "Bon de commande",
    imgSrc: "assets/images/commande.png",
  ),
  Raccourcis(
    title: "Bon de livraison",
    imgSrc: "assets/images/livraison.png",
  ),
  
  Raccourcis(
    title: "Liste des documents",
    imgSrc: "assets/images/ticket.png",
  ),
 
];

List listeRaccourcisMonetiques = [
  Raccourcis(
    ico:Icons.attach_money,
    title: "Solde",
    imgSrc: "assets/images/commande.png",
    value: 3500
  ),
  Raccourcis(
    ico: Icons.receipt,
    title: "Montant des chéques payés",
    imgSrc: "assets/images/livraison.png",
    value: 5000
  ),
  Raccourcis(
    ico: Icons.insert_page_break,
    title: "Montant des chéques impayés",
    imgSrc: "assets/images/livraison.png",
    value: 1200
  ),
  

  
];

List listeRaccourcisEtat = [
  Raccourcis(
    ico:Icons.factory,
    title: "Nombre de fournisseurs",
    imgSrc: "assets/images/commande.png",
    value: 5
  ),
  Raccourcis(
    ico:Icons.production_quantity_limits,
    title: "Nombre de produits",
    imgSrc: "assets/images/livraison.png",
    value: 12
  ),
  Raccourcis(
    ico:Icons.document_scanner,
    title: "Nombre de documents",
    imgSrc: "assets/images/livraison.png",
    value: 120
  ),
  

  
];