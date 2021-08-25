import 'package:flutter/material.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';

class MorePage extends StatefulWidget {
  MorePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
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
        child: Column(
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
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/profileicon.png"),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            child: Text(
                              "John Watson",
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

                  ListView(
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      ListTile( title: Text("Profile"), leading: Image.asset("assets/images/profile.png")),
                      ListTile( title: Text("Support"), leading: Image.asset("assets/images/support.png")),
                      ListTile( title: Text("E-Book"), leading: Image.asset("assets/images/ebook.png")),
                      ListTile( title: Text("Logout"), leading: Image.asset("assets/images/logout.png"))
                    ],
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
