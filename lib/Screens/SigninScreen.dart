import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomeScreen.dart';
import 'SignupScreen.dart';
import '../ModelClasses/SigninUser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isObscure = true;

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();


  Future login()async{

    Fluttertoast.showToast(
      msg: email.text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );

    Fluttertoast.showToast(
      msg: pass.text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );


    var response = await http.post(Uri.parse("http://syedu12.sg-host.com/api/login"),body: {
      "email" : email.text,
      "password" : pass.text,
    });

    var data = json.decode(response.body);
    SigninUser signinUser = SigninUser.fromJson(jsonDecode(response.body));
    var val = '${signinUser.success}';

    print(val);
    if(val == "0")
    {
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    else
    {
      Fluttertoast.showToast(
        msg: response.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(title: "HomScreen")),
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
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff005333),
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
                          onPressed: () => login()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don`t have an account?",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(

                            onTap: (){

                              signup();
                            },


                            child: Text(
                              "  Signup",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
