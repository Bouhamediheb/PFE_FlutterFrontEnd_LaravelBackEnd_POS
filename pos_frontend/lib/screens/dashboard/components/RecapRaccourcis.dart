import 'package:admin/models/Raccourcis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../main/TestScreen.dart';
import 'DernieresActivites.dart';
import 'EtatStock.dart';
import 'RaccourcisRapides.dart';
import '../components/header_Raccourcis.dart';

class RecapMonetiquesRacc extends StatefulWidget {
  final Raccourcis info;
  const RecapMonetiquesRacc({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<RecapMonetiquesRacc> createState() => _RecapMonetiquesRaccState();
}

class _RecapMonetiquesRaccState extends State<RecapMonetiquesRacc> {
  late Color valColor;

  @override
  void initState() {
    super.initState();
    if (widget.info.value! <= 0) {
      setState(() {
        valColor = Colors.red;
      });
    } else {
      setState(() {
        valColor = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.space,

        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // add an  icon from Icon Widget
                Icon(
                  widget.info.ico,
                  color: Colors.white,
                  size: 35.0,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.info.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 17)),
                SizedBox(height: defaultPadding / 2),
                Text(widget.info.value!.toString() + " TND",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



/*

*/