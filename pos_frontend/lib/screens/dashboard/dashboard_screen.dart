import 'package:projetpfe/responsive.dart';
import 'package:projetpfe/screens/dashboard/components/LineChartSample2.dart';
import 'package:projetpfe/screens/dashboard/components/RecapEtat.dart';
import 'package:projetpfe/screens/dashboard/components/RecapMonetiques.dart';
import 'package:flutter/material.dart';
import 'package:projetpfe/screens/dashboard/components/LineChartSample1.dart';
import '../../constants.dart';
import 'components/Raccourcis.dart';
import 'components/header.dart';
import 'components/EtatStock.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      RecapMonetiques(),
                      SizedBox(height: defaultPadding),
                      //HeaderRaccourcis(),
                      RecapEtat(),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Evolution du chiffre d'affaires",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      LineChartSample2(),
                      SizedBox(height: defaultPadding),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Récapitulatif du flux monétaire",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      LineChartSample1(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) EtatStock(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        EtatStock(),
                        SizedBox(height: 20),
                        ListeRaccourcis()
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
