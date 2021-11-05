import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomeScreen.dart';
import 'SigninScreen.dart';
import '../ModelClasses/SignupUser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  String ? fcm ;
  String? deviceid;
  SignupScreen({Key? key, required this.title,required this.fcm,required this.deviceid}) : super(key: key);

  final String title;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _formkey = GlobalKey<FormState>();

  TextEditingController user = TextEditingController();
  TextEditingController user_lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  bool isLoading = false;

  Future register() async {

    final isValid = _formkey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      if(pass.text!=confirmpass.text)
        {
          Fluttertoast.showToast(
              msg: "Password doesn't match",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Color(0xFF009d60),
              textColor: Colors.white);
        }
      else {
        if(mounted) {
          setState(() {
            isLoading = true;
          });
        }

        var response = await http
            .post(Uri.parse("https://app.greendiceinvestments.com/api/register"), body: {
          "first_name": user.text,
          "last_name": user_lname.text,
          "email": email.text.trim(),
          "phone": phone.text,
          "password": pass.text,
          "password_confirmation": confirmpass.text,
        });

        var data = json.decode(response.body);
        SignupUser signupScreen =
            SignupUser.fromJson(jsonDecode(response.body));
        print('${signupScreen.success}');
        var val = '${signupScreen.success}';

        if (val == "0") {
          if(mounted) {
            setState(() {
              isLoading = false;
            });
          }
          Fluttertoast.showToast(
            msg: '${signupScreen.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        } else {
         if(mounted) {
            setState(() {
              isLoading = false;
            });
          }
          Fluttertoast.showToast(
            msg: '${signupScreen.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );

          Navigator.pushAndRemoveUntil(context,             MaterialPageRoute(
              builder: (context) => SigninScreen(title: "SigninScreen", devicerId: widget.deviceid,fcmTOken: widget.fcm,)), (route) => false);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
     user.dispose();
     user_lname.dispose();
     email.dispose();
     phone.dispose();
     pass.dispose();
     confirmpass.dispose();
     super.dispose();
  }
  void signin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SigninScreen(title: "SigninScreen", devicerId: widget.deviceid,fcmTOken: widget.fcm,)),
    );
  }
Widget space(){
    return  SizedBox(
      height: MediaQuery.of(context).size.height * 0.015,
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
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.23,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: MediaQuery.of(context).size.width*0.8,
                    child: Image.asset(
                      'assets/images/sign_logo.png',
                      height: MediaQuery.of(context).size.height * 0.24,
                      width: MediaQuery.of(context).size.height * 0.24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 50,
                    left: 0,
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
                  ),
                ],
              ),
            ),
          ),
        ),
        body: isLoading ? Center(
          child: CircularProgressIndicator(
            color: Color(0xff009E61),
            backgroundColor: Color(0xff0ECB82),
          ),
        ): SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
            //    height: MediaQuery.of(context).size.height * 0.62,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.35,
                      // ),

                      TextFormField(
                        controller: user,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'First Name',
                            hintStyle: TextStyle(
                              color: Color(0xff9B9B9B),
                            )),
                        validator: (user) {
                          if (user!.isEmpty) {
                            return 'Please enter first name';
                          }
                        },
                      ),
                      space(),
                      TextFormField(
                        controller: user_lname,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Last Name',
                            hintStyle: TextStyle(
                              color: Color(0xff9B9B9B),
                            )),
                        validator: (user) {
                          if (user!.isEmpty) {
                            return 'Please enter last name';
                          }
                          if (user.length < 3) {
                            return 'Last name should be atleast 3 digit';
                          }
                        },
                      ),
                      space(),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xff9B9B9B),
                            )),
                        validator: (text) {
                          if (EmailValidator.validate(text!.trim()))
                          {
                            return null;
                          }
                          return "Please enter valid email";
                        },
                      ),
                      space(),
                      TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(

                            border: UnderlineInputBorder(),
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                              color: Color(0xff9B9B9B),
                            )),
                        validator: (user) {
                          if (user!.isEmpty) {
                            return 'Please enter Phone number';
                          }

                        },
                      ),
                      space(),
                      TextFormField(
                        controller: pass,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Color(0xff9B9B9B),
                            )),
                        validator: (user) {
                          if (user!.isEmpty) {
                            return 'Please enter Password}';
                          }
                          if (user.length < 6) {
                            return 'Password should be atleast 6-digit long';
                          }
                        },
                      ),
                      space(),
                      TextFormField(
                        controller: confirmpass,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              color: Color(0xff9B9B9B),
                            )),
                        validator: (user) {
                          if (user!.isEmpty) {
                            return 'Please enter Password}';
                          }
                          if (user.length < 6) {
                            return 'Password should be atleast 6-digit long';
                          }
                        },
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                    child: Text("Sign Up".toUpperCase(),
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
                    onPressed: isLoading
                        ? null
                        : () {
                      register().then((value) {
                        if(mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                    }),
              ),
              space(),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a user?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        signin();
                      },
                      child: Text(
                        "  Login",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff005333),
                        ),
                      ),
                    ),
                  ]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ));
  }
}
