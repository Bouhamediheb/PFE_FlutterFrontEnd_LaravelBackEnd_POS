import 'package:admin/models/Raccourcis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../main/TestScreen.dart';
import 'DernieresActivites.dart';
import 'EmptySpace.dart';
import 'RaccourcisRapides.dart';
import '../components/header_Raccourcis.dart';

class RecapMonetiquesRacc extends StatefulWidget {
  final Raccourcis info;
  final Color valColor=Colors.white;
  const RecapMonetiquesRacc({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  State<RecapMonetiquesRacc> createState() => _RecapMonetiquesRaccState();
}



class _RecapMonetiquesRaccState extends State<RecapMonetiquesRacc> {
@override
  initState({
  if(widget.info.value!<=0){
    setState(() {
      valColor = Colors.red;
    });
    else{
      setState(() {
        valColor = Colors.green;
      });
    }
  }
})

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 100,
                  
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(widget.info.value!.toString()+" DT",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 35)),  
                ),
              ],
            ),
            Text(widget.info.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17)),
              
          ],
        ),
      ),
    );
  }
}
