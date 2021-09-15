import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/LogoutModelClass.dart';
import 'package:greendice/ModelClasses/more_model.dart';
import 'package:greendice/Pages/SupportScreen.dart';
import 'package:greendice/Screens/EbookScreen.dart';
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
  late String firstname,lastname,photo;
  late final access_token;
  bool isLoading = true;

  List<String> icons = [
    "assets/images/profile.png",
    "assets/images/support.png",
    "assets/images/ebook.png",
    "assets/images/logout.png"
  ];
  List<String> titles = ["Profile", "Support", "E-Book", "Logout"];


  List<MoreModel> moreList = [];

  @override
  void initState() {
    super.initState();


    Loadprefs().then((value) =>
    {
    _gerMoreList(),

    });
  }

  Future<void> Loadprefs() async{

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      access_token = prefs.getString('access_token') ?? '';
      firstname = (prefs.getString('fname') ?? '');
      lastname = (prefs.getString('lname') ?? '');
      photo = (prefs.getString('image') ?? '');
      isLoading = false;
    });

  }


  _gerMoreList() {
    moreList.add(
        MoreModel(icon: 'assets/images/profile.png', title: 'Profile'));
    moreList.add(
        MoreModel(icon: 'assets/images/support.png', title: 'Support'));
    moreList.add(MoreModel(icon: 'assets/images/ebook.png', title: 'E-Book'));
    moreList.add(MoreModel(icon: 'assets/images/logout.png', title: 'Logout'));
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


  Future Logout() async {
    final prefs = await SharedPreferences.getInstance();
    final access_token = prefs.getString('access_token') ?? '';

    var response = await http.get(
      Uri.parse("http://syedu12.sg-host.com/api/logout"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + access_token,
      },
    );

    var data = json.decode(response.body);
    LogoutModelClass logoutModelClass = LogoutModelClass.fromJson(
        jsonDecode(response.body));
    var val = '${logoutModelClass.data!.message}';


    print(val);
    if (val == "0") {
      Fluttertoast.showToast(
        msg: val,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    else {

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SigninScreen(title: "SigninScreen")),
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
        child: isLoading ? CircularProgressIndicator() : Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.21,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/membershipimage.png"),
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
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.1,
                            /*decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/profileicon.png"),
                                    fit: BoxFit.cover)),*/
                            child: photo == '' ? Image.asset("assets/images/profileimage.png") : Image.network(photo),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            child: Text(
                              firstname +" "+ lastname,
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffffffff)),
                            ),
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
                     return ListTile( title: Text(moreList[index].title!), leading: Image.asset(moreList[index].icon!),
                       onTap: (){

                       if(index==0)
                         {
                           Navigator.push(context,
                             MaterialPageRoute(
                                 builder: (context) => ProfileScreen(title: "ProfileScreen")),
                           );
                         }
                       else if(index==1)
                         {
                           Navigator.push(context,
                             MaterialPageRoute(
                                 builder: (context) => SupportScreen(title: "SupportScreen")),
                           );
                         }
                       else if(index==2)
                         {
                           Navigator.push(context,
                             MaterialPageRoute(
                                 builder: (context) => EbookScreen(title: "EbookScreen")),
                           );
                         }
                       else if(index==3)
                         {
                            Logout();
                         }



                       },);
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

