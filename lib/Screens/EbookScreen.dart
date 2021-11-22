import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/EBookModelClass.dart';
import 'package:greendice/Screens/HomeScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/UiComponents/NotificationListItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ModelClasses/notificationModelClass.dart';
import 'pdf_Viewer.dart';

class EbookScreen extends StatefulWidget {
  EbookScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _EbookScreenState createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  late List data = [];
  // late ScrollController _controller;
  EBookModelClass? eBookModelClass;

  bool isloading = false;

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
  void initState() {
    // _controller = ScrollController();
    // _controller.addListener(_scrollListener);
    super.initState();
    Signalapi().then((value) => {
          setState(() {
            this.eBookModelClass = value;
          }),
        });
  }

  Future<EBookModelClass> Signalapi() async {
    setState(() {
      isloading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final access_token = prefs.getString('access_token') ?? '';
    //print("token = "+access_token);
    var response = await http.post(
      Uri.parse("https://app.greendiceinvestments.com/api/ebooks"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + access_token,
      },
    );

    //  var data = json.decode(response.body);
    EBookModelClass eBookModelClass =
        EBookModelClass.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${eBookModelClass.success}';
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
    } else {
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

    return eBookModelClass;
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
                  /*Padding(

                    padding: EdgeInsets.fromLTRB(15,25,0,0),

                    child: InkWell(

                      onTap: (){

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(title: "HomScreen")),
                        );

                      },

                      child: Container(

                        width: MediaQuery.of(context).size.width * 0.035,
                        height: MediaQuery.of(context).size.height * 0.035  ,

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/images/back.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),


                      ),
                    ),
                  ),*/

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/images/back.png'),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),

                      /*   SizedBox(

                        width: MediaQuery.of(context).size.width * 1,

                      ),*/

                      Container(
                        margin: EdgeInsets.only(
                            left: 60, top: 0, right: 0, bottom: 0),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Ebooks",
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
                  child: isloading
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Color(0xff009E61),
                            backgroundColor: Color(0xff0ECB82),
                          )),
                        )
                      : eBookModelClass == null
                          ? Container()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: data == null
                                  ? 0
                                  : eBookModelClass!.data!.ebooks!.length,
                              itemBuilder: (BuildContext context, int index) {
                                /* return new Card(
                        child: new Text(notificationmodel!.data!.notificationSignal![index].horse!),
                      );*/
                                return InkWell(
                                  onTap: () async {
                                   try {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PDFOPENER(url: eBookModelClass!.data!.ebooks![index].fileName!,)));
                                      print("on tab ebook");
                                    }catch(e){
                                     Fluttertoast.showToast(
                                         msg: "Couldn't open this Ebook",
                                         toastLength: Toast.LENGTH_SHORT,
                                         gravity: ToastGravity.CENTER,
                                         backgroundColor: Color(0xFF009d60),
                                         textColor: Colors.white);
                                   }

                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
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
                                                    BorderRadius.circular(20.0),
                                                image: new DecorationImage(
                                                  image: new AssetImage(
                                                      "assets/images/winbg.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Image.asset(
                                                      "assets/images/horseimage.png"),
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                        ),
                                                        Text(
                                                            "E-book: " +
                                                                (index + 1)
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                color: Colors
                                                                    .white)),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Description: ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            ),
                                                            Text(
                                                                eBookModelClass!
                                                                    .data!
                                                                    .ebooks![
                                                                        index]
                                                                    .description!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
            ],
          ),
        ),
      ),
    );
  }
}
