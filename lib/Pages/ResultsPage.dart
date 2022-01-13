import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/ResultsModelClass.dart';
import 'package:greendice/Screens/HomeScreen.dart';
import 'package:greendice/Screens/LogoutLoading.dart';
import 'package:greendice/Screens/ProfileScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/UiComponents/NotificationListItem.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../ModelClasses/notificationModelClass.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'MembershipPage.dart';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late String firstname = '', lastname = '', photo = '';
  late final access_token;

  List<SalesData> currentYearProfit = [];

  List<SalesData> lastYearProfit = [];

  // List<SalesData> data3 = [];

  // List<SalesData> data4 = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    Loadprefs().then((value) {
      Signalapi();
      // if (ispremium) {
      //
      // }
    });
  }

  String YearlyPkgepirydate = '';
  String fourMonthlyPkgepirydate = '';
  String chairmanPkgepirydate = '';
  String isYearlyPkg = '0';
  String isFourMonthPkg = '0';
  String isCharmans = '0';
  bool ispremium = true;
  Future<void> Loadprefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      access_token = prefs.getString('access_token') ?? '';
      firstname = (prefs.getString('fname') ?? '');
      lastname = (prefs.getString('lname') ?? '');
      photo = (prefs.getString('image') ?? '');
      isYearlyPkg = prefs.getString('isYearlyPkg') ?? '0';
      isFourMonthPkg = prefs.getString('isFourMonthPkg') ?? '0';
      isCharmans = prefs.getString('isChairman') ?? '0';
      YearlyPkgepirydate = prefs.getString('yearly_pkg_cancel_at') ?? '';
      fourMonthlyPkgepirydate =
          prefs.getString('four_month_pkg_cancel_at') ?? '';
      chairmanPkgepirydate = prefs.getString('chairman_pkg_cancel_at') ?? '';
      ispremium = prefs.getString('isYearlyPkg') == '1'
          ? true
          : prefs.getString('isFourMonthPkg') == '1'
              ? true
              : false;
    });
  }

  Future<ResultsModelClass> Signalapi() async {
    setState(() {
      isLoading = true;
    });
    //print("token = "+access_token);
    var response = await http.post(
      Uri.parse("https://app.greendiceinvestments.com/api/getgraphdata"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + access_token,
        "Accept":"application/json"
      },
    );
    print(response.body);
    //  var data = json.decode(response.body);
    ResultsModelClass resultsModelClass =
        ResultsModelClass.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${resultsModelClass.success}';

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
      if (resultsModelClass.data != null &&
          resultsModelClass.data!.graphData != null) {
        if (resultsModelClass.data!.graphData!.currentYearProfit != null) {
          for (int i = 0;
              i < resultsModelClass.data!.graphData!.currentYearProfit!.length;
              i++) {
            SalesData salesData = new SalesData(
                resultsModelClass.data!.graphData!.currentYearProfit![i].month
                    .toString(),
                resultsModelClass.data!.graphData!.currentYearProfit![i].profit
                    .toString(),resultsModelClass.data!.graphData!.currentYearProfit![i].progressiveProfit.toString());
            currentYearProfit.add(salesData);
          }
        }

        if (resultsModelClass.data!.graphData!.lastYearProfit != null) {
          for (int i = 0;
              i < resultsModelClass.data!.graphData!.lastYearProfit!.length;
              i++) {
            SalesData salesData = new SalesData(
                resultsModelClass.data!.graphData!.lastYearProfit![i].month
                    .toString(),
                resultsModelClass.data!.graphData!.lastYearProfit![i].profit
                    .toString(), resultsModelClass.data!.graphData!.lastYearProfit![i].progressiveProfit.toString());
            lastYearProfit.add(salesData);
          }
        }
        // if (resultsModelClass.data!.graphData!.lastYearRoi != null) {
        //   for (int i = 0;
        //       i < resultsModelClass.data!.graphData!.lastYearRoi!.length;
        //       i++) {
        //     SalesData salesData = new SalesData(
        //         resultsModelClass.data!.graphData!.lastYearRoi![i].month
        //             .toString(),
        //         resultsModelClass.data!.graphData!.lastYearRoi![i].roi
        //             .toString());
        //     data3.add(salesData);
        //   }
        // }

        // if (resultsModelClass.data!.graphData!.lastWeekProfit != null) {
        //   for (int i = 0;
        //       i < resultsModelClass.data!.graphData!.lastWeekProfit!.length;
        //       i++) {
        //     SalesData salesData = new SalesData(
        //         resultsModelClass.data!.graphData!.lastWeekProfit![i].month
        //                 .toString() +
        //             resultsModelClass.data!.graphData!.lastWeekProfit![i].day
        //                 .toString(),
        //         resultsModelClass.data!.graphData!.lastWeekProfit![i].profit
        //             .toString());
        //     data4.add(salesData);
        //   }
        // }
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      if (response.body.contains("Unauthenticated.")) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => LogoutLoading(token: access_token)),
            (route) => false);
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.21,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/calendarimage.png"),
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
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          photo == ''
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => ProfileScreen(
                                                  title: "nulkl",
                                                )));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.09,
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new AssetImage(
                                            "assets/images/profileimage.png"),
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => ProfileScreen(
                                                  title: "nulkl",
                                                )));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.09,
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          photo,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 8,
                              ),
                              Container(
                                child: Text(
                                  firstname + " " + lastname,
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xffffffff)),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                isYearlyPkg == '1'
                                    ? "Yearly Package: Active"
                                    : isFourMonthPkg == '1'
                                        ? '4-Month Package: Active'
                                        : "No Package Active",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              isCharmans == '1'
                                  ? Text(
                                      "Chairman's Package: Active",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  : Container(),
                              YearlyPkgepirydate != '' &&
                                      YearlyPkgepirydate != null
                                  ? Text(
                                      "Subscription end at: ${DateFormat.yMd().format(DateTime.parse(YearlyPkgepirydate))}",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  : fourMonthlyPkgepirydate != null &&
                                          fourMonthlyPkgepirydate != ''
                                      ? Text(
                                          "Subscription end at: ${DateFormat.yMd().format(DateTime.parse(fourMonthlyPkgepirydate))}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )
                                      : Container(),

                              ///TODO CHAIRMANS PACKAGES HANDLING
                              chairmanPkgepirydate != null &&
                                      chairmanPkgepirydate != ''
                                  ? Text(
                                      "Chairman's Subscription Expiry: ${DateFormat.yMd().format(DateTime.parse(fourMonthlyPkgepirydate))}",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  : Container()
                            ],
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
            // ispremium ?

            isLoading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff009E61),
                        backgroundColor: Color(0xff0ECB82),
                      ),
                    ),
                  )
                : Center(
                    child: currentYearProfit.isEmpty && lastYearProfit.isEmpty
                        // && data3.isEmpty && data4.isEmpty
                        ? Text("No Results to show")
                        : Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              currentYearProfit.isNotEmpty
                                  ? Container(
                                      child: 
                                      // SfCartesianChart(
                                      //     series: <ChartSeries>[
                                      //       // Renders column chart
                                      //       ColumnSeries<SalesData, String>(
                                      //           dataSource: currentYearProfit,
                                      //           xValueMapper: (SalesData sales, _) => sales.year,
                                      //           yValueMapper: (SalesData sales, _) => sales.sales
                                      //       )
                                      //     ]
                                      // )
                                      
                                      
                                      Column(
                                        children: [
                                          SfCartesianChart(
                                              backgroundColor: Color(0xffdbf1e9),
                                              primaryXAxis: CategoryAxis(),
                                              enableAxisAnimation: true,
                                              // Chart title
                                              title: ChartTitle(
                                                  text: 'Current Years Monthly Profit'),
                                              // Enable legend
                                              legend: Legend(
                                                isVisible: false,
                                              ),
                                              // Enable tooltip
                                              tooltipBehavior:
                                                  TooltipBehavior(enable: true),
                                              series: <
                                                  ChartSeries<SalesData, String>>[
                                                ColumnSeries<SalesData, String>(
                                                  color: Color(0xff26E7A6),
                                                    dataSource: currentYearProfit,
                                                    xValueMapper: (SalesData sales, _) => sales.year,
                                                    yValueMapper: (SalesData sales, _) => double.parse(sales.profit)
                                                )
                                                // LineSeries<SalesData, String>(
                                                //     color: Color(0xff26E7A6),
                                                //     dataSource: currentYearProfit,
                                                //     xValueMapper:
                                                //         (SalesData sales, _) =>
                                                //             sales.year,
                                                //     yValueMapper: (SalesData sales,
                                                //             _) =>
                                                //         double.parse(sales.sales),
                                                //     //        name: 'Sales',
                                                //     // Enable data label
                                                //     dataLabelSettings:
                                                //         DataLabelSettings(
                                                //       isVisible: true,
                                                //     ))
                                              ]),
                                          SizedBox(height: 8,),
                                          Text("(Lowest Recommended @ \$150 per signal)",style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),)
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                      width: 0,
                                    ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              lastYearProfit.isNotEmpty
                                  ? Container(
                                      child: Column(
                                        children: [
                                          SfCartesianChart(
                                              backgroundColor: Color(0xffdbf1e9),
                                              primaryXAxis: CategoryAxis(),
                                              // Chart title
                                              title: ChartTitle(
                                                  text: 'Last Years Monthly Profit'),
                                              // Enable legend
                                              legend: Legend(isVisible: false),
                                              // Enable tooltip
                                              tooltipBehavior:
                                                  TooltipBehavior(enable: true),
                                              series: <
                                                  ChartSeries<SalesData, String>>[
                                                ColumnSeries<SalesData, String>(
                                                    dataSource: lastYearProfit,
                                                    color: Color(0xff26A0FC),
                                                    xValueMapper: (SalesData sales, _) => sales.year,
                                                    yValueMapper: (SalesData sales, _) => double.parse(sales.profit)
                                                )
                                                // LineSeries<SalesData, String>(
                                                //     color: Color(0xff26A0FC),
                                                //     dataSource: lastYearProfit,
                                                //     xValueMapper:
                                                //         (SalesData sales, _) =>
                                                //             sales.year,
                                                //     yValueMapper: (SalesData sales,
                                                //             _) =>
                                                //         double.parse(sales.sales),
                                                //     //        name: 'Sales',
                                                //     // Enable data label
                                                //     dataLabelSettings:
                                                //         DataLabelSettings(
                                                //             isVisible: true))
                                              ]),
                                          SizedBox(height: 8,),
                                          Text("(Lowest Recommended @ \$150 per signal)",style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          ),)
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                      width: 0,
                                    ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              // data3.isNotEmpty ?    Container(
                              //       child: SfCartesianChart(
                              //           backgroundColor: Color(0xffdbf1e9),
                              //           primaryXAxis: CategoryAxis(),
                              //           // Chart title
                              //           title: ChartTitle(text: 'Previous Year ROI'),
                              //           // Enable legend
                              //           legend: Legend(isVisible: false),
                              //           // Enable tooltip
                              //           tooltipBehavior: TooltipBehavior(enable: true),
                              //           series: <ChartSeries<SalesData, String>>[
                              //             LineSeries<SalesData, String>(
                              //                 color: Colors.green,
                              //                 dataSource: data3,
                              //                 xValueMapper: (SalesData sales, _) =>
                              //                     sales.year,
                              //                 yValueMapper: (SalesData sales, _) =>
                              //                     double.parse(sales.sales),
                              //                 //        name: 'Sales', sales.sales,
                              //                 // Enable data label
                              //                 dataLabelSettings:
                              //                     DataLabelSettings(isVisible: true))
                              //           ]),
                              //     ):Container(height: 0,width: 0,),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Container(
                                child: SfCartesianChart(
                                    backgroundColor: Color(0xffdbf1e9),
                                    primaryXAxis: CategoryAxis(),
                                    // Chart title
                                    title: ChartTitle(text: 'Current And Last Year Profit Comparison',),
                                    // Enable legend
                                    legend: Legend(isVisible: false,),
                                    // Enable tooltip
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    series: <ChartSeries<SalesData, String>>[
                                      LineSeries<SalesData, String>(
                                          color: Color(0xff26E7A6),
                                          dataSource: currentYearProfit,

                                          xValueMapper: (SalesData sales, _) =>
                                              sales.year,
                                          yValueMapper: (SalesData sales, _) =>
                                              double.parse(sales.progressiveProfit),
                                          //        name: 'Sales', sales.sales,
                                          // Enable data label
                                          dataLabelSettings: DataLabelSettings(

                                              isVisible: true)),
                                      LineSeries<SalesData, String>(
                                          color: Color(0xff26A0FC),

                                          dataSource: lastYearProfit,
                                          xValueMapper: (SalesData sales, _) =>
                                              sales.year,
                                          yValueMapper: (SalesData sales, _) =>
                                              double.parse(sales.progressiveProfit),
                                          //        name: 'Sales', sales.sales,
                                          // Enable data label
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true))
                                    ]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(height: 10,width: 10,color: Color(0xff26A0FC),),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("Last Year",style: TextStyle(fontSize: 10),),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(     crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(height: 10,width: 10,color: Color(0xff26E7A6),),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("Current Year",style: TextStyle(fontSize: 10)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ))
            // : Center(
            //     child: Container(
            //         height: MediaQuery.of(context).size.height * 0.65,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text('Buy Packages to see Results'),
            //             SizedBox(
            //               height: 20,
            //             ),
            //             MaterialButton(
            //               onPressed: () {
            //                 Navigator.of(context).push(MaterialPageRoute(
            //                     builder: (_) => MembershipPage()));
            //               },
            //               minWidth: MediaQuery.of(context).size.width * 0.1,
            //               height: MediaQuery.of(context).size.height * 0.06,
            //               child: Text("Buy Now"),
            //               color: Colors.green,
            //             )
            //           ],
            //         )),
            //   )
          ],
        ),
      )),
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
  SalesData(this.year, this.profit,this.progressiveProfit);
  final String year;
  final String profit;
  final String progressiveProfit;
}
