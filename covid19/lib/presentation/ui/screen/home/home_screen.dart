import 'dart:async';
import 'package:covid19/chart.dart';
import 'package:covid19/presentation/modal/country.dart';
import 'package:covid19/presentation/modal/summary.dart';
import 'package:covid19/presentation/ui/dialog/country_detail_dialog.dart';
import 'package:covid19/presentation/utils/colors.dart';
import 'package:covid19/presentation/utils/number_format_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    _homeBloc.getSummary();
    getData();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoVidColor.white,
      body: ChangeNotifierProvider.value(
        value: _homeBloc,
        child: Consumer<HomeBloc>(builder: (context, bloc, _) {
          Summary summary = bloc.summary;
          return Container(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: CoVidColor.white,
                          ),
                          child: SvgPicture.asset(
                            'assets/images/header.svg',
                            fit: BoxFit.contain,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 30.0),
                        decoration: BoxDecoration(
                            color: CoVidColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: bloc.summary != null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.only(top: 40),
                                      child: PieChartCustom(
                                        newDeaths: summary?.global?.newDeaths ?? 0,
                                        deaths: summary?.global?.totalDeaths ?? 0,
                                        recovered: summary?.global?.totalRecovered ?? 0,
                                        newRecovered: summary?.global?.newRecovered ?? 0,
                                        treating: (getGlobalTotal(summary)) -
                                            ((summary?.global?.totalRecovered ?? 0) +
                                                (summary?.global?.totalDeaths ?? 0)),
                                        newConfirm: summary?.global?.newConfirmed ?? 0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Text(''),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(color: CoVidColor.gray),
                                            right: BorderSide(color: CoVidColor.gray),
                                            top: BorderSide(color: CoVidColor.gray),
                                            bottom: BorderSide(color: CoVidColor.gray))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 30,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(color: CoVidColor.gray),
                                              ),
                                            ),
                                            child: Container(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Nation',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 30,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(color: CoVidColor.gray),
                                              ),
                                            ),
                                            child: Container(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Total confirmed',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 30,
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Total recovered',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: getCountriesData(context, bloc),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              )
                            : Container(
                                padding: const EdgeInsets.only(top: 100, bottom: 100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        child: Image.asset('assets/images/loading.gif'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 200,
                    right: 0,
                    left: 0,
                    child: Container(
                      margin: const EdgeInsets.only(right: 32, left: 32),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 30.0,
                            top: 20.0,
                            child: Container(height: 25, child: Image.asset('assets/images/virus_ic.png')),
                          ),
                          Positioned(
                            right: 30.0,
                            top: 20.0,
                            child: Container(height: 20, child: Image.asset('assets/images/virus_ic.png')),
                          ),
                          Positioned(
                            right: 20.0,
                            bottom: 10.0,
                            child: Container(height: 18, child: Image.asset('assets/images/virus_ic.png')),
                          ),
                          Positioned(
                            left: 100.0,
                            bottom: 10.0,
                            child: Container(height: 16, child: Image.asset('assets/images/virus_ic.png')),
                          ),
                          Positioned(
                            left: 0.0,
                            right: 0,
                            top: -8.0,
                            child: Container(height: 20, child: Image.asset('assets/images/virus_ic.png')),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Global total',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Center(
                                    child: Text(
                                      (NumberFormatCustom.getCustomFormatNumber(getGlobalTotal(summary))).toString(),
                                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: (summary?.global?.newConfirmed ?? 0) > 0,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            margin: const EdgeInsets.only(right: 4.0),
                                            height: 15,
                                            child: Image.asset('assets/images/red_arrow.png')),
                                        Text(
                                          '${NumberFormatCustom.getCustomFormatNumber(summary?.global?.newConfirmed ?? 0)}',
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  int getGlobalTotal(Summary summary) {
    int total = summary?.global?.totalConfirmed ?? 0;
    return total;
  }

  List<Widget> getCountriesData(BuildContext context, HomeBloc bloc) {
    List<Widget> widgets = [];
    if (bloc?.summary?.countries == null) {
      return widgets;
    }
    List<Country> countries = bloc?.summary?.countries;
    countries.sort((country1, country2) => country2.totalConfirmed.compareTo(country1.totalConfirmed));
    int numCountries = countries?.length ?? 0;
    for (int i = 0; i < numCountries; ++i) {
      widgets.add(getListItem(context, countries[i], i));
    }
    return widgets;
  }

  Widget getListItem(BuildContext context, Country country, int index) {
    Color backgroundColor = index % 2 == 0 ? CoVidColor.white : CoVidColor.gray;
    return InkWell(
      onTap: () {
        showDialog(context: context, child: CountryDetailDialog(country));
      },
      child: Container(
        constraints: BoxConstraints(minHeight: 50.0),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(
                left: BorderSide(color: CoVidColor.gray),
                right: BorderSide(color: CoVidColor.gray),
                bottom: BorderSide(color: CoVidColor.gray))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  country.country ?? '',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 2.0, bottom: 4.0),
                    child: Text('${NumberFormatCustom.getCustomFormatNumber(country.totalConfirmed ?? 0)}'),
                  ),
                  Visibility(
                    visible: (country.newConfirmed ?? 0) > 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 8, child: Image.asset('assets/images/red_arrow.png')),
                          Container(
                            height: 8.0,
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              '${NumberFormatCustom.getCustomFormatNumber(country.newConfirmed ?? 0)}',
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    child: Text('${NumberFormatCustom.getCustomFormatNumber(country.totalRecovered ?? 0)}'),
                  ),
                  Visibility(
                    visible: (country.newRecovered ?? 0) > 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 8, child: Image.asset('assets/images/green_arrow.png')),
                          Container(
                            height: 8.0,
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Text(
                              '${NumberFormatCustom.getCustomFormatNumber(country.newRecovered ?? 0)}',
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getData() {
    print('Get data');
    timer?.cancel();
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _homeBloc.getSummary();
    });
  }
}
