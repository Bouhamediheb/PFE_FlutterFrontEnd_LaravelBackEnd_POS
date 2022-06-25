// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String? label, label2;
  final RegExp? whattoAllow;

  final String? content, content2;
  TextEditingController? fieldController = TextEditingController();
  FormFieldValidator<String>? fieldValidator = (_) {
    return null;
  };
  InputField(
      {this.label,
      this.label2,
      this.content,
      this.content2,
      this.fieldValidator,
      this.fieldController,
      this.whattoAllow});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 50,
              child: Text(
                '$label',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 15),
              ),
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: MediaQuery.of(context).size.width / 3.7,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: TextFormField(
                controller: fieldController,
                validator: fieldValidator,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(whattoAllow!),
                ],
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
        ],
      );
    });
  }
}
