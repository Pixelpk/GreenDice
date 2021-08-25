import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomeScreen.dart';
import 'SigninScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  Future register() async {
    Fluttertoast.showToast(
      msg: user.text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );

    Fluttertoast.showToast(
      msg: email.text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );

    Fluttertoast.showToast(
      msg: phone.text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );

    Fluttertoast.showToast(
      msg: pass.text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );

    Fluttertoast.showToast(
      msg: confirmpass.text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );

    var response = await http
        .post(Uri.parse("http://syedu12.sg-host.com/api/register"), body: {
      "first_name": user.text,
      "last_name": user.text,
      "email": email.text,
      "phone": phone.text,
      "password": pass.text,
      "password_confirmation": confirmpass.text,
    });

    var data = json.decode(response.body);
    if (data == "0") {
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(title: "HomScreen")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void signin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SigninScreen(title: "SigninScreen")),
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
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                    TextField(
                      controller: user,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Color(0xff9B9B9B),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Color(0xff9B9B9B),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      controller: phone,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            color: Color(0xff9B9B9B),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      controller: pass,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0xff9B9B9B),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextField(
                      controller: confirmpass,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(
                            color: Color(0xff9B9B9B),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                          child: Text("Sign Up".toUpperCase(),
                              style: TextStyle(fontSize: 14)),
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
                          onPressed: () => register()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already a user?",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              signin();
                            },
                            child: Text(
                              "  Login",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff005333),
                              ),
                            ),
                          ),
                        ])
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
                    "Create",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff005333),
                    ),
                  ),
                  Text(
                    "Account",
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
