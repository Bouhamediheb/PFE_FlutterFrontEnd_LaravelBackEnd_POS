import 'package:admin/models/Raccourcis.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/RaccourcisRapides.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../fonctionalite/DocumentScreen/Screen/choixDct.dart';
import '../../fonctionalite/FournisseurScreen/Screen/ajouterunFrs.dart';
import '../../fonctionalite/ProduitScreen/Screen/ajouterunPrd.dart';
import '../../main/main_screen.dart';
import 'RecapRaccourcis.dart';

class RecapMonetiques extends StatefulWidget {
  const RecapMonetiques({
    Key? key,
  }) : super(key: key);

  @override
  State<RecapMonetiques> createState() => _RecapMonetiquesState();
}

class _RecapMonetiquesState extends State<RecapMonetiques> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 2,
          ),
        ),
        
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 3,
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
          RecapMonetiquesRacc(info: listeRaccourcisMonetiques[index]),
    );
  }
}
