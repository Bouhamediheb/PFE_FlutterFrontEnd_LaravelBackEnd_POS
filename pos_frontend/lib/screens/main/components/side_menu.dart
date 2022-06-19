import 'package:projetpfe/constants.dart';
import 'package:projetpfe/screens/fonctionalite/DocumentScreen/Screen/choixDct.dart';
import 'package:projetpfe/screens/fonctionalite/ProduitScreen/Screen/listedesPrd.dart';
import 'package:projetpfe/screens/fonctionalite/UserRightsScreen/listedesUtilisateurs.dart';
import 'package:projetpfe/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../dashboard/dashboard_screen.dart';
import '../../fonctionalite/DocumentScreen/Screen/listedesDct.dart';
import '../../fonctionalite/FournisseurScreen/Screen/ajouterunFrs.dart';
import '../../fonctionalite/FournisseurScreen/Screen/listedesFrs.dart';
import '../../fonctionalite/ProduitScreen/Screen/ajouterunPrd.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                "assets/images/logo2.png",
                color: Colors.white,
              ),
            ),
            MaterialButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(DashboardScreen())),
                );
              },
              child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/menu_dashbord.svg",
                    color: const Color.fromARGB(255, 255, 255, 255),
                    height: 16,
                  ),
                  title: const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: const Text("")),
            ),
            DrawerListTile(
              title: "Documents",
              svgSrc: "assets/icons/menu_doc.svg",
              subTitle1: 'Ajouter Un Document',
              subTitle2: 'Liste Des Documents',
              press1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(const ChoixDocument())),
                );
              },
              press2: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(listeDocument())),
                );
              },
            ),
            DrawerListTile(
              title: "Fournisseurs",
              svgSrc: "assets/icons/menu_tran.svg",
              subTitle1: 'Ajouter Un Fournisseur',
              subTitle2: 'Liste Des Fournisseurs',
              press1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(ajouterUnFournisseur())),
                );
              },
              press2: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(listeFournisseur())),
                );
              },
            ),
            DrawerListTile(
              title: "Produits",
              svgSrc: "assets/icons/menu_doc.svg",
              subTitle1: 'Liste des produits',
              subTitle2: 'Ajouter un produit',
              press1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(listeProduit())),
                );
              },
              press2: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(const ajouterUnProduit())),
                );
              },
            ),
            DrawerListTile(
              title: "Parametres",
              svgSrc: "assets/icons/menu_setting.svg",
              subTitle1: 'Gestion des droits des utilisateurs',
              subTitle2: 'Parametres du compte',
              subTitle3: 'Se Déconnecter',
              press1: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(listeUtlisateurs())),
                );
              },
              press2: () {},
              press3: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      this.title,
      this.svgSrc,
      this.press1,
      this.press2,
      this.press3,
      this.subTitle1,
      this.subTitle2,
      this.subTitle3})
      : super(key: key);

  final String? title, svgSrc, subTitle1, subTitle2, subTitle3;
  final VoidCallback? press1, press2, press3;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: SvgPicture.asset(
        svgSrc!,
        color: const Color.fromARGB(255, 255, 255, 255),
        height: 16,
      ),
      title: Text(
        title!,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          onTap: press1,
          horizontalTitleGap: 0.0,
          leading: const Icon(Icons.arrow_right_rounded,
              color: Color.fromARGB(255, 255, 255, 255)),
          title: Text(
            subTitle1!,
            style: const TextStyle(
                color: Color.fromARGB(255, 197, 195, 195), fontSize: 13),
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 30),
          onTap: press2,
          horizontalTitleGap: 0.0,
          leading: const Icon(Icons.arrow_right_rounded,
              color: Color.fromARGB(255, 255, 255, 255)),
          title: Text(
            subTitle2!,
            style: const TextStyle(
                color: Color.fromARGB(255, 197, 195, 195), fontSize: 13),
          ),
        ),
      ],
    );
  }
}
