import 'package:admin/constants.dart';
import 'package:admin/screens/main/TestScreen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class Raccourcis {
  final String? imgSrc, title;
  final double? value;
  // final Function() onTapAction; // replace Function() with VoidCallback?

  Raccourcis({this.imgSrc, this.title,this.value, info});
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
    title: "Bon de retour",
    imgSrc: "assets/images/livraison.png",
  ),
  Raccourcis(
    title: "Liste des documents",
    imgSrc: "assets/images/ticket.png",
  ),
 
];

List listeRaccourcisMonetiques = [
  Raccourcis(
    title: "Solde",
    imgSrc: "assets/images/commande.png",
    value: 3500
  ),
  Raccourcis(
    title: "Chéques Payés",
    imgSrc: "assets/images/livraison.png",
    value: 5000
  ),
  Raccourcis(
    title: "Chéques Impayés",
    imgSrc: "assets/images/livraison.png",
    value: 1200
  ),
  
];