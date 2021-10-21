import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/Screens/HomeScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/UiComponents/NotificationListItem.dart';
import 'package:http/http.dart' as http;
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
  // late ScrollController _controller;
  notifcationModelClass? notificationmodel;
  late String firstname = '', lastname = '', photo = '';
  late String access_token = '';
  bool isLoading = false;

  // _scrollListener() {
  //   if (_controller.offset >= _controller.position.maxScrollExtent &&
  //       !_controller.position.outOfRange) {
  //     setState(() {//you can do anything here
  //     });
  //   }
  //   if (_controller.offset <= _controller.position.minScrollExtent &&
  //       !_controller.position.outOfRange) {
  //     setState(() {//you can do anything here
  //     });
  //   }
  // }
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // _controller = ScrollController();
    // _controller.addListener(_scrollListener);
    super.initState();

    Loadprefs().then((value) => {
          Signalapi().then((value) => {
                setState(() {
                  this.notificationmodel = value;
                }),
              }),
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

  Future<notifcationModelClass> Signalapi() async {
    setState(() {
      isLoading = true;
    });
    //print("token = "+access_token);
    var response = await http.post(
      Uri.parse("http://syedu12.sg-host.com/api/signalnotifications"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + access_token,
      },
    );

    //  var data = json.decode(response.body);
    notifcationModelClass notificationmodel =
        notifcationModelClass.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${notificationmodel.success}';

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
      print('API STATUS SUCCESS');
      setState(() {
        isLoading = false;
      });
      return notificationmodel;
    } else {
      Fluttertoast.showToast(
        msg: "Error! Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      setState(() {
        isLoading = false;
      });
      return notificationmodel;
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
                                "assets/images/dashboardappbarimage.png"),
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
                              /*decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/profileicon.png"),
                                      fit: BoxFit.cover)),*/
                              child: photo == ''
                                  ? Image.asset(
                                      "assets/images/profileimage.png")
                                  : Image.network(
                                      photo,
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              child: Text(
                                firstname + " " + lastname,
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
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Color(0xff009E61),
                            backgroundColor: Color(0xff0ECB82),
                          ))
                        : notificationmodel != null ? ListView.builder(
                            // controller: _controller,
                            shrinkWrap: true,
                            itemCount: data == null
                                ? 0
                                : notificationmodel!
                                    .data!.notificationSignal!.length,
                            itemBuilder: (BuildContext context, int index) {
                              /* return new Card(
                          child: new Text(notificationmodel!.data!.notificationSignal![index].horse!),
                        );*/
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.7,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            image: new DecorationImage(
                                              image: new AssetImage(
                                                  "assets/images/notifItembg.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 100),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Container(
                                            child: SvgPicture.asset(
                                              "assets/images/dateBar.svg",
                                            ),
                                            // decoration: new BoxDecoration(
                                            //   image: new DecorationImage(
                                            //     image: new AssetImage(
                                            //         "assets/images/datebar.png"),
                                            //     fit: BoxFit.cover,
                                            //   ),
                                            // ),
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            "Signal " + (index + 1).toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 150, horizontal: 20),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/flags.svg",
                                                        color:
                                                            Color(0xff009E61),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                      ),
                                                      Text(
                                                        notificationmodel!
                                                            .data!
                                                            .notificationSignal![
                                                                index]
                                                            .location!,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/playbutton.svg",
                                                        color:
                                                            Color(0xff009E61),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                      ),
                                                      Text(
                                                        notificationmodel!
                                                            .data!
                                                            .notificationSignal![
                                                                index]
                                                            .raceId
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/peoples.svg",
                                                        color:
                                                            Color(0xff009E61),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                      ),
                                                      Text(
                                                        notificationmodel!
                                                            .data!
                                                            .notificationSignal![
                                                                index]
                                                            .horse!,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.30,
                                              ),
                                              Column(
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
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    monthselector(
                                                        notificationmodel!
                                                            .data!
                                                            .notificationSignal![
                                                                index]
                                                            .signalDate!
                                                            .split('-')[1]),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                  /* Text(
                                                  "August",s
                                                  style: TextStyle(fontSize: 15, color: Colors.white),
                                                )*/
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        top: 260,
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
                                                    BorderRadius.circular(10.0),
                                                color: Color(0xffffffff),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/horseimage.png"),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          "Was sound in a recent jumpout, then running nice time on debut this 2yo Gelding, "
                                                          "son of ( Fastnet Rock ), all being on a Heavy track, he can use the inside gate , "
                                                          "as he has nice gate speed , settle behind leaders, look to be running on.",
                                                          textAlign:
                                                              TextAlign.left),
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
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
                                                                  fontSize: 10,
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
                                                                  fontSize: 30,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          10),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  color: Color(
                                                                      0xff485469),
                                                                ),
                                                                width: 50,
                                                                height: 25,
                                                                child: Center(
                                                                    child: Text(
                                                                  notificationmodel!
                                                                      .data!
                                                                      .notificationSignal![
                                                                          index]
                                                                      .profit!,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
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
                                ),
                              );
                            },
                          ):Container()),
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
