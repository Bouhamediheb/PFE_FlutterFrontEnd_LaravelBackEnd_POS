import 'package:admin/constants.dart';
import 'package:admin/screens/main/TestScreen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class Raccourcis {
  final String imgSrc, title;
  // final Function() onTapAction; // replace Function() with VoidCallback?

  Raccourcis({this.imgSrc, this.title, info});
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
    title: "Bon de livraison",
    imgSrc: "assets/images/livraison.png",
  ),
  Raccourcis(
    title: "Bon de livraison",
    imgSrc: "assets/images/livraison.png",
  ),
];
