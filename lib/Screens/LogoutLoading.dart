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
  String token;
  LogoutLoading({required this.token});

  @override
  _LogoutLoadingState createState() => _LogoutLoadingState();
}

class _LogoutLoadingState extends State<LogoutLoading> {
  Future<void> resetSharedPref(SharedPreferences prefs) async {
    // prefs.setString('access_token', '');
    // prefs.setString('fname', '');
    // prefs.setString('lname', '');
    // prefs.setString('phone', '');
    // prefs.setString('email', '');
    // prefs.setString("fcmToken", '');
    // prefs.setString("device_id", '');
    // prefs.setString('image', '');
    // prefs.setString('isYearlyPkg', '0');
    // prefs.setString('isFourMonthPkg', '0');
    // prefs.setString('isChairman', '0');
    // prefs.setString('yearly_pkg_sub_id', '');
    // prefs.setString('four_month_pkg_sub_id', '');
    // prefs.setString('chairman_pkg_sub_id', '');
    // prefs.setString('yearly_pkg_cancel_at', '');
    // prefs.setString('four_month_pkg_cancel_at', '');
    // prefs.setString('chairman_pkg_cancel_at', '');
    await prefs.clear();
    return Future.value();
  }

  Future Logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? deviceId = await PlatformDeviceId.getDeviceId;

    print("LOGOUT DEICE ID  $deviceId");

    var response = await http.get(
      Uri.parse(
        "https://app.greendiceinvestments.com/api/logout?device_id=$deviceId",
      ),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + widget.token,
        'Accept': 'application/json',
      },
    );
    print(response.body);
    // var data = json.decode(response.body);
    // LogoutModelClass logoutModelClass =
    //     LogoutModelClass.fromJson(jsonDecode(response.body));
    // var val = '${logoutModelClass.data!.message}';
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 401) {
      resetSharedPref(prefs).then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SigninScreen()),
            (route) => false);
      });
    }
    // print(val);
    // if (val == "0") {
    //   Fluttertoast.showToast(
    //     msg: val,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //   );
    // } else {
    //
    // }
  }

  @override
  void initState() {
    Logout() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        color: Color(0xff009E61),
        backgroundColor: Color(0xff0ECB82),
      ),
    ));
  }
}
