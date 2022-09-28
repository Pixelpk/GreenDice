import 'dart:convert';
import 'dart:io';

import 'package:configurable_expansion_tile_null_safety/configurable_expansion_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/CalDataModelClass.dart';
import 'package:greendice/Screens/HomeScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/UiComponents/NotificationListItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ModelClasses/notificationModelClass.dart';
import 'LogoutLoading.dart';

class CalendarDataScreen extends StatefulWidget {
  CalendarDataScreen({Key? key, required this.title, this.selectedDate})
      : super(key: key);
  String title;
  final String? selectedDate;

  @override
  _CalendarDataScreenState createState() => _CalendarDataScreenState();
}

class _CalendarDataScreenState extends State<CalendarDataScreen> {
  late List data = [];

  CalDataModelClass? notificationmodel;

  bool isloading = true;
  bool noDataFound = false;

  String? trophyImage = 'assets/images/loss.svg';
  @override
  void initState() {
    super.initState();
    // _controller = ScrollController();
    // _controller.addListener(_scrollListener);

    Signalapi().then((value) => {
          setState(() {
            this.notificationmodel = value;
            isloading = false;
          }),
        });
  }

  String profitCalculator({String? odds, var raceStatus}) {
    try {
      if (raceStatus == 1) {
        if (odds != null) {
          double oddsvalue = (double.parse(odds) - 1) * 100;

          print("ODDS VALUE $oddsvalue");
          return oddsvalue.toStringAsFixed(0);
        } else {
          return '0';
        }
      } else {
        return '100';
      }
    } catch (e) {
      return '0';
    }
  }

