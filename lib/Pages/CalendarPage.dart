import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:greendice/Screens/CalendarDataScreen.dart';
import 'package:greendice/Screens/ProfileScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ModelClasses/notificationModelClass.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'MembershipPage.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late String firstname = '', lastname = '', photo = '';
  late final accessToken;
  bool isLoading = false;

  DateTime _currentDate = DateTime.now();

  String _currentMonth = DateFormat.yMMM().format(DateTime.now());

  //DateTime _targetDateTime = DateTime(2019, 2, 3);
  DateTime _targetDateTime = DateTime.now();
  DateTime _maxDateTime = DateTime(2100, 2, 3);

  // static Widget _eventIcon = new Container(
  //   decoration: new BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(Radius.circular(1000)),
  //       border: Border.all(color: Colors.blue, width: 2.0)),
  //   child: new Icon(
  //     Icons.person,
  //     color: Colors.amber,
  //   ),
  // );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      /*new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],*/
    },
  );

  @override
  void initState() {
    super.initState();

    Loadprefs().then((value) {});

    /*Signalapi().then((value) => {



    });*/
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
      accessToken = prefs.getString('access_token') ?? '';
      firstname = (prefs.getString('fname') ?? '');
      lastname = (prefs.getString('lname') ?? '');
      photo = (prefs.getString('image') ?? '');

      YearlyPkgepirydate = prefs.getString('yearly_pkg_cancel_at') ?? '';
      fourMonthlyPkgepirydate =
          prefs.getString('four_month_pkg_cancel_at') ?? '';
      chairmanPkgepirydate = prefs.getString('chairman_pkg_cancel_at') ?? '';
      isYearlyPkg = prefs.getString('isYearlyPkg') ?? '0';
      isFourMonthPkg = prefs.getString('isFourMonthPkg') ?? '0';
      isCharmans = prefs.getString('isChairman') ?? '0';
      ispremium = prefs.getString('isYearlyPkg') == '1'
          ? true
          : prefs.getString('isFourMonthPkg') == '1'
              ? true
              : false;
    });
    return Future.value();
  }

  Future<NotificationModel> Signalapi() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    //print("token = "+access_token);
    var response = await http.post(
      Uri.parse("https://app.greendiceinvestments.com/api/signalnotifications"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + accessToken,
        "Accept":"application/json"
      },
    );

    //  var data = json.decode(response.body);
    NotificationModel notificationmodel =
        NotificationModel.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${notificationmodel.success}';

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      /*Fluttertoast.showToast(
        msg: "Error! Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );*/
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
//     final _calendarCarouselNoHeader = CalendarCarousel<Event>(
//       todayBorderColor: Colors.green,
//       onDayPressed: (date, events) {
//         this.setState(() => _currentDate2 = date);
//         events.forEach((event) => print(event.title));
//
//         var val = "0";
//         if(date.month < 10 && date.day < 10) {
//
//           /*print(date.year.toString() + "-0" + date.month.toString() + "-0" +
//               date.day.toString());*/
//           val = date.year.toString() + "-0" + date.month.toString() + "-0" +
//               date.day.toString();
//         }
//         else if(date.month > 10 && date.day < 10)
//           {
//             /*print(date.year.toString() + "-" + date.month.toString() + "-0" +
//                 date.day.toString());*/
//             val = date.year.toString() + "-" + date.month.toString() + "-0" +
//                 date.day.toString();
//           }
//         else if(date.month < 10 && date.day > 10)
//           {
//             /*print(date.year.toString() + "-0" + date.month.toString() + "-" +
//                 date.day.toString());*/
//
//             val = date.year.toString() + "-0" + date.month.toString() + "-" +
//                 date.day.toString();
//           }
//         else if(date.month > 10 && date.day > 10)
//           {
//             /*print(date.year.toString() + "-" + date.month.toString() + "-" +
//                 date.day.toString());*/
//
//             val = date.year.toString() + "-" + date.month.toString() + "-" +
//                 date.day.toString();
//           }
//
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CalendarDataScreen(title: val,),
//           ),
//         );
//
//       },
//       daysHaveCircularBorder: true,
//       showOnlyCurrentMonthDate: false,
//       weekendTextStyle: TextStyle(
//         color: Colors.red,
//       ),
//       thisMonthDayBorderColor: Colors.grey,
//       weekFormat: false,
// //      firstDayOfWeek: 4,
//       markedDatesMap: _markedDateMap,
//       height: 420.0,
//       selectedDateTime: _currentDate2,
//       targetDateTime: _targetDateTime,
//       customGridViewPhysics: NeverScrollableScrollPhysics(),
//       markedDateCustomShapeBorder:
//       CircleBorder(side: BorderSide(color: Colors.yellow)),
//       markedDateCustomTextStyle: TextStyle(
//         fontSize: 18,
//         color: Colors.blue,
//       ),
//       showHeader: false,
//       todayTextStyle: TextStyle(
//         color: Colors.blue,
//       ),
//       // markedDateShowIcon: true,
//       // markedDateIconMaxShown: 2,
//       // markedDateIconBuilder: (event) {
//       //   return event.icon;
//       // },
//       // markedDateMoreShowTotal:
//       //     true,
//       todayButtonColor: Colors.yellow,
//       selectedDayTextStyle: TextStyle(
//         color: Colors.yellow,
//       ),
//       minSelectedDate: _currentDate.subtract(Duration(days: 0)),
//       maxSelectedDate: _maxDateTime,
//       prevDaysTextStyle: TextStyle(
//         fontSize: 16,
//         color: Colors.pinkAccent,
//       ),
//       inactiveDaysTextStyle: TextStyle(
//         color: Colors.tealAccent,
//         fontSize: 16,
//       ),
//       onCalendarChanged: (DateTime date) {
//         this.setState(() {
//           _targetDateTime = date;
//           _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//         });
//       },
//       onDayLongPressed: (DateTime date) {
//         print('long pressed date $date');
//       },
//     );

    return Scaffold(

      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xff009E61),
                  backgroundColor: Color(0xff0ECB82),
                ),
              )
            : SingleChildScrollView(
                child: Column(
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
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProfileScreen(
                                                          title: "nulkl",
                                                        )));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new AssetImage(
                                                    "assets/images/profileimage.png"),
                                              ),
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProfileScreen(
                                                          title: "nulkl",
                                                        )));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.09,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
                                        ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 8,
                                      ),
                                      Container(
                                        child: Text(
                                          firstname + " " + lastname,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xffffffff)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      ///PAYMENT

                                      // Text(
                                      //   isYearlyPkg == '1'
                                      //       ? "Yearly Package: Active"
                                      //       : isFourMonthPkg == '1'
                                      //           ? '4-Month Package: Active'
                                      //           : "No Package Active",
                                      //   style: TextStyle(
                                      //       fontSize: 12, color: Colors.white),
                                      // ),
                                      // SizedBox(
                                      //   height: 4,
                                      // ),
                                      // isCharmans == '1'
                                      //     ? Text(
                                      //         "Chairman's Package: Active",
                                      //         style: TextStyle(
                                      //             fontSize: 12,
                                      //             color: Colors.white),
                                      //       )
                                      //     : Container(),
                                      // YearlyPkgepirydate != '' &&
                                      //         YearlyPkgepirydate != null
                                      //     ? Text(
                                      //         "Subscription end at: ${DateFormat.yMd().format(DateTime.parse(YearlyPkgepirydate))}",
                                      //         style: TextStyle(
                                      //             fontSize: 12,
                                      //             color: Colors.white),
                                      //       )
                                      //     : fourMonthlyPkgepirydate != null &&
                                      //             fourMonthlyPkgepirydate != ''
                                      //         ? Text(
                                      //             "Subscription end at: ${DateFormat.yMd().format(DateTime.parse(fourMonthlyPkgepirydate))}",
                                      //             style: TextStyle(
                                      //                 fontSize: 12,
                                      //                 color: Colors.white),
                                      //           )
                                      //         : Container(),
                                      //
                                      // ///TODO CHAIRMANS PACKAGES HANDLING
                                      // chairmanPkgepirydate != null &&
                                      //         chairmanPkgepirydate != ''
                                      //     ? Text(
                                      //         "Chairman's Subscription Expiry: ${DateFormat.yMd().format(DateTime.parse(fourMonthlyPkgepirydate))}",
                                      //         style: TextStyle(
                                      //             fontSize: 12,
                                      //             color: Colors.white),
                                      //       )
                                      //     : Container()
                                      ///PAYMENT

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
                                "Calendar",
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
                    // ispremium?
                        Center(
                            child: Column(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    //custom icon
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      // child: _calendarCarousel,
                                    ),
                                    // This trailing comma makes auto-formatting nicer for build methods.
                                    //custom icon without header
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 30.0,
                                        bottom: 16.0,
                                        left: 16.0,
                                        right: 16.0,
                                      ),
                                      child: new Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            _currentMonth,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                            ),
                                          )),
                                          FlatButton(
                                            child: Text('PREV'),
                                            onPressed: () {
                                              if (mounted) {
                                                setState(() {
                                                  /*_targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month - 1);
                                        _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                                        */

                                                  _targetDateTime = DateTime(
                                                      _currentDate.year,
                                                      _currentDate.month - 1);
                                                  _currentMonth =
                                                      DateFormat.yMMM().format(
                                                          _targetDateTime);
                                                  _currentDate =
                                                      _targetDateTime;
                                                });
                                              }
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('NEXT'),
                                            onPressed: () {
                                              if (mounted) {
                                                setState(() {
                                                  /*_targetDateTime = DateTime(
                                            _targetDateTime.year, _targetDateTime.month + 1);
                                        _currentMonth =
                                            DateFormat.yMMM().format(_targetDateTime);*/

                                                  _targetDateTime = DateTime(
                                                      _currentDate.year,
                                                      _currentDate.month + 1);
                                                  _currentMonth =
                                                      DateFormat.yMMM().format(
                                                          _targetDateTime);
                                                  _currentDate =
                                                      _targetDateTime;
                                                });
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      //child: _calendarCarouselNoHeader,
                                      child: CalendarCarousel<Event>(
                                        dayButtonColor: Color(0xffdbf1e9),

                                        todayBorderColor: Colors.green,
                                        onDayPressed: (date, events) {
                                          if (mounted) {
                                            this.setState(
                                                () => _currentDate = date);
                                          }
                                          String formateddate =
                                              DateFormat.yMd().format(date);
                                          //print(formateddate);
                                          List<String> splitteddate =
                                              formateddate.split('/');
                                          // print(splitteddate);
                                          String month = splitteddate[0];
                                          if (month.length == 1) {
                                            month = "0$month";
                                          }
                                          String selecteddate = splitteddate[1];
                                          if (selecteddate.length == 1) {
                                            selecteddate = "0$selecteddate";
                                          }
                                          String year = splitteddate[2];
                                          List<String> requiredFormatList = [
                                            year,
                                            month,
                                            selecteddate
                                          ];
                                          String finaldate =
                                              requiredFormatList.join('-');
                                          print('date: $finaldate');

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CalendarDataScreen(
                                                title: finaldate,
                                                    selectedDate: DateFormat.yMMMd().format(date),
                                              ),
                                            ),
                                          );
                                        },
                                        onCalendarChanged: (DateTime date) {
                                          if (mounted) {
                                            setState(() {
                                              _targetDateTime = date;
                                              _currentMonth = DateFormat.yMMM()
                                                  .format(_targetDateTime);
                                            });
                                          }
                                        },
                                        daysHaveCircularBorder: true,
                                        showOnlyCurrentMonthDate: false,
                                        weekendTextStyle: TextStyle(
                                          color: Colors.red,
                                        ),

                                        thisMonthDayBorderColor: Colors.green,
                                        weekFormat: false,
                                        markedDatesMap: _markedDateMap,
                                        height: 420.0,
                                        selectedDateTime: _currentDate,
                                        targetDateTime: _targetDateTime,
                                        //targetDateTime: _curr,
                                        customGridViewPhysics:
                                            NeverScrollableScrollPhysics(),
                                        markedDateCustomShapeBorder:
                                            CircleBorder(
                                          side:
                                              BorderSide(color: Colors.yellow),
                                        ),
                                        markedDateCustomTextStyle: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                        ),
                                        showHeader: false,
                                        todayTextStyle: TextStyle(
                                          color: Colors.green,
                                        ),
                                        // markedDateShowIcon: true,
                                        // markedDateIconMaxShown: 2,
                                        // markedDateIconBuilder: (event) {
                                        //   return event.icon;
                                        // },
                                        // markedDateMoreShowTotal:
                                        //     true,
                                        todayButtonColor: Colors.yellow,
                                        selectedDayTextStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        minSelectedDate: _currentDate
                                            .subtract(Duration(days: 10000)),
                                        maxSelectedDate: _maxDateTime,
                                        prevDaysTextStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.pinkAccent,
                                        ),
                                        inactiveDaysTextStyle: TextStyle(
                                          color: Colors.tealAccent,
                                          fontSize: 16,
                                        ),
                                        onDayLongPressed: (DateTime date) {
                                          print('long pressed date $date');
                                        },
                                      ),
                                    ),
                                    //
                                  ],
                                ),
                              )
                            ],
                          ))
                        // : Center(
                        //     child: Container(
                        //         height:
                        //             MediaQuery.of(context).size.height * 0.65,
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Text('Buy Package to see All Events'),
                        //             SizedBox(
                        //               height: 20,
                        //             ),
                        //             MaterialButton(
                        //               onPressed: () {
                        //                 Navigator.of(context).push(
                        //                     MaterialPageRoute(
                        //                         builder: (_) =>
                        //                             MembershipPage()));
                        //               },
                        //               minWidth:
                        //                   MediaQuery.of(context).size.width *
                        //                       0.1,
                        //               height:
                        //                   MediaQuery.of(context).size.height *
                        //                       0.06,
                        //               child: Text("Buy Now"),
                        //               color: Colors.green,
                        //             )
                        //           ],
                        //         )),
                        //   )
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
  final double sales;
}
