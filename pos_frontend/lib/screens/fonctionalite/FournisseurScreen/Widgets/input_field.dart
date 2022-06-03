import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? label, label2;
  final String? content, content2;
  TextEditingController? fieldController = TextEditingController();
  FormFieldValidator<String>? fieldValidator = (_) {};
  InputField(
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
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: 50.0,
                child: Text(
                  "$label",
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
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                color: Color.fromARGB(255, 255, 255, 255),
                child: TextFormField(
                  controller: fieldController,
                  validator: fieldValidator,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "$content",
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 190, 190, 190),
                        fontSize: 14),
                    fillColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
