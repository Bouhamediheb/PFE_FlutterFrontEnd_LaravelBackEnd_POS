import 'package:admin/models/Raccourcis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../main/TestScreen.dart';
import 'DernieresActivites.dart';
import 'EmptySpace.dart';
import 'RaccourcisRapides.dart';
import '../components/header_Raccourcis.dart';

class RaccourcisRapides extends StatefulWidget {
  final Raccourcis info;
  const RaccourcisRapides({
    Key key,
    @required this.info,
  }) : super(key: key);

  @override
  State<RaccourcisRapides> createState() => _RaccourcisRapidesState();
}

class _RaccourcisRapidesState extends State<RaccourcisRapides> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset(
                    widget.info.imgSrc,
                  ),
                ),
              ],
            ),
            Text(
              widget.info.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
