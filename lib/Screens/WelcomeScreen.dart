import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? fcmtoken ;
  late FirebaseMessaging messaging;
  String? device_id ;
  _saveToken() async {

    String? fcm = await messaging.getToken();
    String? deviceId = await PlatformDeviceId.getDeviceId;
    setState(() {
      fcmtoken = fcm ;
      device_id = deviceId ;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("fcmToken", fcm!);
  }

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    _saveToken();
    super.initState();
  }

  void signin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SigninScreen(title: "SigninScreen",devicerId: device_id,fcmTOken: fcmtoken,)),
    );


  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(title: "SignupScreen",deviceid: device_id,fcm: fcmtoken,)),
    );
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,
                ),
                Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xffffffff),
                  ),
                ),
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01,
                ),
                Text(
                  "Happy to see you here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xffffffff),
                  ),
                ),


                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .6,
                ),
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,


                    children: [


                      Column(children: [

                        SizedBox(

                          width: MediaQuery.of(context).size.width * 0.3,

                          child: ElevatedButton(
                              child: Text("Sign in".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                              style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.black),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                  alignment: Alignment.center,
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          side: BorderSide(color: Colors.white)))),
                              onPressed: () => signin()),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                              child: Text("Sign up  ".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                              style: ButtonStyle(
                                  foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.black),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                  alignment: Alignment.center,
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          side: BorderSide(color: Colors.white)))),
                              onPressed: () => signup()),
                        )
                      ]),


                     /* SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .height * .1,
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
