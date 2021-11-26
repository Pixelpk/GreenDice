
import 'package:flutter/material.dart' as textstyling;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ebookitem extends StatefulWidget {
  Ebookitem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _EbookitemState createState() => _EbookitemState();
}

class _EbookitemState extends State<Ebookitem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Stack(
              clipBehavior: Clip.none, children: [
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
                                    0.04,
                              ),
                              Text("E-book: 1",
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
                                  Text("Description: ",style: textstyling.TextStyle(

                                    fontWeight: textstyling.FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14

                                  ),),
                                  textstyling.Text("  test ebook1 description",
                                      style: textstyling.TextStyle(
                                          fontSize: 12, color: Colors.white))
                                ],
                              ),

                            ],
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
