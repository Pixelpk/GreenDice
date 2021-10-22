import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greendice/Screens/PaymentScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/Screens/SubscriptionPlanScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembershipPage extends StatefulWidget {
  MembershipPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  late String firstname = '', lastname = '', photo = '';
  late final access_token;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    Loadprefs();
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

  void signin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SigninScreen(title: "SigninScreen")),
    );
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(title: "SignupScreen")),
    );
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
        child: isLoading
            ? CircularProgressIndicator(
                color: Color(0xff009E61),
                backgroundColor: Color(0xff0ECB82),
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
                                      "assets/images/membershipimage.png"),
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
                                              fit: BoxFit.cover,
                                              image: new AssetImage(
                                                  "assets/images/profileimage.png"),
                                            ),
                                          ),
                                        )
                                      : Container(
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
                                              fit: BoxFit.cover,
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
                                "Membership",
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Stack(
                            overflow: Overflow.visible,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: new Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Center(
                                    child: Text(
                                      "Was sound in a recent jumpout, then running nice time on debut this 2yo Gelding, son of ( Fastnet Rock ), all being on a Heavy track, he can use the inside gate , as he has nice gate speed , settle behind leaders, look to be running on.",
                                      style: TextStyle(),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          "assets/images/membership_bg1.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Color(0xff009E61),
                                  child: Row(
                                    children: [
                                      Text(
                                        "     Classic Annual",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Container(
                                                  // decoration: new BoxDecoration(
                                                  //   image: new DecorationImage(
                                                  //     image: new AssetImage(
                                                  //         "assets/images/goldcrownbg.png"),
                                                  //     fit: BoxFit.cover,
                                                  //   ),
                                                  // ),
                                                  child: SvgPicture.asset(
                                                    "assets/images/goldMembership.svg",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 15,
                                            left: 30,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "\$1550",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xffffffff),
                                                  ),
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
                              Positioned(
                                top: 160,
                                right: 10,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: ElevatedButton(
                                      child: Text("Subscribe",
                                          style: TextStyle(fontSize: 14)),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xffA40303)),
                                          alignment: Alignment.center,
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  side: BorderSide(
                                                    color: Color(0xffA40303),
                                                  )))),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SubscriptionPlanScreen()));
                                      }),
                                ),
                              ),
                            ],
                          ),
                          /* SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          child: new Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/membership_bg2.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),*/
                        ]),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.00,
                          ),
                          Stack(
                            overflow: Overflow.visible,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: new Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Center(
                                    child: Text(
                                      "Was sound in a recent jumpout, then running nice time on debut this 2yo Gelding, son of ( Fastnet Rock ), all being on a Heavy track, he can use the inside gate , as he has nice gate speed , settle behind leaders, look to be running on.",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          "assets/images/membership_bg2.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Color(0xff009E61),
                                  child: Row(
                                    children: [
                                      Text(
                                        "     Chairman`s Club",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Container(
                                                  // decoration: new BoxDecoration(
                                                  //   image: new DecorationImage(
                                                  //     image: new AssetImage(
                                                  //         "assets/images/silvercrownbg.png"),
                                                  //     fit: BoxFit.cover,
                                                  //   ),
                                                  // ),
                                                  child: SvgPicture.asset(
                                                    "assets/images/silverMembership.svg",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 15,
                                            left: 30,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "\$220",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xffffffff),
                                                  ),
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
                              Positioned(
                                top: 160,
                                right: 10,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: ElevatedButton(
                                      child: Text("Subscribe",
                                          style: TextStyle(fontSize: 14)),
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xffA40303)),
                                          alignment: Alignment.center,
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  side: BorderSide(
                                                    color: Color(0xffA40303),
                                                  )))),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    SubscriptionPlanScreen()));
                                      }),
                                ),
                              ),
                            ],
                          ),
                          /* SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          child: new Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/membership_bg2.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),*/
                        ]),
                      ),
                    ),
                    /////TEMPORARAY//////////////////////
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
