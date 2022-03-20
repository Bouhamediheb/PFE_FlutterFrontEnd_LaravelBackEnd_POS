import 'package:admin/models/DernieresActions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class DernieresActivites extends StatefulWidget {
  const DernieresActivites({
    Key key,
  }) : super(key: key);

  @override
  State<DernieresActivites> createState() => _DernieresActivitesState();
}

class _DernieresActivitesState extends State<DernieresActivites> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Les dernières activités",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("Nom de l'activité"),
                ),
                DataColumn(
                  label: Text("Date de l'activité"),
                ),
                DataColumn(
                  label: Text("Achêvé par "),
                ),
              ],
              rows: List.generate(
                DernieresActions.length,
                (index) => recentFileDataRow(DernieresActions[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(DerniereAction fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.nomActivite),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date)),
      DataCell(Text(fileInfo.nomPersonne)),
    ],
  );
}
