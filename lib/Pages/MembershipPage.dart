import 'dart:convert';
import 'dart:io';

import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/Packages.dart';
import 'package:greendice/Screens/PaymentScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/Screens/SubscriptionPlanScreen.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  late String firstname = '', lastname = '', photo = '';
  late final access_token;
  bool isLoading = true;
  int? classicprice;
  SubscriptionPackages? _subscriptionPackages;
  // Packages? chairmansPackages;
  //  String? fcm;
  //  String? deviceId;

  Packages? classicYearly = Packages();
  Packages? classicQuaterly = Packages();
  @override
  void initState() {
    super.initState();
    Loadprefs().then((value) {
      getAllPackages().then((subscriptionPackages) {
        if (mounted) {
          setState(() {
            //  _subscriptionPackages = subscriptionPackages;
            //   classicprice = _subscriptionPackages!.data!.packages![0].price!;
            //    chairmansPackages =
            //    _subscriptionPackages!.data!.packages![2].type == 0
            //        ? _subscriptionPackages!.data!.packages![2]
            //        : Packages();

            subscriptionPackages.data!.packages!.forEach((element) {
              if (element.type == 1) {
                //yearly packages
                classicYearly = element;
              }
              if (element.type == 2) {
                //Quaterly package
                classicQuaterly = element;
              }
            });
          });
        }
      });
    });
  }

  bool quaterlyplanSelected = false;
  bool yearlyplanSelected = false;

  String isYearlyPkg = '0';
  String isFourMonthPkg = '0';
  String isCharmans = '0';
  bool ispremium = false;

  Future<void> Loadprefs() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      access_token = prefs.getString('access_token') ?? '';
      firstname = (prefs.getString('fname') ?? '');
      lastname = (prefs.getString('lname') ?? '');
      photo = (prefs.getString('image') ?? '');

      isYearlyPkg = prefs.getString('isYearlyPkg') ?? '0';
      isFourMonthPkg = prefs.getString('isFourMonthPkg') ?? '0';
      isCharmans = prefs.getString('isChairman') ?? '0';
      ispremium = prefs.getString('isYearlyPkg') == '1'
          ? true
          : prefs.getString('isFourMonthPkg') == '1'
              ? true
              : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff009E61),
                backgroundColor: Color(0xff0ECB82),
              ),
            )
          : Container(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.4,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Color(0xff009E61),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(18),
                            bottomLeft: Radius.circular(18))),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Choose your Plan",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExpandTapWidget(
                            tapPadding: EdgeInsets.all(25.0),
                            onTap: () {
                              print("quaterlyplanSelected");
                              setState(() {
                                quaterlyplanSelected = !quaterlyplanSelected;
                                yearlyplanSelected = false;
                              });
                            },
                            child: Container(
                              height: size.height * 0.20,
                              width: size.height * 0.20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: quaterlyplanSelected
                                      ? Colors.amber
                                      : Colors.grey),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Quarterly",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "4-Months",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${classicQuaterly!.price}\$",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          InkWell(
                            onTap: () {
                              print("yearlyplanSelected");
                              setState(() {
                                quaterlyplanSelected = false;
                                yearlyplanSelected = !yearlyplanSelected;
                              });
                            },
                            child: Container(
                              height: size.height * 0.20,
                              width: size.height * 0.20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: yearlyplanSelected
                                      ? Colors.amber
                                      : Colors.grey),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Yearly",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "12-Months",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${classicYearly!.price}\$",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: MaterialButton(
                          onPressed: quaterlyplanSelected == false &&
                                  yearlyplanSelected == false
                              ? null
                              : () {
                                  if (quaterlyplanSelected) {
                                    print("quaterlyplanSelected");
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => PaymenyScreen(
                                                  accessToken: access_token,
                                                  packageId: classicQuaterly!.id
                                                      .toString(),
                                                )));
                                  } else if (yearlyplanSelected) {
                                    print("quaterlyplanSelected");
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => PaymenyScreen(
                                                  accessToken: access_token,
                                                  packageId: classicYearly!.id
                                                      .toString(),
                                                )));
                                  }
                                },
                          minWidth: size.width * 0.86,
                          height: size.height * 0.078,
                          disabledColor: Colors.grey,
                          color: Color(0xff009E61),
                          child: Text(
                            "Continue",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future<SubscriptionPackages> getAllPackages() async {
    // setState(() {
    //   isLoading = true;
    // });
    //print("token = "+access_token);
    var response = await http.get(
      Uri.parse("https://app.greendiceinvestments.com/api/allpackages"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + access_token,
      },
    );

    SubscriptionPackages subscriptionPackages =
        SubscriptionPackages.fromJson(jsonDecode(response.body));
    var val = '${subscriptionPackages.success}';

    print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
      print('API STATUS SUCCESS');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return subscriptionPackages;
    } else {
      Fluttertoast.showToast(
        msg: "Error! Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      return subscriptionPackages;
      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(title: "HomScreen")),
      );*/
    }
  }
}
