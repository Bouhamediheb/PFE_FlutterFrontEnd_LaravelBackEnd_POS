// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';

import 'disabled_date.dart';
import 'package:http/http.dart' as http;

class SeqDoc extends StatefulWidget {
  final int? typedoc;
  final String? label, label2, label3;
  final String? content;

  SeqDoc({
    this.typedoc,
    this.label,
    this.label2,
    this.label3,
    this.content,
  });

  @override
  State<SeqDoc> createState() => _SeqDocState();
}

class _SeqDocState extends State<SeqDoc> {
  List? frs = [];
  String? dropdownvalue;
  late List<String> itemss = [];

  @override
  void initState() {
    super.initState();
    fetchFours().whenComplete(() {
      setState(() {});
    });
  }

  fetchFours() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/fournisseur'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      var items = jsonDecode(response.body);
      setState(() {
        frs = items;
        for (var i = 0; i < frs!.length; i++) {
          itemss.add(frs![i]['raisonSociale']);
        }
        ;
        dropdownvalue = frs![0]['raisonSociale'];
      });
    } else {
      throw Exception('Error!');
    }
  }

  var fieldController = TextEditingController();

  FormFieldValidator<String> fieldValidator = (_) {
    return null;
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              "${widget.label}",
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
          flex: 2,
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
              hintText: "${widget.content}",
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(flex: 2, child: DisabledCurrentDate(label: 'Date')),
        if (widget.typedoc == 1 || widget.typedoc == 3)
          Expanded(
            flex: 1,
            child: Text(
              "${widget.label3}",
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        if (widget.typedoc == 1 || widget.typedoc == 3)
          Expanded(
            child: DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon

              //icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: itemss.map((String itemss) {
                return DropdownMenuItem(
                  value: itemss,
                  child: Text(itemss),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
      ]);
    });
  }
}
