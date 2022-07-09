// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Raccourcis {
  final String? imgSrc, title;
  final IconData? ico;
  final double? value;

  Raccourcis({this.imgSrc, this.title, this.ico, this.value, info});
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
    ico: Icons.attach_money,
    title: "Solde",
    imgSrc: "assets/images/commande.png",
    value: 3500,
  ),
  Raccourcis(
    ico: Icons.receipt,
    title: "Montant des chéques payés",
    imgSrc: "assets/images/livraison.png",
    value: 5000,
  ),
  Raccourcis(
    ico: Icons.insert_page_break,
    title: "Montant des chéques impayés",
    imgSrc: "assets/images/livraison.png",
    value: 1200,
  ),
];

List listeRaccourcisEtat = [
  Raccourcis(
    ico: Icons.factory,
    title: "Bons de commandes",
    imgSrc: "assets/images/commande.png",
    value: 5,
  ),
  Raccourcis(
    ico: Icons.production_quantity_limits,
    title: "Bons de sorties",
    imgSrc: "assets/images/livraison.png",
    value: 15,
  ),
  Raccourcis(
    ico: Icons.document_scanner,
    title: "Commandes caisse traitées ",
    imgSrc: "assets/images/livraison.png",
    value: 15,
  ),
];
