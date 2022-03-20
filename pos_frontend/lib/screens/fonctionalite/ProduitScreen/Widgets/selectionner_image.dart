import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class SelectionnerImage extends StatefulWidget {
  @override
  State<SelectionnerImage> createState() => _SelectionnerImageState();
}

class _SelectionnerImageState extends State<SelectionnerImage> {
  File uploadimage;

  Future<void> chooseImage() async {
    final ImagePicker picker = ImagePicker();
    var choosedimage = await picker.pickImage(source: ImageSource.gallery);
    final File convertimage = File(choosedimage.path);
    setState(() {
      uploadimage = convertimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: [
          Text(
            "Séléctionnez une Image",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          SizedBox(width: 25),
          Container(
            child: OutlinedButton(
              onPressed: () {
                chooseImage();
              },
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      );
    });
  }
}
