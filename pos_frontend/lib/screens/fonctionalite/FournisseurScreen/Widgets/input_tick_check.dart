// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';

class InputFieldCheckTick extends StatefulWidget {
  double timbreFiscaleFournisseur = 0.000;
  bool exoTVA = false;

  @override
  State<InputFieldCheckTick> createState() => _InputFieldCheckTickState();
}

class _InputFieldCheckTickState extends State<InputFieldCheckTick> {
 late bool? _exoTVA;
  double? _timbreFiscaleFournisseur;
  bool isSwitched = false;
  bool? isTicked = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: const SizedBox(
                width: 50.0,
                child: Text(
                  "Timbre Fiscale",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              trailing: Switch(
                  activeColor: const Color.fromARGB(255, 41, 17, 173),
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      if (isSwitched == false) {
                        widget.timbreFiscaleFournisseur = 0.000;
                      } else {
                        widget.timbreFiscaleFournisseur = 0.600;
                      }
                    });
                  }),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Padding(
                padding: EdgeInsets.only(left: 1),
                child: SizedBox(
                  width: 40.0,
                  child: Text(
                    "Exonération TVA",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              trailing: Checkbox(
                  activeColor: const Color.fromARGB(255, 41, 17, 173),
                  value: isTicked,
                  onChanged: (value) async {
                    setState(() {
                      isTicked = value;
                      if (isTicked == false) {
                        widget.exoTVA = false;
                      } else {
                        widget.exoTVA = true;
                      }
                    });
                  }),
            ),
          ),
        ],
      );
    });
  }
}
