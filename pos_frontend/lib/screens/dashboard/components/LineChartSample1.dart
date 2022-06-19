// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable

import 'package:projetpfe/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _LineChart extends StatelessWidget {
  _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '5M TND';
        break;
      case 2:
        text = '7M TND';
        break;
      case 3:
        text = '10M TND';
        break;
      case 4:
        text = '12M TND';
        break;

      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('02/2022', style: style);
        break;
      case 3:
        text = const Text('03/2022', style: style);
        break;
      case 5:
        text = const Text('04/2022', style: style);
        break;
      case 7:
        text = const Text('05/2022', style: style);
        break;
      case 9:
        text = const Text('06/2022', style: style);
        break;
      case 11:
        text = const Text('07/2022', style: style);
        break;
      case 13:
        text = const Text('08/2022', style: style);
        break;

      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: true);

  List<FlSpot> F1 = [
    const FlSpot(1, 1),
    const FlSpot(3, 1.5),
    const FlSpot(5, 1.4),
    const FlSpot(7, 3.4),
    const FlSpot(9, 2),
    const FlSpot(11, 2.2),
    const FlSpot(13, 1),
  ];

  List<FlSpot> F2 = [
    const FlSpot(1, 2),
    const FlSpot(3, 1),
    const FlSpot(5, 2),
    const FlSpot(7, 4),
    const FlSpot(9, 1.5),
    const FlSpot(11, 2.3),
    const FlSpot(13, 2),
  ];

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: const Color(0xff4af699),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          F1[0],
          F1[1],
          F1[2],
          F1[3],
          F1[4],
          F1[5],
          F1[6],
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        color: const Color(0xffaa4cfc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: [
          //from F2[0] to F2[6]
          F2[0],
          F2[1],
          F2[2],
          F2[3],
          F2[4],
          F2[5],
          F2[6],
        ],
      );

  List<FlSpot> F3 = [
    const FlSpot(1, 4),
    const FlSpot(3, 1.5),
    const FlSpot(5, 2),
    const FlSpot(7, 1),
    const FlSpot(9, 4),
    const FlSpot(11, 1.2),
    const FlSpot(13, 1.9),
  ];

  List<FlSpot> F4 = [
    const FlSpot(1, 2),
    const FlSpot(3, 1),
    const FlSpot(5, 2.5),
    const FlSpot(7, 1),
    const FlSpot(9, 3.5),
    const FlSpot(11, 2),
    const FlSpot(13, 3),
  ];

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: false,
        color: const Color(0xff4af699),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          F3[0],
          F3[1],
          F3[2],
          F3[3],
          F3[4],
          F3[5],
          F3[6],
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: false,
        color: const Color(0xffaa4cfc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: [
          F4[0],
          F4[1],
          F4[2],
          F4[3],
          F4[4],
          F4[5],
          F4[6],
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              secondaryColor,
              secondaryColor,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.square,
                  color: Color(0xff4af699),
                  size: 35.0,
                ),
                const Text("Recettes"),
                const Icon(
                  Icons.square,
                  color: Color(0xffaa4cfc),
                  size: 35.0,
                ),
                const SizedBox(width: 10),
                const Text("Dépenses"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: isShowingMainData ? '2022' : '2021',
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          isShowingMainData = newValue == '2022';
                        });
                      },
                      items: <String>['2022', '2021']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 37,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                child: _LineChart(isShowingMainData: isShowingMainData),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
