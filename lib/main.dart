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
import 'package:firebase_core/firebase_core.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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


        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(title: 'title'),
    );
  }
}
