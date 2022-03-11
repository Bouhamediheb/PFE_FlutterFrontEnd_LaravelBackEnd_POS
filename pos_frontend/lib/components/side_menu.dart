import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_frontend/HomeScreen.dart';
import 'package:pos_frontend/screens/ajoutDocument.dart';
import 'package:pos_frontend/screens/ajoutFournisseur.dart';
import 'package:pos_frontend/screens/listeFournisseur.dart';
import 'package:pos_frontend/screens/listeProduit.dart';
import '../screens/listeDocument.dart';
import '../screens/ajoutProduit.dart';
import '../screens/accueil.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            DrawerHeader(
              child: Image.asset("assets/images/logo2.png"),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 5,
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              subTitle1: 'SubMenu-Accueil 1',
              subTitle2: 'SubMenu-Accueil 1',
              subTitle3: 'SubMenu-Accueil 1',
              press1: () {
                // TODO: Submenu1 mte3 accueil chnou bech y7el f espace eli b janb menu
              },
              press2: () {
                // TODO: Submenu2 mte3 accueil chnou bech y7el f espace eli b janb menu
              },
              press3: () {
                // TODO: Submenu3 mte3 accueil chnou bech y7el f espace eli b janb menu
              },
            ),
            SizedBox(
              height: 5,
            ),
            DrawerListTile(
              title: "Documents",
              svgSrc: "assets/icons/menu_doc.svg",
              subTitle1: 'Liste Des Documents',
              subTitle2: 'Ajouter Un Document',
              subTitle3: 'Supprimer Un Document',
              press1: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen((listeDocument()))));
              },
              press2: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen((ajoutDocument()))));
              },
              press3: () {},
            ),
            SizedBox(
              height: 5,
            ),
            DrawerListTile(
              title: "Fournisseurs",
              svgSrc: "assets/icons/menu_supplier.svg",
              subTitle1: 'Liste Des Fournisseurs',
              subTitle2: 'Ajouter Un Fournisseur',
              subTitle3: '---------',
              press1: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen((listeFournisseur()))));
              },
              press2: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen((ajoutFournisseur()))));
              },
              press3: () {},
            ),
            SizedBox(
              height: 5,
            ),
            DrawerListTile(
              title: "Boutiques",
              svgSrc: "assets/icons/menu_store.svg",
              subTitle1: 'Liste Des Boutiques(Filiales)',
              subTitle2: 'Ajouter Une Boutique',
              subTitle3: 'Supprimer Une Boutique',
              press1: () {},
              press2: () {},
              press3: () {},
            ),
            SizedBox(
              height: 5,
            ),
            DrawerListTile(
              title: "Produits",
              svgSrc: "assets/icons/menu_doc.svg",
              subTitle1: 'Liste des produits',
              subTitle2: 'Ajouter un produit',
              subTitle3: '-----------',
              press1: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen((listeProduit()))));
              },
              press2: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen((ajoutProduit()))));
              },
              press3: () {},
            ),
            SizedBox(
              height: 5,
            ),
            DrawerListTile(
              title: "Taches",
              svgSrc: "assets/icons/menu_task.svg",
              subTitle1: 'xxxxx',
              subTitle2: 'xxxxx',
              subTitle3: 'xxxxx',
              press1: () {},
              press2: () {},
              press3: () {},
            ),
            SizedBox(
              height: 5,
            ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/icons/menu_profile.svg",
              subTitle1: 'xxxxx',
              subTitle2: 'xxxxx',
              subTitle3: 'xxxxx',
              press1: () {},
              press2: () {},
              press3: () {},
            ),
            SizedBox(
              height: 5,
            ),
            DrawerListTile(
              title: "Parametres",
              svgSrc: "assets/icons/menu_setting.svg",
              subTitle1: 'Informations Générales',
              subTitle2: 'Parametres du compte',
              subTitle3: 'Se Déconnecter',
              press1: () {},
              press2: () {},
              press3: () {},
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key key,
      @required this.title,
      @required this.svgSrc,
      @required this.press1,
      @required this.press2,
      @required this.press3,
      @required this.subTitle1,
      @required this.subTitle2,
      @required this.subTitle3})
      : super(key: key);

  final String title, svgSrc, subTitle1, subTitle2, subTitle3;
  final VoidCallback press1, press2, press3;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black,
        height: 16,
      ),
      title: Text(title),
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: 30),
          onTap: press1,
          horizontalTitleGap: 0.0,
          leading: Icon(Icons.arrow_right_rounded, color: Colors.black),
          title: Text(
            subTitle1,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 30),
          onTap: press2,
          horizontalTitleGap: 0.0,
          leading: Icon(Icons.arrow_right_rounded, color: Colors.black),
          title: Text(
            subTitle2,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 30),
          onTap: press3,
          horizontalTitleGap: 0.0,
          leading: Icon(Icons.arrow_right_rounded, color: Colors.black),
          title: Text(
            subTitle3,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
