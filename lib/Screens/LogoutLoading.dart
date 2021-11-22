import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/LogoutModelClass.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SigninScreen.dart';
class LogoutLoading extends StatefulWidget {
  String token ;
   LogoutLoading({required this.token}) ;

  @override
  _LogoutLoadingState createState() => _LogoutLoadingState();
}

class _LogoutLoadingState extends State<LogoutLoading> {
  String? fcmtoken ;
  late FirebaseMessaging messaging;
  String? device_id ;
  Future<String?> getDeviceId()
  {
    return PlatformDeviceId.getDeviceId;
  }
  _saveToken(String deviceId) async {

    String? fcm = await messaging.getToken();
    setState(() {
      fcmtoken = fcm ;
      device_id = deviceId ;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("fcmToken", fcm!);
  }

  Future<void> resetSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', '');
    prefs.setString('fname', '');
    prefs.setString('lname', '');
    prefs.setString('phone', '');
    prefs.setString('email', '');
    prefs.setString("fcmToken", '');
    prefs.setString('image', '');
    prefs.setString('isYearlyPkg',
        '0');
    prefs.setString('isFourMonthPkg',
        '0');
    prefs.setString('isChairman',
        '0');
    await prefs.clear();
    return Future.value();
  }
  Future Logout() async {


    var response = await http.get(
      Uri.parse("https://app.greendiceinvestments.com/api/logout"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + widget.token,
      },
    );

    var data = json.decode(response.body);
    LogoutModelClass logoutModelClass =
    LogoutModelClass.fromJson(jsonDecode(response.body));
    var val = '${logoutModelClass.data!.message}';

    print(val);
    if (val == "0") {
      Fluttertoast.showToast(
        msg: val,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      resetSharedPref().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => SigninScreen(title: "SigninScreen",devicerId: device_id,fcmTOken: fcmtoken,)),
                (route) => false);
      });
    }
  }
  @override
  void initState() {
    messaging = FirebaseMessaging.instance;
    getDeviceId().then((value){  _saveToken(value!);} );

    Logout();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: CircularProgressIndicator(
          color: Color(0xff009E61),
          backgroundColor: Color(0xff0ECB82),
        ),
      )
    );
  }
}
