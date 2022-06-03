// ignore_for_file: camel_case_types, missing_return

import 'package:flutter/material.dart';

class inputDocType extends StatefulWidget {
  final String? label;
  final String? content;
  String? dropDownValue;

  inputDocType({
    this.label,
    this.content,
    this.dropDownValue,
  });

  @override
  State<inputDocType> createState() => _inputDocTypeState();
}

class _inputDocTypeState extends State<inputDocType> {
  var fieldController = TextEditingController();

  FormFieldValidator<String> fieldValidator = (_) {};

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: 50.0,
                child: Text(
                  "${widget.label}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              flex: 3,
              child: DropdownButton(
                hint: "${widget.dropDownValue}" == null
                    ? Text('Type de document')
                    : Text(
                        "${widget.dropDownValue}",
                        style: TextStyle(color: Colors.blue),
                      ),
                isExpanded: true,
                style: TextStyle(color: Colors.blue),
                items: [
                  'Bon de Commande',
                  'Bon de Livraison',
                  'Ticket',
                ].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (dynamic val) {
                  setState(
                    () {
                      widget.dropDownValue = val;
                    },
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
