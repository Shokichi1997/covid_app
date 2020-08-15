import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'presentation/utils/colors.dart';
import 'presentation/utils/number_format_custom.dart';

class PieChartCustom extends StatefulWidget {
  const PieChartCustom(
      {Key key, this.newDeaths, this.deaths, this.recovered, this.newRecovered, this.treating, this.newConfirm})
      : super(key: key);

  final int newDeaths;
  final int deaths;
  final int recovered;
  final int newRecovered;
  final int treating;
  final int newConfirm;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartCustom> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PieChart(
          PieChartData(
              pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                if (mounted) {
                  setState(() {
                    if (pieTouchResponse.touchInput is FlLongPressEnd || pieTouchResponse.touchInput is FlPanEnd) {
                      touchedIndex = -1;
                    } else {
                      touchedIndex = pieTouchResponse.touchedSectionIndex;
                    }
                  });
                }
              }),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(),
              startDegreeOffset: -20),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: CoVidColor.blue,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: CoVidColor.green,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    color: CoVidColor.redLine,
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Confirmed:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Recovered:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Death:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 10.0),
                        child: Text(
                          '${NumberFormatCustom.getCustomFormatNumber(widget.treating ?? 0)}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(right: 4.0),
                              height: 10,
                              child: Image.asset('assets/images/red_arrow.png')),
                          Text(
                            '${NumberFormatCustom.getCustomFormatNumber(widget.newConfirm ?? 0)}',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            '${NumberFormatCustom.getCustomFormatNumber(widget.recovered ?? 0)}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(right: 4.0),
                                height: 10,
                                child: Image.asset('assets/images/green_arrow.png')),
                            Text(
                              '${NumberFormatCustom.getCustomFormatNumber(widget.newRecovered ?? 0)}',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 10),
                        child: Text(
                          '${NumberFormatCustom.getCustomFormatNumber(widget.deaths ?? 0)}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(right: 4.0),
                              height: 10,
                              child: Image.asset('assets/images/red_arrow.png')),
                          Text(
                            '${NumberFormatCustom.getCustomFormatNumber(widget.newDeaths ?? 0)}',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 120 : 110;
      int total = widget.treating + widget.deaths + widget.recovered;
      double treatPercent = (widget.treating / total) * 100;
      double deathPercent = (widget.deaths / total) * 100;
      double recoveredPercent = (widget.recovered / total) * 100;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF0AC9F2),
            value: treatPercent,
            title: '${100 - (deathPercent.ceil() + recoveredPercent.ceil())}%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFF09E841),
            value: recoveredPercent,
            title: '${recoveredPercent.ceil()}%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFEB3D19),
            value: deathPercent,
            title: '${deathPercent.ceil()}%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
