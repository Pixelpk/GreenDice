import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/LogoutModelClass.dart';
import 'package:greendice/ModelClasses/more_model.dart';
import 'package:greendice/Pages/SupportScreen.dart';
import 'package:greendice/Screens/EbookScreen.dart';
import 'package:greendice/Screens/LogoutLoading.dart';
import 'package:greendice/Screens/ProfileScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MorePage extends StatefulWidget {
  MorePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late String firstname = '', lastname = '', photo = '';
  late final access_token;
  bool isLoading = false;

  List<String> titles = ["Profile", "Support", "E-Book", "Logout"];

  List<MoreModel> moreList = [
    MoreModel(icon: 'assets/images/profil.svg', title: 'Profile'),
    MoreModel(icon: 'assets/images/support.svg', title: 'Support'),
    MoreModel(icon: 'assets/images/ebook.svg', title: 'E-Book'),
    MoreModel(icon: 'assets/images/logout.svg', title: 'Logout')
  ];

  @override
  void initState() {
    super.initState();

    Loadprefs();
  }
  String isYearlyPkg = '0' ;
  String isFourMonthPkg = '0';
  String isCharmans = '0';
  Future<void> Loadprefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      access_token = prefs.getString('access_token') ?? '';
      firstname = (prefs.getString('fname') ?? '');
      lastname = (prefs.getString('lname') ?? '');
      photo = (prefs.getString('image') ?? '');
      isYearlyPkg = prefs.getString('isYearlyPkg')??'0' ;
      isFourMonthPkg = prefs.getString('isFourMonthPkg') ?? '0';
      isCharmans =  prefs.getString('isChairman') ?? '0' ;
    });
  }

  void signin() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SigninScreen(title: "SigninScreen")),
    );
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignupScreen(title: "SignupScreen")),
    );
  }



  Future<void> resetSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', '');
    prefs.setString('fname', '');
    prefs.setString('lname', '');
    prefs.setString('phone', '');
    prefs.setString('email', '');
    prefs.setString('image', '');
    return Future.value();
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
      /*  appBar: new PreferredSize(
          preferredSize: Size.fromHeight(100.0), // here the desired height
          child: new AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Image(
              image: AssetImage('assets/images/dashboardappbarimage.png'),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
            // ...
          )),*/

      body: SafeArea(
        child:
             Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.21,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/membershipimage.png"),
                                fit: BoxFit.cover)),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: Row(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                photo == ''
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: new AssetImage(
                                                "assets/images/profileimage.png"),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              photo,
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(height: 8,),
                                    Container(
                                      child: Text(
                                        firstname + " " + lastname,
                                        style: TextStyle(
                                            fontSize: 14, color: Color(0xffffffff)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(isYearlyPkg == '1' ? "Yearly Package: Active": isFourMonthPkg == '1' ? '4-Month Package: Active' : "No Package Active",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white
                                      ),
                                    ),
                                    SizedBox(height: 4,),
                                    isCharmans == '1'?Text("Chairman's Package: Active",style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white
                                    ),):Container()
                                  ],
                                ),

                              ],
                            ),
                          ),

                          /*   SizedBox(

                      width: MediaQuery.of(context).size.width * 1,

                    ),*/

                          Container(
                            margin: EdgeInsets.only(
                                left: 60, top: 0, right: 0, bottom: 0),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "More",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0ECB82)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.03,
                    color: Color(0xff009E61),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    //           color: Color(0xff005333),
                    child: Stack(
                      children: [
                        ListView.builder(
                          itemCount: moreList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(moreList[index].title!),
                              leading: SvgPicture.asset(
                                moreList[index].icon!,
                              ),
                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen(
                                            title: "ProfileScreen")),
                                  );
                                } else if (index == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SupportScreen(
                                            title: "SupportScreen")),
                                  );
                                } else if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EbookScreen(title: "EbookScreen")),
                                  );
                                } else if (index == 3) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title:  Text('Exit App'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('Are you sure you want to Logout ?'),
                                            SizedBox(height: 16.0),
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>LogoutLoading(token: access_token)), (route) => false);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Color(0xFF009d60),
                                                  ),
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 16.0),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Color(0xFF009d60),
                                                  ),
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));

                                }
                              },
                            );
                          },
                          padding: const EdgeInsets.all(8),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
