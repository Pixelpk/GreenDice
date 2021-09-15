import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';

class NotificationListItem extends StatefulWidget {
  NotificationListItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NotificationListItemState createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
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
          height: MediaQuery.of(context).size.height * 0.7,

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
                        image: new AssetImage("assets/images/notifItembg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/datebar.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Early Mail",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 150, horizontal: 30),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/flagicon.png"),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  "Warracknabeal",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/playicon.png"),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  "Race 3",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/personicon.png"),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  "Fast Sagrado",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                        ),
                        Column(
                          children: [
                            Text(
                              "14",
                              style: TextStyle(fontSize: 60, color: Colors.white),
                            ),
                            Text(
                              "August",
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(

                  left: 0,
                  right:0,
                  top: 260,


                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),

                          color:Color(0xffffffff),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Row(
                            children: [
                              Expanded(child: Image.asset("assets/images/horseimage.png"),),

                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Expanded(
                                child: Text(
                                    "Was sound in a recent jumpout, then running nice time on debut this 2yo Gelding, "
                                    "son of ( Fastnet Rock ), all being on a Heavy track, he can use the inside gate , "
                                    "as he has nice gate speed , settle behind leaders, look to be running on.",
                                    textAlign: TextAlign.left),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                Positioned(

                  bottom: -30,
                  left: 0,
                  right: 0,
                  child: SizedBox(

                    width: MediaQuery.of(context).size.width,

                    child: Container(
                  alignment: Alignment.bottomCenter,
                      child: Stack(
                        children: [
                          Image.asset("assets/images/bottombarbg.png"),


                          Positioned(
                             left: 70,
                              right: 0,
                              top: 10,
                              bottom: 0,

                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Current market odds",textAlign: TextAlign.center,style: TextStyle(fontSize: 10,color: Colors.white),),
                                      Text("\$15.5",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.white),),
                                    ],
                                  ),


                                  Column(


                                    children: [

                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                        child: Container(

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),

                                            color:Color(0xff485469),
                                          ),
                                          width: 50,
                                          height: 25,

                                          child: Center(child: Text("57%",style: TextStyle(color: Colors.white),)),


                                        ),
                                      ),

                                    ],
                                  ),


                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
