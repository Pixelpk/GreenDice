import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/Pages/MembershipPage.dart';
import 'package:greendice/Screens/LogoutLoading.dart';
import 'package:greendice/Screens/ProfileScreen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ModelClasses/notificationModelClass.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List data = [];
  NotificationModel? notificationmodel;
  late String firstname = '', lastname = '', photo = '';
  late String access_token = '';
  bool isLoading = false;

  List<String> _shirtImagesList = [
    'assets/images/shirt1.svg',
    'assets/images/shirt2.svg',
    'assets/images/shirt3.svg',
    'assets/images/shirt4.svg',
    'assets/images/shirt5.svg',
    'assets/images/shirt6.svg',
  ];
  ImageProvider? headerBackGroundImage;
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _controller = ScrollController();
    // _controller.addListener(_scrollListener);
    headerBackGroundImage =
        AssetImage("assets/images/dashboardappbarimage.png");
    super.initState();

    Loadprefs().then((value) {
      print("IS PREMIUMS IN SIGNAL SCREEN $ispremium");
      if (ispremium) {
        Signalapi().then((value) => {
              if (mounted)
                {
                  setState(() {
                    this.notificationmodel = value;
                  }),
                }
            });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(headerBackGroundImage!, context);
  }

  String isYearlyPkg = '0';
  String isFourMonthPkg = '0';
  String isCharmans = '0';
  String YearlyPkgepirydate = '';
  String fourMonthlyPkgepirydate = '';
  String chairmanPkgepirydate = '';
  ///PAYMENT
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

  Future<NotificationModel> Signalapi() async {
    setState(() {
      isLoading = true;
    });
    //print("token = "+access_token);
    var response = await http.post(
      Uri.parse("https://app.greendiceinvestments.com/api/signalnotifications"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + access_token,
        'Accept': 'application/json',
      },
    );
    // print(response.body);
    //  var data = json.decode(response.body);
    NotificationModel notificationmodel =
        NotificationModel.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${notificationmodel.success}';

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    // print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
      print('API STATUS SUCCESS');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return notificationmodel;
    } else {
      if (response.body.contains("Unauthenticated.")) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => LogoutLoading(token: access_token)),
            (route) => false);
      }
      Map<String, dynamic> errorModel = jsonDecode(response.body);

      print('message: ${errorModel["message"]}');

      // Fluttertoast.showToast(
      //   msg: errorModel["message"],
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      // );
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return NotificationModel();
      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(title: "HomScreen")),
      );*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.21,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: headerBackGroundImage!, fit: BoxFit.cover)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                            image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/profileimage.png"),
                                            ))),
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
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                //             fontSize: 12, color: Colors.white),
                                //       )
                                //     : Container(),
                                // YearlyPkgepirydate != '' &&
                                //         YearlyPkgepirydate != null
                                //     ? Text(
                                //         "Subscription end at: ${DateFormat.yMd().format(DateTime.parse(YearlyPkgepirydate))}",
                                //         style: TextStyle(
                                //             fontSize: 12, color: Colors.white),
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
                                // chairmanPkgepirydate != null &&
                                //         chairmanPkgepirydate != ''
                                //     ? Text(
                                //         "Chairman's Subscription Expiry: ${DateFormat.yMd().format(DateTime.parse(fourMonthlyPkgepirydate))}",
                                //         style: TextStyle(
                                //             fontSize: 12, color: Colors.white),
                                //       )
                                //     : Container()

                                ///TODO CHAIRMANS PACKAGES HANDLING
                              ],
                            ),

                            /*   SizedBox(

                        width: MediaQuery.of(context).size.width * 1,

                      ),*/
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 60, top: 0, right: 0, bottom: 0),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Dashboard",
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
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Center(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Color(0xff009E61),
                            backgroundColor: Color(0xff0ECB82),
                          ))
                        : ispremium
                            ? notificationmodel != null &&
                                    notificationmodel!.data != null &&
                                    notificationmodel!
                                            .data!.notificationSignal !=
                                        null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    padding: EdgeInsets.all(16.0),
                                    itemCount: notificationmodel!
                                        .data!.notificationSignal!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Stack(
                                          overflow: Overflow.visible,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.7,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  image: new DecorationImage(
                                                    image: new AssetImage(
                                                        "assets/images/notifItembg.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 100),
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.03,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  child: SvgPicture.asset(
                                                    "assets/images/dateBar.svg",
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 50, horizontal: 30),
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.09,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  "Signal " +
                                                      (index + 1).toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 150,
                                                  horizontal: 20),
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 40,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/flags.svg",
                                                                color: Color(
                                                                    0xff009E61),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.03,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  notificationmodel!
                                                                      .data!
                                                                      .notificationSignal![
                                                                          index]
                                                                      .location!,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 3,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // SizedBox(
                                                          //   height: MediaQuery.of(
                                                          //               context)
                                                          //           .size
                                                          //           .height *
                                                          //       0.02,
                                                          // ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/playbutton.svg",
                                                                color: Color(
                                                                    0xff009E61),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.03,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  notificationmodel!
                                                                      .data!
                                                                      .notificationSignal![
                                                                          index]
                                                                      .raceId
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // SizedBox(
                                                          //   height: MediaQuery.of(
                                                          //               context)
                                                          //           .size
                                                          //           .height *
                                                          //       0.02,
                                                          // ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/images/peoples.svg",
                                                                color: Color(
                                                                    0xff009E61),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.03,
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          2),
                                                                  child: Text(
                                                                    notificationmodel!
                                                                        .data!
                                                                        .notificationSignal![
                                                                            index]
                                                                        .horse!,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 3,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   width:
                                                    //       MediaQuery.of(context)
                                                    //               .size
                                                    //               .width *
                                                    //           0.30,
                                                    // ),
                                                    Expanded(
                                                      flex: 8,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            notificationmodel!
                                                                .data!
                                                                .notificationSignal![
                                                                    index]
                                                                .signalDate!
                                                                .split('-')[2],
                                                            style: TextStyle(
                                                                fontSize: 30,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            monthselector(
                                                                notificationmodel!
                                                                    .data!
                                                                    .notificationSignal![
                                                                        index]
                                                                    .signalDate!
                                                                    .split(
                                                                        '-')[1]),
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          /* Text(
                                                "August",s
                                                style: TextStyle(fontSize: 15, color: Colors.white),
                                              )*/
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.42,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: Color(0xffffffff),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 5),
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            child: Image.asset(
                                                              'assets/images/horse.jpeg',
                                                              width: 72,
                                                              height: 72,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.03,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Text(
                                                                notificationmodel!
                                                                    .data!
                                                                    .notificationSignal![
                                                                        index]
                                                                    .comment!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -40,
                                              left: 0,
                                              right: 0,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Stack(
                                                    children: [
                                                      Image.asset(
                                                          "assets/images/bottombarbg.png"),
                                                      Positioned(
                                                          left: 70,
                                                          right: 0,
                                                          top: 10,
                                                          bottom: 0,
                                                          child: Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "Current market odds",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Text(
                                                                    notificationmodel!
                                                                        .data!
                                                                        .notificationSignal![
                                                                            index]
                                                                        .oods!,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            30,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                        color: Color(
                                                                            0xff485469),
                                                                      ),
                                                                      width: 50,
                                                                      // height:
                                                                      //     25,
                                                                      child: Center(
                                                                          child: Text(
                                                                        notificationmodel!.data!.notificationSignal![index].profit != null &&
                                                                                notificationmodel!.data!.notificationSignal![index].profit != ''
                                                                            ? double.parse(notificationmodel!.data!.notificationSignal![index].profit!).toStringAsFixed(2)
                                                                            : '0.0',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.white),
                                                                      )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    child: Text('No Signals Data found'),
                                  )
                            : Center(
                                child: Container(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ///PAYMENT

                                    Text('No Data Found'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        ///PAYMENT

                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (_) =>
                                        //             MembershipPage()));
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      child: Text("No Data Available"),
                                      color: Colors.green,
                                    )
                                  ],
                                )),
                              )),
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
