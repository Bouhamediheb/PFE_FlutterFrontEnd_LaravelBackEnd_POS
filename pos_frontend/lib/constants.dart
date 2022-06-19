import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 235, 233, 233);
const bgColor = Color.fromARGB(255, 18, 21, 44);
const secondaryColor = Color.fromARGB(255, 26, 30, 68);

const defaultPadding = 16.0;

const snackBarSucces = SnackBar(
  content: Text('Tâche effectuée avec succès'),
);

const snackBarStockError = SnackBar(
  content: Text('Certains articles ont un stock insuffisant'),
);
const snackBarButtonError = SnackBar(
  content: Text('Impossible de passer un document est vide'),
);
