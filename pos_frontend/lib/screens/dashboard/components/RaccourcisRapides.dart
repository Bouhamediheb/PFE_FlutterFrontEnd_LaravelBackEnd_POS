// ignore_for_file: file_names

import 'package:admin/models/raccourcis.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../main/TestScreen.dart';

class RaccourcisRapides extends StatefulWidget {
  final Raccourcis info;
  const RaccourcisRapides({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<RaccourcisRapides> createState() => _RaccourcisRapidesState();
}

class _RaccourcisRapidesState extends State<RaccourcisRapides> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Test()),
            
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset(
                    widget.info.imgSrc!,
                  ),
                ),
              ],
            ),
            Text(widget.info.title!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14)),
                
          ],
        ),
      ),
    );
  }
}
