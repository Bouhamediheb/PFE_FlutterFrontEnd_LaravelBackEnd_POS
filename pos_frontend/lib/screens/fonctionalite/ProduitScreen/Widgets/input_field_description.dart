// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class InputFieldDescription extends StatelessWidget {
  final String? label, label2;
  final String? content, content2;
  TextEditingController? fieldController = TextEditingController();
  FormFieldValidator<String>? fieldValidator = (_) {
    return null;
  };
  InputFieldDescription(
      {this.label,
      this.content,
      this.label2,
      this.content2,
      this.fieldValidator,
      this.fieldController});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 50.0,
              child: Text(
                "$label",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
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
                maxLines: 8,
                minLines: 8,
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
        ],
      );
    });
  }
}
