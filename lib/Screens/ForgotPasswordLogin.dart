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
  ForgotPasswordLogin({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  _ForgotPasswordLoginState createState() => _ForgotPasswordLoginState();
}

class _ForgotPasswordLoginState extends State<ForgotPasswordLogin> {
  bool _isObscure = true;
  bool _isObscure_confirm = true;

  TextEditingController pass = TextEditingController();
  TextEditingController conf_pass = TextEditingController();


  Future login()async{



    if(pass.text == conf_pass.text) {
      final prefs = await SharedPreferences.getInstance();
      final access_token = prefs.getString('access_token') ?? '';

      var response = await http.post(
        Uri.parse("http://syedu12.sg-host.com/api/updatepassword"), body: {
        "password": pass.text,
        "password_confirmation": conf_pass.text,
      },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + access_token,
        },
      );

      var data = json.decode(response.body);
      PasswordAuthenticate passwordAuthenticate = PasswordAuthenticate.fromJson(
          jsonDecode(response.body));
      var val = '${passwordAuthenticate.success}';
      var mess = '${passwordAuthenticate.message}';


      print(val);
      if (val == "0") {
        Fluttertoast.showToast(
          msg: mess,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
      else {
        Fluttertoast.showToast(
          msg: "Password Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SigninScreen(title: "SigninScreen")),
        );
      }
    }
    else
      {
        Fluttertoast.showToast(
          msg: "Password fields does not match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
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
          builder: (context) => SignupScreen(title: "SignupScreen")),
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
          child: Stack(
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
                                  _isObscure_confirm = !_isObscure_confirm;
                                });
                              }),
                          hintText: 'Confrim Password',
                          hintStyle: TextStyle(
                            color: Color(0xff9B9B9B),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                          child: Text("Update", style: TextStyle(fontSize: 14)),
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
                          onPressed: () => login()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),

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
    );
  }
}
