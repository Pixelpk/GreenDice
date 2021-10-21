import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/ResultsModelClass.dart';
import 'package:greendice/Screens/HomeScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/UiComponents/NotificationListItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../ModelClasses/notificationModelClass.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultsPage extends StatefulWidget {
  ResultsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late String firstname = '', lastname = '', photo = '';
  late final access_token;

  List<SalesData> data = [];

  List<SalesData> data2 = [];

  List<SalesData> data3 = [];

  List<SalesData> data4 = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    Loadprefs().then((value) => {
          Signalapi()
        });
  }

  Future<void> Loadprefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      access_token = prefs.getString('access_token') ?? '';
      firstname = (prefs.getString('fname') ?? '');
      lastname = (prefs.getString('lname') ?? '');
      photo = (prefs.getString('image') ?? '');
    });
  }

  Future<ResultsModelClass> Signalapi() async {
    setState(() {
      isLoading = true;
    });
    //print("token = "+access_token);
    var response = await http.post(
      Uri.parse("http://syedu12.sg-host.com/api/getgraphdata"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + access_token,
      },
    );

    //  var data = json.decode(response.body);
    ResultsModelClass resultsModelClass =
        ResultsModelClass.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${resultsModelClass.success}';

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
      for (int i = 0;
          i < resultsModelClass.data!.graphData!.yearlyProfit!.length;
          i++) {
        SalesData salesData = new SalesData(
            resultsModelClass.data!.graphData!.yearlyProfit![i].month
                .toString(),
            resultsModelClass.data!.graphData!.yearlyProfit![i].profit
                .toString());
        data.add(salesData);
      }

      for (int i = 0;
          i < resultsModelClass.data!.graphData!.currentYearRoi!.length;
          i++) {
        SalesData salesData = new SalesData(
            resultsModelClass.data!.graphData!.currentYearRoi![i].month
                .toString(),
            resultsModelClass.data!.graphData!.currentYearRoi![i].roi
                .toString());
        data2.add(salesData);
      }

      for (int i = 0;
          i < resultsModelClass.data!.graphData!.lastYearRoi!.length;
          i++) {
        SalesData salesData = new SalesData(
            resultsModelClass.data!.graphData!.lastYearRoi![i].month.toString(),
            resultsModelClass.data!.graphData!.lastYearRoi![i].roi.toString());
        data3.add(salesData);
      }

      for (int i = 0;
          i < resultsModelClass.data!.graphData!.lastWeekProfit!.length;
          i++) {
        SalesData salesData = new SalesData(
            resultsModelClass.data!.graphData!.lastWeekProfit![i].month
                    .toString() +
                resultsModelClass.data!.graphData!.lastWeekProfit![i].day
                    .toString(),
            resultsModelClass.data!.graphData!.lastWeekProfit![i].profit
                .toString());
        data4.add(salesData);
      }
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if(mounted){
      setState(() {
        isLoading = false;
      });}
      Fluttertoast.showToast(
        msg: "Error! Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );

    }

    return resultsModelClass;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*  appBar: new PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: new AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Image(
              image: AssetImage('assets/images/dashboardappbarimage.png'),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
            // ...
          )),*/

      body: SafeArea(
        child:isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Color(0xff009E61),
            backgroundColor: Color(0xff0ECB82),
          ),
        ): SingleChildScrollView(
          child:
               Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.21,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/calendarimage.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  photo == ''
                                      ? Container(
                                          width:MediaQuery.of(context).size.height *
                                              0.09,
                                          height: MediaQuery.of(context).size.height *
                                              0.09,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: new AssetImage(
                                                  "assets/images/profileimage.png"),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width:MediaQuery.of(context).size.height *
                                              0.09,
                                          height: MediaQuery.of(context).size.height *
                                              0.09,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                photo,
                                              ),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  Container(
                                    child: Text(
                                      firstname + " " + lastname,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffffffff)),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /*   SizedBox(

                        width: MediaQuery.of(context).size.width * 1,

                      ),*/

                            Container(
                              margin: EdgeInsets.only(
                                  left: 60, top: 0, right: 0, bottom: 0),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Results",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0ECB82)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.03,
                      color: Color(0xff009E61),
                    ),
                    Center(
                        child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(text: 'Yearly Profit'),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<SalesData, String>>[
                                LineSeries<SalesData, String>(
                                    dataSource: data,
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        double.parse(sales.sales),
                                    //        name: 'Sales',
                                    // Enable data label
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true))
                              ]),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(text: 'Yearly ROI'),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<SalesData, String>>[
                                LineSeries<SalesData, String>(
                                    dataSource: data2,
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        double.parse(sales.sales),
                                    //        name: 'Sales',
                                    // Enable data label
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true))
                              ]),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(text: 'Previous Year ROI'),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<SalesData, String>>[
                                LineSeries<SalesData, String>(
                                    dataSource: data3,
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        double.parse(sales.sales),
                                    //        name: 'Sales', sales.sales,
                                    // Enable data label
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true))
                              ]),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(text: 'Last Week Profit'),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries<SalesData, String>>[
                                LineSeries<SalesData, String>(
                                    dataSource: data4,
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        double.parse(sales.sales),
                                    //        name: 'Sales', sales.sales,
                                    // Enable data label
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: true))
                              ]),
                        ),
                      ],
                    )),
                  ],
                ),
        ),
      ),
    );
  }
}

String monthselector(String split) {
  String monthname = "January";

  if (split == "01") {
    monthname = "January";
  } else if (split == "02") {
    monthname = "Feburary";
  } else if (split == "03") {
    monthname = "March";
  } else if (split == "04") {
    monthname = "April";
  } else if (split == "05") {
    monthname = "May";
  } else if (split == "06") {
    monthname = "June";
  } else if (split == "07") {
    monthname = "July";
  } else if (split == "08") {
    monthname = "August";
  } else if (split == "09") {
    monthname = "September";
  } else if (split == "10") {
    monthname = "Octobar";
  } else if (split == "11") {
    monthname = "November";
  } else if (split == "12") {
    monthname = "December";
  }

  return monthname;
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final String sales;
}
