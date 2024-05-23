import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:green_scene/presentation/chat.dart';
import 'package:green_scene/presentation/green_house.dart';
import 'package:green_scene/presentation/line_chart.dart';
import 'package:green_scene/resources/app_colors.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppColors _colors = AppColors();

  @override
  void initState() {
    // TODO: implement initState

     getTemp();
  }

  Future getTemp() async {
    DatabaseReference _testRef = FirebaseDatabase.instance.ref().child('temp');

    _testRef.onValue.listen((event) {
      setState(() {
        temp = double.parse(event.snapshot.value.toString());
        print(temp);
      });
    });
    final counterSnapshot = await _testRef.get();
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print(counterSnapshot.value);
  }

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    GreenHouse(),
    LineChartSample1(),
    Text(
      'Search',
    ),
    ChatGpt()
  ];
  late double temp;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        bottomNavigationBar: GNav(
            onTabChange: (value) => setState(() {
                  _selectedIndex = value;
                }),
            selectedIndex: _selectedIndex,
            rippleColor: Colors.transparent,
            // tab button ripple color when pressed
            hoverColor: Colors.transparent,
            // tab button hover color
            haptic: true,
            // haptic feedback
            tabBorderRadius: 25,
            curve: Curves.easeOutExpo,
            // tab animation curves
            duration: Duration(milliseconds: 100),
            // tab animation duration
            gap: 8,
            // the tab button gap between icon and text
            color: AppColors.green,
            // unselected icon color
            activeColor: AppColors.green,
            // selected icon and text color
            iconSize: 24,
            // tab button icon size
            tabMargin: EdgeInsets.all(10),
            tabBackgroundColor: AppColors.contentColorBlack,
            // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            // navigation bar padding
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'GreenHouse',
              ),
              GButton(
                icon: Icons.analytics_outlined,
                text: 'analytics',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chat',
              )
            ]),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 23,
        maxY: 1000,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 23,
        maxY: 1000,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.borderColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 100:
        text = '100';
        break;
      case 200:
        text = '200';
        break;
      case 300:
        text = '300';
        break;
      case 400:
        text = '400';
        break;
      case 500:
        text = '500';
        break;
      case 600:
        text = '600';
        break;
      case 700:
        text = '700';
        break;
      case 800:
        text = '800';
        break;
      case 900:
        text = '900';
        break;
      case 1000:
        text = '100';
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
      fontWeight: FontWeight.bold,
      color: AppColors.contentColorPink,
      fontFamily: 'Digital',
      fontSize: 18,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('00:00', style: style);
        break;
      case 4:
        text = const Text('04:00', style: style);
        break;
      case 8:
        text = const Text('08:00', style: style);
        break;
      case 12:
        text = const Text('12:00', style: style);
        break;
      case 16:
        text = const Text('16:00', style: style);
        break;
      case 20:
        text = const Text('20:00', style: style);
        break;
      case 23:
        text = const Text('24:00', style: style);
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

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorGreen,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 200),
          FlSpot(3, 266),
          FlSpot(5, 500),
          FlSpot(7, 399),
          FlSpot(10, 366),
          FlSpot(12, 213),
          FlSpot(13, 454),
          FlSpot(15, 366),
          FlSpot(18, 213),
          FlSpot(21, 123),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: AppColors.contentColorPink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 100),
          FlSpot(3, 266),
          FlSpot(5, 587),
          FlSpot(7, 488),
          FlSpot(10, 477),
          FlSpot(12, 300),
          FlSpot(13, 397),
          FlSpot(15, 344),
          FlSpot(18, 296),
          FlSpot(21, 156),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorCyan,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 199),
          FlSpot(3, 276),
          FlSpot(5, 287),
          FlSpot(7, 121),
          FlSpot(10, 213),
          FlSpot(12, 111),
          FlSpot(13, 121),
          FlSpot(15, 345),
          FlSpot(18, 546),
          FlSpot(21, 568),
        ],
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.contentColorGreen.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.contentColorPink.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: AppColors.contentColorPink.withOpacity(0.2),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.contentColorCyan.withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

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
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 37,
            ),
            const Text(
              'Plants Moisture Daily report',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 6),
                child: _LineChart(isShowingMainData: isShowingMainData),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
          ),
          onPressed: () {
            setState(() {
              isShowingMainData = !isShowingMainData;
            });
          },
        )
      ],
    );
  }
}
