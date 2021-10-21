import 'package:flutter/material.dart';
import 'package:greendice/Screens/HomeScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';

class SupportScreen extends StatefulWidget {
  SupportScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
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


                  /*Padding(

                    padding: EdgeInsets.fromLTRB(15,25,0,0),

                    child: InkWell(

                      onTap: (){

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(title: "HomScreen")),
                        );

                      },

                      child: Container(

                        width: MediaQuery.of(context).size.width * 0.035,
                        height: MediaQuery.of(context).size.height * 0.035  ,

                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/images/back.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),


                      ),
                    ),
                  ),*/

                  IconButton(
                    onPressed: () {

                      Navigator.pop(context);

                    },
                    icon: Image.asset('assets/images/back.png'),
                  ),



                  Column(
                    children: [

                         SizedBox(

                      height: MediaQuery.of(context).size.height * 0.14,

                    ),



                      Container(
                        margin: EdgeInsets.only(
                            left: 60, top: 0, right: 0, bottom: 0),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Support",
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
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text("To get information about Greendice, Please contact our customer support using the following Calendly link."),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(

                        children: [

                          Text("Calendly Link: ",style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(

                            width: MediaQuery.of(context).size.height * 0.02,

                          ),
                          Text("www.calendly.com",style: TextStyle(
                            fontSize: 14,
                          ),),


                        ],

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
