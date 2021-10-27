import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greendice/Pages/CalendarPage.dart';
import 'package:greendice/Pages/MembershipPage.dart';
import 'package:greendice/Pages/MorePage.dart';
import 'package:greendice/Pages/NotificationPage.dart';
import 'package:greendice/Pages/ResultsPage.dart';
import 'package:greendice/Screens/CalendarDataScreen.dart';

import 'SignupScreen.dart';

class HomeScreen extends StatefulWidget {
  bool ispremiumUser ;
  HomeScreen({Key? key, required this.title ,required this.ispremiumUser }) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentindex = 0;
  List<Widget> _tabList = [
    new NotificationPage(title: "Notification"),
    new MembershipPage(),
    new ResultsPage(title: "Results"),
    new CalendarPage(title: "Calendar"),
    new MorePage(title: "Notification")
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    if(!widget.ispremiumUser)
      {
        _currentindex = 1 ;
      }
    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabList.elementAt(_currentindex),

      // TabBarView(
      //   controller: _tabController,
      //   children: _tabList,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffdbf1e9),
        type: BottomNavigationBarType.fixed,
        // selectedItemColor: Color(0xFF009d60),

        selectedLabelStyle: TextStyle(
          color: Color(0xFF009d60),
          fontSize: 10,
        ),
        // unselectedLabelStyle: TextStyle(
        //   color: Colors.grey,
        //   fontSize: 10,
        // ),
        onTap: (currentIndex) {
          setState(() {
            _currentindex = currentIndex;
          });
          _tabController.animateTo(_currentindex);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: customNavBARitem(
              currentindex: _currentindex,
              assetsPath: "assets/images/bell-line.svg",
              defaultIndex: 0,
              labelString: 'Notification',
            ),

            // ImageIcon(
            //   AssetImage("assets/images/bell.png"),
            //   color: Color(0xFF009d60),
            // ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: customNavBARitem(
              currentindex: _currentindex,
              assetsPath: "assets/images/credit-card-2-back.svg",
              defaultIndex: 1,
              labelString: 'Pricing',
            ),
            label: 'Pricing',
          ),
          BottomNavigationBarItem(
            icon: customNavBARitem(
              currentindex: _currentindex,
              assetsPath: "assets/images/analytics.svg",
              defaultIndex: 2,
              labelString: 'Results',
            ),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: customNavBARitem(
              currentindex: _currentindex,
              assetsPath: "assets/images/calender.svg",
              defaultIndex: 3,
              labelString: 'Calendar',
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: customNavBARitem(
              currentindex: _currentindex,
              assetsPath: "assets/images/more.svg",
              defaultIndex: 4,
              labelString: 'More',
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget customNavBARitem(
      {required assetsPath,
      required currentindex,
      required defaultIndex,
      required labelString}) {
    return Column(
      mainAxisAlignment: defaultIndex == 4
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: defaultIndex == 4 ? 7 : 0,
        ),
        SvgPicture.asset(assetsPath,
            height: defaultIndex == 4 ? 5 : 20,
            color: _currentindex == defaultIndex
                ? Color(0xFF009d60)
                : Colors.grey),
        SizedBox(
          height: defaultIndex == 4 ? 10 : 4,
        ),
        Text(
          labelString!,
          style: TextStyle(
              color: _currentindex == defaultIndex
                  ? Color(0xFF009d60)
                  : Colors.grey,
              fontSize: 10),
        )
      ],
    );
  }
}
