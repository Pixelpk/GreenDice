import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/constants.dart';
import 'package:greendice/ModelClasses/SigninUser.dart';
import 'package:greendice/Screens/EmailforOTP.dart';
import 'package:http/http.dart' as http;
import 'package:platform_device_id/platform_device_id.dart';
import 'HomeScreen.dart';
import 'SignupScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);



  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isObscure = true;
  late FirebaseMessaging messaging;
  var _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool isLoading = false;

  Future login() async {
    final prefs = await SharedPreferences.getInstance();
    String? fcm = await messaging.getToken();
    String? deviceId = await PlatformDeviceId.getDeviceId;

    print("FCM-TOKEN : $fcm}");
    print("DeviceID $deviceId");

    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      var response = await http.post(
        Uri.parse("https://app.greendiceinvestments.com/api/login"),
        body: {
          "email": email.text.trim(),
          "password": pass.text,
          'fcm_token': fcm,
          "device_id": deviceId,
        },
        headers: <String, String>{
          'Accept': 'application/json',
        },
      );

print(response.body);
      SigninUser signinUser = SigninUser.fromJson(jsonDecode(response.body));
      var val = '${signinUser.success}';

      print(response);
      if (val == "0") {
        if(response.body.contains('User account is deactivated'))
          {
            Fluttertoast.showToast(
              msg: "Your account is deactivated",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          }
        else if (response.body.contains("Wrong credentials")) {
          Fluttertoast.showToast(
            msg: "Incorrect email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        } else {
          Fluttertoast.showToast(
            msg:
                "Network error! Please check your internet connection and try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      } else {
        var access_token = '${signinUser.data!.accessToken}';
        prefs.setString('access_token', access_token);
        prefs.setString('fname', signinUser.data!.user!.firstName!);
        prefs.setString('lname', signinUser.data!.user!.lastName!);
        prefs.setString('phone', signinUser.data!.user!.phone!);
        prefs.setString('email', signinUser.data!.user!.email!);
        prefs.setString('image', signinUser.data!.user!.photo!);
        prefs.setString('device_id', deviceId ?? '');
        prefs.setString("fcmToken", fcm!);
        prefs.setString(
            'yearly_pkg_sub_id', signinUser.data!.user!.yearlyPkgSubId!);
        prefs.setString(
            'four_month_pkg_sub_id', signinUser.data!.user!.fourMonthPkgSubId!);
        prefs.setString(
            'chairman_pkg_sub_id', signinUser.data!.user!.chairmanPkgSubId!);
        prefs.setString(
            'yearly_pkg_cancel_at', signinUser.data!.user!.yearlyPkgCancelAt!);
        prefs.setString('four_month_pkg_cancel_at',
            signinUser.data!.user!.fourMonthPkgCancelAt!);
        prefs.setString('chairman_pkg_cancel_at',
            signinUser.data!.user!.chairmanPkgCancelAt!);
        prefs.setString(
            'isYearlyPkg', signinUser.data!.user!.isYearlyPkg.toString());
        prefs.setString(
            'isFourMonthPkg', signinUser.data!.user!.isFourMonthPkg.toString());
        prefs.setString(
            'isChairman', signinUser.data!.user!.isChairman.toString());
        bool ispremiumUser = signinUser.data!.user!.isYearlyPkg == 1
            ? true
            : signinUser.data!.user!.isFourMonthPkg == 1
                ? true
                : false;
        print(
            "${signinUser.data!.user!.isYearlyPkg.toString()}  $ispremiumUser");
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (BuildContext context) {
              return HomeScreen(
                title: access_token,
                ispremiumUser: ispremiumUser,
              );
            },
          ),
          (_) => false,
        );
      }
    }
  }

  @override
  void initState() {
    messaging = FirebaseMessaging.instance;

    super.initState();
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(
                title: "SignupScreen",
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xff9B9B9B),
                            )),
                        validator: (text) {
                          if (EmailValidator.validate(text!.trim())) {
                            return null;
                          }
                          return "Please enter valid email";
                        },
                        onChanged: (value) {
                          if (value.length > 0) {
                            setState(() {});
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: pass,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Color(0xff9B9B9B),
                            )),
                        validator: (text) {
                          if (!(text!.length > 5) && text.isNotEmpty) {
                            return "Password Length should be at-least 6-digit";
                          } else if (!(text.length > 1) && text.isEmpty) {
                            return "Please enter a valid password";
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: MediaQuery.of(context).size.width * 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmailforOTP(
                                        title: "EmailforOTP",
                                      )),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff005333),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                          child: Text("Login", style: TextStyle(fontSize: 14)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff009E61)),
                              alignment: Alignment.center,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(
                                        color: Color(0xff009E61),
                                      )))),
                          onPressed: isLoading
                              ? null
                              : () {
                                  login().then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.018,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don`t have an account?",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                signup();
                              },
                              child: Text(
                                "  Signup",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff005333),
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: MediaQuery.of(context).size.width * 0.7,
                child: SizedBox(
                  width: 240,
                  height: 240,
                  child: Image.asset('assets/images/sign_logo.png'),
                ),
              ),
              Positioned(
                right: 0,
                top: 100,
                left: 0,
                child: Column(children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff005333),
                    ),
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff005333),
                    ),
                  ),
                ]),
              ),
              Visibility(
                visible: isLoading,
                child: CircularProgressIndicator(
                  color: Color(0xff009E61),
                  backgroundColor: Color(0xff0ECB82),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
