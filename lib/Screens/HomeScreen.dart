import 'package:flutter/material.dart';
import 'package:greendice/Pages/CalendarPage.dart';
import 'package:greendice/Pages/MembershipPage.dart';
import 'package:greendice/Pages/MorePage.dart';
import 'package:greendice/Pages/NotificationPage.dart';
import 'package:greendice/Pages/ResultsPage.dart';

import 'SignupScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentindex = 0;
  List<Widget> _tabList = [
   new NotificationPage(title: "Notification"),
   new MembershipPage(title: "Membership"),
   new ResultsPage(title: "Results"),
   new CalendarPage(title: "Calendar"),
   new MorePage(title: "Notification")
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: TabBarView(
        controller: _tabController,
        children: _tabList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffdbf1e9),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFFCBE8DD),
        unselectedItemColor: Color(0xFF009d60),
        selectedLabelStyle: TextStyle(
          color: Color(0xFF009d60),
          fontSize: 10,
        ),
        unselectedLabelStyle: TextStyle(
          color: Color(0xFF009d60),
          fontSize: 10,
        ),
        onTap: (currentIndex) {
          setState(() {
            _currentindex = currentIndex;

          });
          _tabController.animateTo(_currentindex);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/bell.png"),
              color: Color(0xFF009d60),
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/creditcard.png"),
              color: Color(0xFF009d60),
            ),
            label: 'Pricing',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/analytics.png"),
              color: Color(0xFF009d60),
            ),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/calendar.png"),
              color: Color(0xFF009d60),
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/more.png"),
              color: Color(0xFF009d60),
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
