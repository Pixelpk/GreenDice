import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/LogoutModelClass.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'SigninScreen.dart';
class LogoutLoading extends StatefulWidget {
  String token ;
   LogoutLoading({required this.token}) ;

  @override
  _LogoutLoadingState createState() => _LogoutLoadingState();
}

class _LogoutLoadingState extends State<LogoutLoading> {
  Future<void> resetSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', '');
    prefs.setString('fname', '');
    prefs.setString('lname', '');
    prefs.setString('phone', '');
    prefs.setString('email', '');
    prefs.setString('image', '');
    prefs.setString('isYearlyPkg',
        '0');
    prefs.setString('isFourMonthPkg',
        '0');
    prefs.setString('isChairman',
        '0');
    return Future.value();
  }
  Future Logout() async {

    var response = await http.get(
      Uri.parse("http://syedu12.sg-host.com/api/logout"),
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
                builder: (context) => SigninScreen(title: "SigninScreen")),
                (route) => false);
      });
    }
  }
  @override
  void initState() {
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
