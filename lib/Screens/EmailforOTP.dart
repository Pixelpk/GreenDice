import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:greendice/ModelClasses/UserDataFromEmail.dart';
import 'package:greendice/Screens/OPTScreen.dart';
import 'package:http/http.dart' as http;
import 'HomeScreen.dart';
import 'SignupScreen.dart';
import '../ModelClasses/SigninUser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailforOTP extends StatefulWidget {

  EmailforOTP({required this.title, required this.fcm, required this.deviceId});

  final String fcm;
  final String deviceId;
  final String title;

  @override
  _EmailforOTPState createState() => _EmailforOTPState();

}

class _EmailforOTPState extends State<EmailforOTP> {

  bool _isObscure = true;

  var _formkey = GlobalKey<FormState>();

  bool loading = false;
  TextEditingController email = TextEditingController();

  Future login() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final prefs = await SharedPreferences.getInstance();

      var response = await http.post(
        Uri.parse("https://app.greendiceinvestments.com/api/forgotpassword"),
        body: {
          "email": email.text.trim(),
        },
      );

      var data = json.decode(response.body);
      UserDataFromEmail userDataFromEmail =
          UserDataFromEmail.fromJson(jsonDecode(response.body));
      var val = '${userDataFromEmail.success}';
      print(response.body);

      print(val);
      if (val == "0") {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
        Fluttertoast.showToast(
          msg: "User does not exists",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
        var access_token = '${userDataFromEmail.data!.token!.id}';
        var verification = '${userDataFromEmail.data!.token!.verificationCode}';

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OPTScreen(
                    title: access_token,
                    code: verification,
                    fcm: widget.fcm,
                    deviceId: widget.deviceId,
                  )),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(
                title: "SignupScreen",
                deviceid: widget.deviceId,
                fcm: widget.fcm,
              )),
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
      body: loading
          ? Center(
              child: CircularProgressIndicator(   color: Color(0xff009E61),
                backgroundColor: Color(0xff0ECB82),),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                            ),
                            Text(
                                "Please enter the email address to reset the password."),
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
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: ElevatedButton(
                                child: Text("Continue",
                                    style: TextStyle(fontSize: 14)),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xff009E61)),
                                    alignment: Alignment.center,
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            side: BorderSide(
                                              color: Color(0xff009E61),
                                            )))),
                                onPressed: () {

                                  if (_formkey.currentState!.validate()) {

                                    print('form validation ok');
                                    login();
                                  }



                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 290,
                        child: SizedBox(
                          width: 240,
                          height: 240,
                          child: Image.asset('assets/images/sign_logo.png'),
                        ),
                      ),
                      Positioned(
                        right: 100,
                        top: 100,
                        child: Column(children: [
                          Text(
                            "Forgot",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff005333),
                            ),
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff005333),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
