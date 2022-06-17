// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'disabled_date.dart';

class SeqDoc extends StatelessWidget {
  final String? label, label2;
  final String? content;
  var fieldController = TextEditingController();

  FormFieldValidator<String> fieldValidator = (_) {
    return null;
  };
  SeqDoc({
    this.label,
    this.label2,
    this.content,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            child: Text(
              "$label",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: MediaQuery.of(context).size.width / 3.7,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: TextFormField(
              enabled: false,
              controller: fieldController,
              validator: fieldValidator,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintText: "$content",
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 190, 190, 190), fontSize: 14),
                fillColor: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(flex: 5, child: DisabledCurrentDate(label: 'Date')),
      ]);
    });
  }
}
