import 'package:admin/models/DernieresActions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  void initState() {
    super.initState();
    fetchDocuments();
  }

  fetchDocuments() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/document'),
      headers: <String, String>{
        'Cache-Control': 'no-cache',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        documents = jsonDecode(response.body);
        print(documents.length);
      });
    } else {
      throw Exception('Error!');
    }
  }

  List documents = [];
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
                    label: Text("Numéro Document"),
                  ),
                  DataColumn(
                    label: Text("Date de l'activité"),
                  ),
                  DataColumn(
                    label: Text("Montant Total"),
                  ),
                ],
                rows: <DataRow>[
                  for (var i = documents.length - 1;
                      i >= documents.length - 9;
                      i--)
                    DataRow(cells: <DataCell>[
                      DataCell(
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/unknown.svg",
                              height: 30,
                              width: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              child: Text(documents[i]['numDoc']),
                            ),
                          ],
                        ),
                      ),
                      DataCell(Text(documents[i]['dateDoc'].toString())),
                      DataCell(Text(documents[i]['totalDoc'].toString())),
                    ])
                ]),
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
