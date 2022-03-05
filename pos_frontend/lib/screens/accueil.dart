import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_frontend/screens/ajoutFournisseur.dart';

import '../components/topBar.dart';
import '../constants.dart';
class accueil extends StatefulWidget {



  @override
  State<accueil> createState() => _accueilState();
}

class _accueilState extends State<accueil> {
  @override

  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
          children: [
        Row(

          children: [
            Text('Menu Accueil',
              style: Theme.of(context).textTheme.headline6,),
            Spacer(flex: 3,),

            Expanded(
                child: searchField()
            ),
              ProfileCard(),
            ],
            ),


      ]
      ),



    ),
    );


  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.symmetric(horizontal: defaultPadding,vertical:defaultPadding/2 ),
      margin: EdgeInsets.only(left:defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white),
        color:secondaryColor,
      ),
      child: Row(
        children: [
          Image.asset('assets/images/profile_pic.png',height: 35),
          Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding/2),
          child:Text("Iheb Bouhamed",style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
