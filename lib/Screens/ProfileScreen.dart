import 'package:flutter/material.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

              overflow: Overflow.visible,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.21,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                          AssetImage("assets/images/profilebackground.png"),
                          fit: BoxFit.cover)),
                ),


                Positioned(

                  left: 0,
                  right: 0,
                  bottom: -70,

                  child: Container(

                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(

                        /*image: DecorationImage(
                            image:
                            AssetImage(),
                            fit: BoxFit.cover)*/),
                    child: Image.asset("assets/images/profileimage.png"),

                  ),
                ),

              ],
            ),

        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              TextField(
            //    controller: user,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Name',
                    hintStyle: TextStyle(
                      color: Color(0xff9B9B9B),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextField(
            //    controller: email,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Color(0xff9B9B9B),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextField(
          //      controller: phone,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      color: Color(0xff9B9B9B),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextField(
         //       controller: pass,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color(0xff9B9B9B),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextField(
        //        controller: confirmpass,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: Color(0xff9B9B9B),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: ElevatedButton(
                    child: Text("Update".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
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
