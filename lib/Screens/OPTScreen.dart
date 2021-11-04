import 'dart:convert';
import 'dart:io';
import 'package:greendice/Screens/ForgotPasswordLogin.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomeScreen.dart';
import 'SignupScreen.dart';
import '../ModelClasses/SigninUser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OPTScreen extends StatefulWidget {
  String fcm ;
  String deviceId ;
  OPTScreen({Key? key, required this.title, required this.code ,required this.fcm,required this.deviceId}) : super(key: key);

  final String title;
  final String code;


  @override
  _OPTScreenState createState() => _OPTScreenState();
}

class _OPTScreenState extends State<OPTScreen> {
bool loading = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }


  @override
  void initState() {
    super.initState();
  }


  Future OTP(String token)async{


    if(token==widget.code)
      {



    final prefs = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse("https://app.greendiceinvestments.com/api/matchotp"),body: {
      "user_id" : widget.title,
      "token" : widget.code,
    },
      headers: <String, String>{
        'Accept': 'application/json',
      },
    );

    var data = json.decode(response.body);
    SigninUser signinUser = SigninUser.fromJson(jsonDecode(response.body));
    var val = '${signinUser.success}';
    var access_token = '${signinUser.data!.accessToken}';
    prefs.setString('access_token', access_token);


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
        msg: "Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => ForgotPasswordLogin(title: access_token,fcm: widget.fcm,deviceid: widget.deviceId,)),
    );

  }
      }
    else
      {
        Fluttertoast.showToast(
          msg: "You have entered incorrect code",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }

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
                      height: MediaQuery.of(context).size.height * 0.45,
                    ),

                    Text("A 6-digit code has been sent to your email. Please enter the code below to proceed"),

                   /* SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),*/

        Builder(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                    //  color: Colors.white,
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(20.0),
                      child: PinPut(
                        fieldsCount: 6,
                        onSubmit: (String pin) => OTP(pin)/*_showSnackBar(pin, context)*/,
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withOpacity(.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Divider(),
               /*     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => _pinPutFocusNode.requestFocus(),
                          child: const Text('Focus'),
                        ),
                        FlatButton(
                          onPressed: () => _pinPutFocusNode.unfocus(),
                          child: const Text('Unfocus'),
                        ),
                        FlatButton(
                          onPressed: () => _pinPutController.text = '',
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),*/
                  ],
                ),
              ),
            );
          },
        ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                          child: Text("Continue", style: TextStyle(fontSize: 14)),
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
                          onPressed: () => null),
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


