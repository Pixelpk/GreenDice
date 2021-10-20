import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greendice/Screens/EmailforOTP.dart';
import 'package:http/http.dart' as http;
import 'HomeScreen.dart';
import 'SignupScreen.dart';
import '../ModelClasses/SigninUser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isObscure = true;
  var _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController(text: 'raheelk740@gmail.com');
  TextEditingController pass = TextEditingController(text: '123456');

  bool isLoading = false;

  Future login() async {


    setState(() {
      isLoading = true;
    });

    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final prefs = await SharedPreferences.getInstance();

      var response = await http.post(
        Uri.parse("http://syedu12.sg-host.com/api/login"),
        body: {
        "email": email.text,
        "password": pass.text,
      },
        headers: <String, String>{
          'Accept': 'application/json',
        },
      );

      var data = json.decode(response.body);
      SigninUser signinUser = SigninUser.fromJson(jsonDecode(response.body));
      var val = '${signinUser.success}';



      print(response);
      if (val == "0") {

        if('${signinUser.message}' == "AccessDenied")
          {
            Fluttertoast.showToast(
              msg: "Incorrect email or password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          }
        else
          {
            Fluttertoast.showToast(
              msg: "Network error! Please check your internet connection and try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          }

      }
      else {

        var access_token = '${signinUser.data!.accessToken}';

        prefs.setString('access_token', access_token);
        prefs.setString('fname', signinUser.data!.user!.firstName!);
        prefs.setString('lname', signinUser.data!.user!.lastName!);
        prefs.setString('phone', signinUser.data!.user!.phone!);
        prefs.setString('email', signinUser.data!.user!.email!);
        prefs.setString('image', signinUser.data!.user!.photo!);


          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (BuildContext context) {
                return HomeScreen(title: access_token);
              },
            ),
                (_) => false,
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
          builder: (context) => SignupScreen(title: "SignupScreen")),
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
                          if (text!.isEmpty) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if(value.length > 0) {
                            setState(() {

                            });
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
                          if (!(text!.length > 5) && text!.isNotEmpty) {
                            return "Enter valid name of more then 5 characters!";
                          }
                          else if(!(text!.length > 1) && text!.isEmpty)
                            {
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

                          onTap: (){

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmailforOTP(title: "EmailforOTP")),
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
                            onPressed: isLoading ? null : () {

                              login().then((value) {

                                setState(() {
                                  isLoading = false;
                                });

                              });

                            },),
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
              ),
              Positioned(
                top: 0,
                right: 290,
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
                child: CircularProgressIndicator(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
