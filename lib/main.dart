import 'package:flutter/material.dart';
import 'package:greendice/Pages/CalendarPage.dart';
import 'package:greendice/Pages/MembershipPage.dart';
import 'package:greendice/Pages/MorePage.dart';
import 'package:greendice/Pages/NotificationPage.dart';
import 'package:greendice/Pages/SupportScreen.dart';
import 'package:greendice/Screens/CalendarDataScreen.dart';
import 'package:greendice/Screens/EbookScreen.dart';
import 'package:greendice/Screens/EmailforOTP.dart';
import 'package:greendice/Screens/OPTScreen.dart';
import 'package:greendice/Screens/ProfileScreen.dart';
import 'package:greendice/Screens/SigninScreen.dart';
import 'package:greendice/Screens/SignupScreen.dart';
import 'package:greendice/Screens/SplashScreen.dart';
import 'package:greendice/UiComponents/NotificationListItem.dart';
import 'package:greendice/UiComponents/Winlistitem.dart';
import 'package:greendice/UiComponents/Loselistitem.dart';
import 'Screens/ForgotPasswordLogin.dart';
import 'Screens/ForgotPasswordScreen.dart';
import 'Screens/HomeScreen.dart';
import 'UiComponents/Ebookitem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Dice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // This is the theme of your application.
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(title: 'title'),
    );
  }
}
