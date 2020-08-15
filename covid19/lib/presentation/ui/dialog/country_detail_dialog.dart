import 'package:covid19/presentation/modal/country.dart';
import 'package:covid19/presentation/utils/colors.dart';
import 'package:covid19/presentation/utils/number_format_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart' as chart;

class CountryDetailDialog extends StatelessWidget {
  CountryDetailDialog(this.country);

  final Country country;

  chart.ChartOptions _verticalBarChartOptions;
  chart.LabelLayoutStrategy _xContainerLabelLayoutStrategy;
  chart.ChartData _chartData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 430,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 5, top: 10),
                decoration:
                    const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: getBody(context),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                width: 28,
                height: 28,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle, border: Border.all(color: CoVidColor.gray4d)),
                    child: Center(
                        child: Icon(
                      Icons.clear,
                      color: CoVidColor.gray4d,
                    )),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  behavior: HitTestBehavior.translucent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getBody(BuildContext context) {
    defineOptionsAndData();
    List<Widget> widgets = [];
    widgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              '${country.country}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    widgets.add(
      Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(width: 80, child: Text('Confirmed: ', style: TextStyle(fontSize: 16))),
                Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('${NumberFormatCustom.getCustomFormatNumber(country.totalConfirmed ?? 0)}'),
                ),
                Visibility(
                  visible: (country.newConfirmed ?? 0) > 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(height: 10.0, child: Image.asset('assets/images/red_arrow.png')),
                        Container(
                          height: 10.0,
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            '${NumberFormatCustom.getCustomFormatNumber(country.newConfirmed ?? 0)}',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(width: 80, child: Text('Recovered: ', style: TextStyle(fontSize: 16))),
                Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('${NumberFormatCustom.getCustomFormatNumber(country.totalRecovered ?? 0)}'),
                ),
                Visibility(
                  visible: (country.newRecovered ?? 0) > 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(height: 10.0, child: Image.asset('assets/images/green_arrow.png')),
                        Container(
                          height: 10.0,
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            '${NumberFormatCustom.getCustomFormatNumber(country.newRecovered ?? 0)}',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(width: 80, child: Text('Death: ', style: TextStyle(fontSize: 16))),
                Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('${NumberFormatCustom.getCustomFormatNumber(country.totalDeaths ?? 0)}'),
                ),
                Visibility(
                  visible: (country.totalDeaths ?? 0) > 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(height: 10, child: Image.asset('assets/images/red_arrow.png')),
                        Container(
                          height: 10.0,
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            '${NumberFormatCustom.getCustomFormatNumber(country.newRecovered ?? 0)}',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Center(
            child: Container(
              height: 250,
              width: 250,
              child: chart.VerticalBarChart(
                painter: chart.VerticalBarChartPainter(),
                container: chart.VerticalBarChartContainer(
                  chartData: _chartData, // @required
                  chartOptions: _verticalBarChartOptions, // @required
                  xContainerLabelLayoutStrategy: _xContainerLabelLayoutStrategy, // @optional
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return widgets;
  }

  void defineOptionsAndData() {
    _verticalBarChartOptions = chart.VerticalBarChartOptions();
    _chartData = chart.ChartData();
    _chartData.dataRowsLegends = ["Confirmed", "Recovered", "Death"];
    _chartData.dataRows = [
      [
        (country.totalConfirmed - country.newConfirmed).toDouble(),
        country.totalConfirmed.toDouble(),
      ],
      [
        (country.totalRecovered - country.newRecovered).toDouble(),
        country.totalRecovered.toDouble(),
      ],
      [
        (country.totalDeaths - country.newDeaths).toDouble(),
        country.totalDeaths.toDouble(),
      ],
    ];
    _chartData.xLabels = ["Yesterday", "Today"];
    _chartData.dataRowsColors = [CoVidColor.blue, CoVidColor.green, CoVidColor.redLine];
    _chartData.assignDataRowsDefaultColors();
  }
}
