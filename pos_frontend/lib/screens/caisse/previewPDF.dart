import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class PreviewPDF extends StatefulWidget {
  PreviewPDF({Key? key}) : super(key: key);

  @override
  State<PreviewPDF> createState() => _PreviewPDFState();
}

class _PreviewPDFState extends State<PreviewPDF> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: SfPdfViewer.file(
              File('lib/Commande.pdf')));
}
}