import 'package:flutter/material.dart';
import '../Widgets/input_field.dart';

class InputFieldCheckTick extends StatefulWidget {
  double timbreFiscaleFournisseur = 0.000;
  bool exoTVA = false;

  @override
  State<InputFieldCheckTick> createState() => _InputFieldCheckTickState();
}

class _InputFieldCheckTickState extends State<InputFieldCheckTick> {
  bool _exoTVA;
  double _timbreFiscaleFournisseur;
  bool isSwitched = false;
  bool isTicked = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Container(
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
                  activeColor: Color.fromARGB(255, 41, 17, 173),
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
              title: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Container(
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
                  activeColor: Color.fromARGB(255, 41, 17, 173),
                  value: isTicked,
                  onChanged: (value) async {
                    await setState(() {
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
