import 'package:admin/models/Raccourcis.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/RaccourcisRapides.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../fonctionalite/DocumentScreen/Screen/choixDct.dart';
import '../../fonctionalite/FournisseurScreen/Screen/ajouterunFrs.dart';
import '../../fonctionalite/ProduitScreen/Screen/ajouterunPrd.dart';
import '../../main/main_screen.dart';

class HeaderRaccourcis extends StatefulWidget {
  const HeaderRaccourcis({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderRaccourcis> createState() => _HeaderRaccourcisState();
}

class _HeaderRaccourcisState extends State<HeaderRaccourcis> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Raccourcis Rapides",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            PopupMenuButton(
                onSelected: (dynamic value) {
                  if (value == 1)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MainScreen(ajouterUnFournisseur())),
                    );
                  else if (value == 2)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(ajouterUnProduit())),
                    );
                  else if (value == 3)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(ChoixDocument())),
                    );
                },
                color: Color(0xFF2A2D3E),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40.0)),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_downward),
                      Text("Plus de Raccourcis"),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: Text("Ajouter un Fournisseur"), value: 1),
                      PopupMenuItem(
                          child: Text("Ajouter un Produit"), value: 2),
                      PopupMenuItem(
                          child: Text("Ajouter un Document"), value: 3),
                    ])
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listeRaccourcis.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          RaccourcisRapides(info: listeRaccourcis[index]),
    );
  }
}
