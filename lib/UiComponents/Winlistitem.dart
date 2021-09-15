import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart' as textstyling;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';

class Winlistitem extends StatefulWidget {
  Winlistitem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _WinlistitemState createState() => _WinlistitemState();
}

class _WinlistitemState extends State<Winlistitem> {
  @override
  void initState() {
    super.initState();
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
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Stack(
              overflow: Overflow.visible,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/winbg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset("assets/images/horseimage.png"),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textstyling.SizedBox(
                                height: textstyling.MediaQuery.of(context)
                                        .size
                                        .height *
                                    0.03,
                              ),
                              Text("Early Mail",
                                  style: textstyling.TextStyle(
                                      fontSize: 24, color: Colors.white)),

                              textstyling.SizedBox(
                                height: textstyling.MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.02,
                              ),

                              Row(
                                children: [
                                  Image.asset("assets/images/flagwhite.png"),
                                  textstyling.Text("  WARRACKNABEAL",
                                      style: textstyling.TextStyle(
                                          fontSize: 12, color: Colors.white))
                                ],
                              ),
                              textstyling.SizedBox(
                                height: textstyling.MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.01,
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/playwhite.png"),
                                  textstyling.Text("  Race 3",
                                      style: textstyling.TextStyle(
                                          fontSize: 12, color: Colors.white))
                                ],
                              ),
                              textstyling.SizedBox(
                                height: textstyling.MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.01,
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/personw.png"),
                                  textstyling.Text("  Fast Sagrado", style: textstyling.TextStyle(
                                      fontSize: 12, color: Colors.white))
                                ],
                              ),
                            ],
                          ),
                          textstyling.Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                textstyling.SizedBox(
                                  height: textstyling.MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.03,
                                ),
                                textstyling.Text("Current market odds",style: textstyling.TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),),
                                textstyling.Text("\$1.57",style: textstyling.TextStyle(
                                  fontSize: 40,
                                  color: Colors.white
                                ),),
                                textstyling.Container(
                                  height: textstyling.MediaQuery.of(context).size.height * 0.05,
                                  width: textstyling.MediaQuery.of(context).size.width * 0.25,
                                  color: Colors.white,
                                  child: textstyling.Center(child: textstyling.Text("57%",style: textstyling.TextStyle(

                                    fontSize: 18

                                  ),)),
                                ),

                                textstyling.SizedBox(

                                  height: textstyling.MediaQuery.of(context).size.height * 0.01,

                                ),


                                textstyling.Row(

                                  children: [

                                  textstyling.Container(

                                      color: Colors.white,
                                      height: textstyling.MediaQuery.of(context).size.height * 0.05,
                                      width: textstyling.MediaQuery.of(context).size.width * 0.1,
                                      child: textstyling.Center(child: textstyling.Text("1")),
                                    ),

                                    textstyling.SizedBox(

                                      width: textstyling.MediaQuery.of(context).size.width * 0.05,

                                    ),

                                    textstyling.Container(

                                      color: Colors.white,
                                      height: textstyling.MediaQuery.of(context).size.height * 0.05,
                                      width: textstyling.MediaQuery.of(context).size.width * 0.1,
                                      child: Image.asset("assets/images/trophy.png"),
                                    )

                                  ],

                                )


                              ],


                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
