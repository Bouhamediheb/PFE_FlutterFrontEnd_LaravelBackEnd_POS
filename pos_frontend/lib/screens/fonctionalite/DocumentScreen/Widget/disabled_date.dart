// ignore_for_file: camel_case_types, missing_return

import 'package:flutter/material.dart';

class DisabledCurrentDate extends StatefulWidget {
  final String? label;
  final String? content;
  String? dropDownValue;

  DisabledCurrentDate({
    this.label,
    this.content,
    this.dropDownValue,
  });

  @override
  State<DisabledCurrentDate> createState() => _DisabledCurrentDateState();
}

class _DisabledCurrentDateState extends State<DisabledCurrentDate> {
  var fieldController = TextEditingController();
  final dateDocument = TextEditingController();

  FormFieldValidator<String> fieldValidator = (_) {};
  String DateNow = new DateTime.now().toString().substring(0, 19);
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1950, 1),
      lastDate: DateTime(2030, 12),
      helpText: "",
      cancelText: "Annuler",
      confirmText: "Confirmer",
      builder: (BuildContext context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

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
              child: TextFormField(
                controller: dateDocument,
                enabled: false,
                decoration: InputDecoration(
                  labelText: '${currentDate.toString().substring(0, 19)}',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      fontSize: 14),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.shade400)),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
