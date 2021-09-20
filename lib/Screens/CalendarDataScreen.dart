import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/CalDataModelClass.dart';
import 'package:greendice/Screens/HomeScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/UiComponents/NotificationListItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ModelClasses/notificationModelClass.dart';


class CalendarDataScreen extends StatefulWidget {
  CalendarDataScreen({Key? key, required this.title}) : super(key: key);
  String title;


  @override
  _CalendarDataScreenState createState() => _CalendarDataScreenState();

}

class _CalendarDataScreenState extends State<CalendarDataScreen> {


  late List data = [];
  late ScrollController _controller;
  CalDataModelClass? notificationmodel;

  bool isloading = true;
  bool noDataFound = false;


  _scrollListener() {


    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);


    Signalapi().then((value) => {

      setState((){

        this.notificationmodel = value;
        isloading = false;
      }),

    });
  }



  Future<CalDataModelClass> Signalapi() async{


    final prefs = await SharedPreferences.getInstance();
    final access_token = prefs.getString('access_token') ?? '';
  //  print("token = "+access_token);
    var response = await http.post(Uri.parse("http://syedu12.sg-host.com/api/calendar"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer "+access_token,
      },
        body: {
          "signal_date": widget.title.toString(),
        }

    );


    //  var data = json.decode(response.body);
    CalDataModelClass notificationmodel = CalDataModelClass.fromJson(jsonDecode(response.body));
    //notifcationModelClass notification_success = notifcationModelClass.fromJson(jsonDecode(response.body));
    var val = '${notificationmodel.success}';

    this.setState(() {

    });

    //data = jsonDecode('${notification_success.data!.notificationSignal}');
    print(jsonDecode(response.body));



    print(val);
    if(val == "1")
    {
      setState(() {
        noDataFound = false;
      });
    }
    else
    {

      setState(() {
        noDataFound = true;
      });

      /*Fluttertoast.showToast(
        msg: "Error! Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );*/
      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(title: "HomScreen")),
      );*/
    }

    return notificationmodel;

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
                            image: AssetImage(
                                "assets/images/dashboardappbarimage.png"),
                            fit: BoxFit.cover)),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1
                  ),

                  Padding(
                    
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
                  ),

                  Column(
                    children: [



                      SizedBox(

                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,

                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: 60, top: 0, right: 0, bottom: 0),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Race Data",
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
              Center(
                  child: isloading ? Center(child: CircularProgressIndicator()) : noDataFound ? noDataWidget() : ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
                    itemCount: data == null ? 0 : notificationmodel!.data!.calenderSignal!.length,
                    itemBuilder: (BuildContext context,int index){

                       return Container(
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
                                       image: notificationmodel!.data!.calenderSignal![index].placing == "1" ? AssetImage("assets/images/winbg.png") : AssetImage("assets/images/losebg.png"),
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
                                             SizedBox(
                                               height: MediaQuery.of(context)
                                                   .size
                                                   .height *
                                                   0.03,
                                             ),
                                             Text(notificationmodel!.data!.calenderSignal![index].location!,
                                                 style: TextStyle(
                                                     fontSize: 24, color: Colors.white)),

                                             SizedBox(
                                               height: MediaQuery.of(context)
                                                   .size
                                                   .height *
                                                   0.02,
                                             ),

                                             Row(
                                               children: [
                                                 Image.asset("assets/images/flagwhite.png"),
                                                 Text(notificationmodel!.data!.calenderSignal![index].location!,
                                                     style: TextStyle(
                                                         fontSize: 12, color: Colors.white))
                                               ],
                                             ),
                                             SizedBox(
                                               height: MediaQuery.of(context)
                                                   .size
                                                   .height *
                                                   0.01,
                                             ),
                                             Row(
                                               children: [
                                                 Image.asset("assets/images/playwhite.png"),
                                                 Text("  Race " + notificationmodel!.data!.calenderSignal![index].raceId.toString()!,
                                                     style: TextStyle(
                                                         fontSize: 12, color: Colors.white))
                                               ],
                                             ),
                                             SizedBox(
                                               height: MediaQuery.of(context)
                                                   .size
                                                   .height *
                                                   0.01,
                                             ),
                                             Row(
                                               children: [
                                                 Image.asset("assets/images/personw.png"),
                                                 Text(" " + notificationmodel!.data!.calenderSignal![index].horse!, style: TextStyle(
                                                     fontSize: 12, color: Colors.white))
                                               ],
                                             ),
                                           ],
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [

                                               SizedBox(
                                                 height: MediaQuery.of(context)
                                                     .size
                                                     .height *
                                                     0.03,
                                               ),
                                               Text("Current market odds",style: TextStyle(
                                                   fontSize: 12,
                                                   color: Colors.white
                                               ),),
                                               Text(notificationmodel!.data!.calenderSignal![index].oods!,style: TextStyle(
                                                   fontSize: 40,
                                                   color: Colors.white
                                               ),),
                                               Container(
                                                 height: MediaQuery.of(context).size.height * 0.05,
                                                 width: MediaQuery.of(context).size.width * 0.25,
                                                 color: Colors.white,
                                                 child: Center(child: Text(notificationmodel!.data!.calenderSignal![index].roi!,style: TextStyle(

                                                     fontSize: 18

                                                 ),)),
                                               ),

                                               SizedBox(

                                                 height: MediaQuery.of(context).size.height * 0.01,

                                               ),


                                               Row(

                                                 children: [

                                                   Container(

                                                     color: Colors.white,
                                                     height: MediaQuery.of(context).size.height * 0.05,
                                                     width: MediaQuery.of(context).size.width * 0.1,
                                                     child: Center(child: Text(notificationmodel!.data!.calenderSignal![index].placing!,)),
                                                   ),

                                                   SizedBox(

                                                     width: MediaQuery.of(context).size.width * 0.05,

                                                   ),

                                                   Container(

                                                     color: Colors.white,
                                                     height: MediaQuery.of(context).size.height * 0.05,
                                                     width: MediaQuery.of(context).size.width * 0.1,
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
                       );
                    },)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noDataWidget() {

    return Center(
      child: Column(
        children: [

          Text('No data found'),

        ],
      ),
    );

  }


}

String monthselector(String split) {

  String monthname = "January";

  if(split=="01")
  {
    monthname = "January";
  }
  else if(split=="02")
  {
    monthname = "Feburary";
  }
  else if(split=="03")
  {
    monthname = "March";
  }
  else if(split=="04")
  {
    monthname = "April";
  }
  else if(split=="05")
  {
    monthname = "May";
  }
  else if(split=="06")
  {
    monthname = "June";
  }
  else if(split=="07")
  {
    monthname = "July";
  }
  else if(split=="08")
  {
    monthname = "August";
  }
  else if(split=="09")
  {
    monthname = "September";
  }
  else if(split=="10")
  {
    monthname = "Octobar";
  }
  else if(split=="11")
  {
    monthname = "November";
  }
  else if(split=="12")
  {
    monthname = "December";
  }

  return monthname;
}
