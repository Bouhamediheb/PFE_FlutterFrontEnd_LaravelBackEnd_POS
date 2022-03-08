import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../HomeScreen.dart';
import '../constants.dart';
import '../constants.dart';
import '../screens/ajoutDocument.dart';
import '../screens/ajoutFournisseur.dart';
class side_menu_mobile extends StatefulWidget {

  @override
  State<side_menu_mobile> createState() => _side_menu_mobileState();
}

class _side_menu_mobileState extends State<side_menu_mobile> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(

              currentAccountPicture: CircleAvatar(
                backgroundColor: primaryColor,
                child: Text(
                  "IB",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              accountName: Text("Bouhamed Iheb"),
              accountEmail: Text("Test@Test.com"),
            ),
      DrawerListTileMobile(title:"Accueil",svgSrc: "assets/icons/menu_dashbord.svg",subTitle1: 'SubMenu-Accueil 1',subTitle2:'SubMenu-Accueil 1',subTitle3: 'SubMenu-Accueil 1',
        press1:() {
          // TODO: Submenu1 mte3 accueil chnou bech y7el f espace eli b janb menu
        },
        press2:() {
          // TODO: Submenu2 mte3 accueil chnou bech y7el f espace eli b janb menu

        },
        press3:() {
          // TODO: Submenu3 mte3 accueil chnou bech y7el f espace eli b janb menu

        },
      ),
            DrawerListTileMobile(title:"Documents",svgSrc: "assets/icons/menu_doc.svg",subTitle1: 'Liste Des Documents',subTitle2:'Ajouter Un Document',subTitle3: 'Supprimer Un Document',
              press1:() {
                // TODO : Widget mte3 fetch all documents
              },
              press2:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen((ajoutDocument()))));
              },
              press3:() {

              },
            ),
            DrawerListTileMobile(title:"Fournisseurs",svgSrc: "assets/icons/menu_supplier.svg",subTitle1: 'Liste Des Fournisseurs',subTitle2:'Ajouter Un Fournisseur',subTitle3: 'Supprimer Un Fournisseur',
              press1:() {
                //TODO: Widget mte3 fetch all fournisseurs
              },
              press2:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen((ajoutFournisseur()))));
              },
              press3:() {
              },
            ),
            DrawerListTileMobile(title:"Boutiques",svgSrc: "assets/icons/menu_store.svg",subTitle1: 'Liste Des Boutiques(Filiales)',subTitle2:'Ajouter Une Boutique',subTitle3: 'Supprimer Une Boutique',
              press1:() {
              },
              press2:() {
              },
              press3:() {
              },
            ),
            DrawerListTileMobile(title:"Notifications",svgSrc: "assets/icons/menu_notification.svg",subTitle1: 'Notifications de la Centrale',subTitle2:'Notifications Personelles',subTitle3: 'Notifications Application',
              press1:() {
              },
              press2:() {
              },
              press3:() {
              },
            ),
            DrawerListTileMobile(title:"Taches",svgSrc: "assets/icons/menu_task.svg",subTitle1: 'xxxxx',subTitle2:'xxxxx',subTitle3: 'xxxxx',
              press1:() {
              },
              press2:() {
              },
              press3:() {
              },
            ),
            DrawerListTileMobile(title:"Parametres",svgSrc: "assets/icons/menu_setting.svg",subTitle1: 'xxxxx',subTitle2:'xxxxx',subTitle3: 'xxxxx',
              press1:() {
              },
              press2:() {
              },
              press3:() {
              },
            ),

          ],
        ),
    );
  }
}

class DrawerListTileMobile extends StatelessWidget {
  const DrawerListTileMobile({
    Key key, @required this.title,@required this.svgSrc,@required this.press1,@required this.press2,@required this.press3,@required this.subTitle1,@required this.subTitle2,@required this.subTitle3
  }) : super(key: key);
  final String title,svgSrc,subTitle1,subTitle2,subTitle3;
  final VoidCallback press1,press2,press3;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black,
        height:15,
      ),
      title: Text(title),
      children: [
          ListTile(
            contentPadding: EdgeInsets.only(left:30),
            onTap: press1,
            horizontalTitleGap: 0.0,
            leading: Icon(Icons.arrow_right_rounded,color:Colors.black),
            title:Text(
              subTitle1,
              style: TextStyle(color: Colors.black,
                  fontSize: 15),
            ),

          ),
        ListTile(
          contentPadding: EdgeInsets.only(left:30),
          onTap: press2,
          horizontalTitleGap: 0.0,
          leading: Icon(Icons.arrow_right_rounded,color:Colors.black),
          title:Text(
            subTitle2,
            style: TextStyle(color: Colors.black,
                fontSize: 15),
          ),

        ),
        ListTile(
          contentPadding: EdgeInsets.only(left:30),
          onTap: press3,
          horizontalTitleGap: 0.0,
          leading: Icon(Icons.arrow_right_rounded,color:Colors.black),
          title:Text(
            subTitle3,
            style: TextStyle(color: Colors.black,
                fontSize: 15),
          ),

        ),
      ]
    );
  }
}
