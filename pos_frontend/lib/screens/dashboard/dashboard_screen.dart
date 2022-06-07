import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/LineChartSample2.dart';
import 'package:admin/screens/dashboard/components/RaccourcisRapides.dart';
import 'package:admin/screens/dashboard/components/RecapMonetiques.dart';
import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';

import '../../constants.dart';
import 'components/Raccourcis.dart';
import 'components/header.dart';
import 'components/header_Raccourcis.dart';
import 'components/DernieresActivites.dart';
import 'components/EtatStock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        HeaderRaccourcis(),
                        SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            Text(
                "Evolution du chiffre d'affaires",
                style: Theme.of(context).textTheme.subtitle1,
              ),
                          ],
                        ),
                        SizedBox(height: defaultPadding),
                        LineChartSample2(),
                        SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            Text(
                "Récapitulatif du flux monétaire",
                style: Theme.of(context).textTheme.subtitle1,
              ),
                          ],
                        ),
                        SizedBox(height: defaultPadding),
                        RecapMonetiques(),
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
      ),
    );
  }
}

