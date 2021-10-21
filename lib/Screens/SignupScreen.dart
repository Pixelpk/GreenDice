import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomeScreen.dart';
import 'SigninScreen.dart';
import '../ModelClasses/SignupUser.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key, required this.title}) : super(key: key);

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

    setState(() {
      isLoading = true;
    });

    final isValid = _formkey.currentState!.validate();

    if (!isValid) {
      return;
    } else {


      var response = await http
          .post(Uri.parse("http://syedu12.sg-host.com/api/register"), body: {
        "first_name": user.text,
        "last_name": user_lname.text,
        "email": email.text,
        "phone": phone.text,
        "password": pass.text,
        "password_confirmation": confirmpass.text,
      });

      var data = json.decode(response.body);
      SignupUser signupScreen = SignupUser.fromJson(jsonDecode(response.body));
      print('${signupScreen.success}');
      var val = '${signupScreen.success}';

      if (val == "0") {
        Fluttertoast.showToast(
          msg: '${signupScreen.message}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        Fluttertoast.showToast(
          msg: '${signupScreen.message}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SigninScreen(title: "SigninScreen")),
        );



      }
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
            alignment: AlignmentDirectional.center,
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
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
                              return 'Please enter user name';
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ), TextFormField(
                          controller: user_lname,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Last Name',
                              hintStyle: TextStyle(
                                color: Color(0xff9B9B9B),
                              )),
                          validator: (user) {
                            if (user!.isEmpty) {
                              return 'Please enter user name';
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Color(0xff9B9B9B),
                              )),
                          validator: (user) {
                            if (user!.isEmpty) {
                              return 'Please enter email';
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                          controller: phone,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
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
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
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
                              return 'Please enter Confirm Password}';
                            }
                          },
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
                                          borderRadius: BorderRadius.circular(25),
                                          side: BorderSide(
                                            color: Color(0xff009E61),
                                          )))),
                              onPressed: isLoading ? null : () {

                                register().then((value) {

                                  setState(() {
                                    isLoading = false;
                                  });

                                });

                              }),
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

              Visibility(
                visible: isLoading,
                child: CircularProgressIndicator( color: Color(0xff009E61),
                  backgroundColor: Color(0xff0ECB82),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
