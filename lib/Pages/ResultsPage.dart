import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  late String firstname,lastname,photo;
  late final access_token;

  List<SalesData> data = [
    SalesData('Jan', "35"),
    SalesData('Feb', "28"),
    SalesData('Mar', "34"),
    SalesData('Apr', "32"),
    SalesData('May', "40")
  ];

  List<SalesData> data2 = [
    SalesData('Jan', "1.3"),
    SalesData('Feb', "5.2"),
    SalesData('Mar', "1"),
    SalesData('Apr', "2.5"),
    SalesData('May', "3.8")
  ];

  List<SalesData> data3 = [
    SalesData('Jan', "1.2"),
    SalesData('Feb', "3.5"),
    SalesData('Mar', "8.3"),
    SalesData('Apr', "6.9"),
    SalesData('May', "1.3"),
    SalesData('Jun', "2.3"),
    SalesData('Jul', "3.3"),
    SalesData('Aug', "4.3"),
    SalesData('Sep', "5.3"),
    SalesData('Oct', "6.3"),
    SalesData('Nov', "7.3"),
    SalesData('Dec', "8.3"),
  ];

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    Loadprefs().then((value) =>
    {
      Signalapi().then((value) => {
      }),
    });
  }

  Future<void> Loadprefs() async{

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      access_token = prefs.getString('access_token') ?? '';
      firstname = (prefs.getString('fname') ?? '');
      lastname = (prefs.getString('lname') ?? '');
      photo = (prefs.getString('image') ?? '');
      isLoading = false;
    });


  }

  Future<notifcationModelClass> Signalapi() async{


    final prefs = await SharedPreferences.getInstance();
    final access_token = prefs.getString('access_token') ?? '';
    //print("token = "+access_token);
    var response = await http.post(Uri.parse("http://syedu12.sg-host.com/api/signalnotifications"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer "+access_token,
      },
    );


    //  var data = json.decode(response.body);
    notifcationModelClass notificationmodel = notifcationModelClass.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${notificationmodel.success}';

    this.setState(() {

    });

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    print(jsonDecode(response.body));



    print(val);
    if(val == "1")
    {

     /* for (int i=0;i<notificationmodel.data!.notificationSignal!.length;i++)
        {

          SalesData salesData = new SalesData(notificationmodel.data!.notificationSignal![i].signalDate.toString(), notificationmodel.data!.notificationSignal![i].profit!);
          data.add(salesData);

        }
*/


    }
    else
    {
      Fluttertoast.showToast(
        msg: "Error! Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(title: "HomScreen")),
      );*/
    }

    return notificationmodel;

  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
        child: SingleChildScrollView(
          child: isLoading ? CircularProgressIndicator() : Column(
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
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.1,
                             /* decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/profileicon.png"),
                                      fit: BoxFit.cover)),*/
                              child: photo == '' ? Image.asset("assets/images/profileimage.png") : Image.network(photo),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: Text(
                                firstname +" "+ lastname,
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xffffffff)),
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
                        child:  SfCartesianChart(
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
                                  xValueMapper: (SalesData sales, _) => sales.year,
                                  yValueMapper: (SalesData sales, _) => double.parse(sales.sales),
                                  //        name: 'Sales',
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true))
                            ]),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,

                      ),

                      Container(
                        child:  SfCartesianChart(
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
                                  xValueMapper: (SalesData sales, _) => sales.year,
                                  yValueMapper: (SalesData sales, _) => double.parse(sales.sales),
                                  //        name: 'Sales',
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true))
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
                                  xValueMapper: (SalesData sales, _) => sales.year,
                                  yValueMapper: (SalesData sales, _) => double.parse(sales.sales),
                                  //        name: 'Sales', sales.sales,
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true))
                            ]),
                      ),






                      Container(
                        child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title: ChartTitle(text: '4th graph'),
                            // Enable legend
                            legend: Legend(isVisible: false),
                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries<SalesData, String>>[
                              LineSeries<SalesData, String>(
                                  dataSource: data3,
                                  xValueMapper: (SalesData sales, _) => sales.year,
                                  yValueMapper: (SalesData sales, _) => double.parse(sales.sales),
                                  //        name: 'Sales', sales.sales,
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true))
                            ]),
                      ),


                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


String monthselector(String split) {

  String monthname = "January";

  if(split=="01")
  {
    monthname = "January";
  }
  else if(split=="02")
  {
    monthname = "Feburary";
  }
  else if(split=="03")
  {
    monthname = "March";
  }
  else if(split=="04")
  {
    monthname = "April";
  }
  else if(split=="05")
  {
    monthname = "May";
  }
  else if(split=="06")
  {
    monthname = "June";
  }
  else if(split=="07")
  {
    monthname = "July";
  }
  else if(split=="08")
  {
    monthname = "August";
  }
  else if(split=="09")
  {
    monthname = "September";
  }
  else if(split=="10")
  {
    monthname = "Octobar";
  }
  else if(split=="11")
  {
    monthname = "November";
  }
  else if(split=="12")
  {
    monthname = "December";
  }

  return monthname;
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final String sales;
}