  Future<CalDataModelClass> Signalapi() async {
    final prefs = await SharedPreferences.getInstance();
    final access_token = prefs.getString('access_token') ?? '';
    //  print("token = "+access_token);
    var response = await http.post(
        Uri.parse("https://app.greendiceinvestments.com/api/calendar"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + access_token,
        },
        body: {
          "signal_date": widget.title.toString(),
        });

    //  var data = json.decode(response.body);
    CalDataModelClass notificationmodel =
        CalDataModelClass.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${notificationmodel.success}';

    // this.setState(() {});

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
      setState(() {
        noDataFound = false;
      });
    } else {
      if (response.body.contains("Unauthenticated.")) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => LogoutLoading(token: access_token)),
            (route) => false);
      }
      setState(() {
        noDataFound = true;
      });
    }

    return notificationmodel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.21,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/dashboardappbarimage.png"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      IconButton(
                        icon: Image.asset('assets/images/back.png'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 60, top: 0, right: 0, bottom: 0),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Race Data",
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
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  color: Color(0xff009E61),
                  child: Center(
                    child: Text(
                      "Result of ${widget.selectedDate!}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                isloading
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff009E61),
                          backgroundColor: Color(0xff0ECB82),
                        )),
                      )
                    : noDataFound
                        ? noDataWidget()
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data == null
                                  ? 0
                                  :

                                  ///NULL CHECK
                                  (notificationmodel!.data != null &&
                                          notificationmodel!
                                                  .data!.calenderSignal !=
                                              null)
                                      ? notificationmodel!
                                          .data!.calenderSignal!.length
                                      : 0,
                              itemBuilder: (BuildContext context, int index) {
                                if (notificationmodel!.data!
                                        .calenderSignal![index].placing! ==
                                    '1') {
                                  trophyImage =
                                      'assets/images/goldertrophy.svg';
                                } else if (notificationmodel!.data!
                                        .calenderSignal![index].placing! ==
                                    '2') {
                                  trophyImage =
                                      'assets/images/silver_trophy.svg';
                                } else if (notificationmodel!.data!
                                        .calenderSignal![index].placing! ==
                                    '3') {
                                  trophyImage =
                                      'assets/images/bronzetrophy.svg';
                                } else if (notificationmodel!.data!
                                        .calenderSignal![index].placing! ==
                                    '4') {
                                  trophyImage = 'assets/images/loss.svg';
                                }

                                return ConfigurableExpansionTile(
                                  onExpansionChanged: (e) {
                                    print(e);
                                    if (notificationmodel!.data!
                                            .calenderSignal![index].status ==
                                        0) {
                                      setState(() {
                                        notificationmodel!
                                            .data!
                                            .calenderSignal![index]
                                            .isexpanded = e;
                                      });
                                    }
                                  },
                                  // expandedBackgroundColor: Colors.green[100],
                                  // headerExpanded: Flexible(child: Center(child: Text("A Header Changed"))),
                                  header: Container(
                                    // height:
                                    //     MediaQuery.of(context).size.height * 0.3,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        bottom: notificationmodel!
                                                    .data!
                                                    .calenderSignal![index]
                                                    .status ==
                                                0
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.042
                                            : 5),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Stack(
                                        overflow: Overflow.visible,
                                        alignment: Alignment.topCenter,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                image: new DecorationImage(
                                                  image: notificationmodel!
                                                              .data!
                                                              .calenderSignal![
                                                                  index]
                                                              .status ==
                                                          1
                                                      ? AssetImage(
                                                          "assets/images/winbg.png")
                                                      : notificationmodel!
                                                                  .data!
                                                                  .calenderSignal![
                                                                      index]
                                                                  .status ==
                                                              0
                                                          ? AssetImage(
                                                              "assets/images/losebg.png")
                                                          : AssetImage(
                                                              "assets/images/scratchbg.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  flex: 4, child: SizedBox()),
                                              Expanded(
                                                flex: 18,
                                                child: Container(
                                                  child: Image.asset(
                                                      "assets/images/horseimage.png"),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 4, child: SizedBox()),
                                              Expanded(
                                                flex: 45,
                                                child: Container(
                                                  //  color:Colors.amber,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,

                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 10,
                                                        child: Container(),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                            notificationmodel!
                                                                .data!
                                                                .calenderSignal![
                                                                    index]
                                                                .location!,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                      // SizedBox(
                                                      //   height: MediaQuery.of(context)
                                                      //           .size
                                                      //           .height *
                                                      //       0.02,
                                                      // ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                        flex: 10,
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/images/white_flag.svg",
                                                              color:
                                                                  Colors.white,
                                                              height: 14,
                                                              width: 14,
                                                            ),
                                                            // Image.asset(
                                                            //     "assets/images/flagwhite.png"),
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  Container(),
                                                            ),
                                                            Expanded(
                                                              flex: 19,
                                                              child: Text(
                                                                notificationmodel!
                                                                    .data!
                                                                    .calenderSignal![
                                                                        index]
                                                                    .location!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                        flex: 10,
                                                        child: Row(
                                                          children: [
                                                            // Image.asset(
                                                            //     "assets/images/playwhite.png"),
                                                            SvgPicture.asset(
                                                              "assets/images/white_play.svg",
                                                              color:
                                                                  Colors.white,
                                                              height: 14,
                                                              width: 14,
                                                            ),
                                                            SizedBox(
                                                                width: 8.0),
                                                            Text(
                                                                "Race " +
                                                                    notificationmodel!
                                                                        .data!
                                                                        .calenderSignal![
                                                                            index]
                                                                        .raceId
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                        flex: 10,
                                                        child: Row(
                                                          children: [
                                                            // Image.asset(
                                                            //     "assets/images/personw.png"),
                                                            SvgPicture.asset(
                                                              "assets/images/white_person.svg",
                                                              color:
                                                                  Colors.white,
                                                              height: 14,
                                                              width: 14,
                                                            ),
                                                            SizedBox(
                                                                width: 8.0),
                                                            Text(
                                                                notificationmodel!
                                                                    .data!
                                                                    .calenderSignal![
                                                                        index]
                                                                    .horse!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 10,
                                                        child: Container(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1, child: SizedBox()),
                                              Expanded(
                                                flex: 30,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 10, 0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.03,
                                                      ),
                                                      Text(
                                                        "Current market odds",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        '' +
                                                            notificationmodel!
                                                                .data!
                                                                .calenderSignal![
                                                                    index]
                                                                .oods!,
                                                        style: TextStyle(
                                                            fontSize: 40,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                4.0),
                                                          ),
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                          "${profitCalculator(odds: notificationmodel!.data!.calenderSignal![index].oods, raceStatus: notificationmodel!.data!.calenderSignal![index].status)}%",
                                                          // notificationmodel!
                                                          //         .data!
                                                          //         .calenderSignal![
                                                          //             index]
                                                          //         .roi! +
                                                          //     '%',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        )),
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    4.0),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                notificationmodel!
                                                                    .data!
                                                                    .calenderSignal![
                                                                        index]
                                                                    .placing!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                          ),
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    4.0),
                                                              ),
                                                            ),
                                                            child: SvgPicture
                                                                .asset(
                                                              trophyImage!,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1, child: SizedBox()),
                                            ],
                                          ),
                                          notificationmodel!
                                                      .data!
                                                      .calenderSignal![index]
                                                      .status ==
                                                  0
                                              ? Positioned(
                                                  bottom: -MediaQuery.of(
                                                              context)
                                                          .size
                                                          .height *
                                                      0.055, //MediaQuery.of(context)
                                                  //     .size
                                                  //     .height *
                                                  // 0.221 +
                                                  // 50,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.88,
                                                    color: notificationmodel!
                                                            .data!
                                                            .calenderSignal![
                                                                index]
                                                            .isexpanded!
                                                        ? Colors.green[100]
                                                        : Colors.transparent,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.15),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.055,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xff344455),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          22),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          22))),
                                                      child: Center(
                                                          child: Text(
                                                        "Race Comment",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ))
                                              : Container(
                                                  height: 0,
                                                  width: 0,
                                                )
                                        ],
                                      ),
                                    ),
                                  ),

                                  children: [
                                    notificationmodel!
                                                .data!
                                                .calenderSignal![index]
                                                .status ==
                                            0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              color: Colors.green[100],
                                            ),
                                            margin: EdgeInsets.zero,
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.88,
                                            child: Text(
                                                "${notificationmodel!.data!.calenderSignal![index].comment}"))
                                        : Container(
                                            height: 0,
                                            width: 0,
                                          )
                                    // + more params, see example !!
                                  ],
                                );
                              },
                            ),
                          ),
              ],
            )),
      ),
    );
  }

  Widget noDataWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Center(
        child: Text('No Race Record'),
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
