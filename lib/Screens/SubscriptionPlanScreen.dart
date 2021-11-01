import 'package:flutter/material.dart';
import 'package:greendice/ModelClasses/Packages.dart';
import 'package:greendice/Screens/PaymentScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum PlanType { classicPlan, chairmansPlan }

class SubscriptionPlanScreen extends StatefulWidget {
  SubscriptionPackages subscriptionPackages;
  PlanType planType;
  SubscriptionPlanScreen(
      {Key? key, required this.subscriptionPackages, required this.planType})
      : super(key: key);

  @override
  _SubscriptionPlanScreenState createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {
  bool quaterlyplanSelected = false;
  bool yearlyplanSelected = false;

  Packages? classicYearly;
  Packages? classicQuaterly;
  String? accessToken ;
  Future<void> Loadprefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('access_token') ?? '';
    });
  }
  @override
  void initState() {
    Loadprefs() ;
    widget.subscriptionPackages.data!.packages!.forEach((element) {
      if (element.type == 1) {
        //yearly packages
        classicYearly = element;
      }
      if (element.type == 2) {
        //Quaterly package
        classicQuaterly = element;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * 0.4,
            child: Stack(
              //  alignment: Alignment.bottomCenter,
              overflow: Overflow.visible,
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
                Positioned(
                  top: 80,
                  right: 60,
                  left: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Choose your Plan",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: -size.height * 0.10,
                    right: 20,
                    left: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ))
              ],
            ),
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => PaymenyScreen(
                              accessToken:accessToken ,
                              packagePriceID: classicQuaterly!.priceId!,

                            )));
                      } else if (yearlyplanSelected) {
                        print("quaterlyplanSelected");
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => PaymenyScreen(
                              accessToken:accessToken ,
                              packagePriceID: classicYearly!.priceId!,
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
    );
  }
}
