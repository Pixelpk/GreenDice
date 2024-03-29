import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greendice/ModelClasses/PasswordAuthenticate.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:http/http.dart' as http;
import 'HomeScreen.dart';
import 'SignupScreen.dart';
import '../ModelClasses/SigninUser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordLogin extends StatefulWidget {
  ForgotPasswordLogin({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _ForgotPasswordLoginState createState() => _ForgotPasswordLoginState();
}

class _ForgotPasswordLoginState extends State<ForgotPasswordLogin> {
  bool _isObscure = true;
  bool _isObscure_confirm = true;
  bool loading = false;
  TextEditingController pass = TextEditingController();
  TextEditingController conf_pass = TextEditingController();

  Future login() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    if (pass.text == conf_pass.text) {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString('access_token') ?? '';

      var response = await http.post(
        Uri.parse("https://app.greendiceinvestments.com/api/updatepassword"),
        body: {
          "password": pass.text,
          "password_confirmation": conf_pass.text,
        },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + access_token,
        },
      );

      var data = json.decode(response.body);
      PasswordAuthenticate passwordAuthenticate =
          PasswordAuthenticate.fromJson(jsonDecode(response.body));
      var val = '${passwordAuthenticate.success}';
      var mess = '${passwordAuthenticate.message}';

      print(val);
      if (val == "0") {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
        Fluttertoast.showToast(
          msg: mess,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
        Fluttertoast.showToast(
          msg: "Password Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => SigninScreen(

                    )),
            (route) => false);
      }
    } else {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      Fluttertoast.showToast(
        msg: "Password fields does not match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff009E61),
                backgroundColor: Color(0xff0ECB82),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.55,
                            ),
                            TextField(
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
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextField(
                              controller: conf_pass,
                              obscureText: _isObscure_confirm,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure_confirm =
                                              !_isObscure_confirm;
                                        });
                                      }),
                                  hintText: 'Confrim Password',
                                  hintStyle: TextStyle(
                                    color: Color(0xff9B9B9B),
                                  )),
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
                                  child: Text("Update",
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
                                    if (pass.text.length < 6) {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Password must be atleast 6-digit long",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                      );
                                    } else if (pass.text != conf_pass.text) {
                                      Fluttertoast.showToast(
                                        msg: "Password must match",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                      );
                                    } else if (pass.text == conf_pass.text) {
                                      login();
                                    }
                                  }),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                          ],
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
                        right: 100,
                        top: 100,
                        child: Column(children: [
                          Text(
                            "Update",
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
