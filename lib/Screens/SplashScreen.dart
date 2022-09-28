import 'dart:async';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greendice/Screens/WelcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<String> Loadprefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token') ?? '';
  }

  @override
  void initState() {
    ioSNotifcationHandler();
    notificationOnMessagehandler();
    notificationOnMessageOpened();
    super.initState();
    Loadprefs().then((token) async {
      print("TOKEN $token");
      if (token == '' || token == null) {
        Timer(
            Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => WelcomeScreen())));
      } else {
        final prefs = await SharedPreferences.getInstance();
        String yearlyExpiryDatestr =
            prefs.getString("yearly_pkg_cancel_at") ?? '';
        String montlyExpiryDatestr =
            prefs.getString("four_month_pkg_cancel_at") ?? '';
        DateTime? YearlyDate;
        DateTime? monthlyDate;
        bool isExpired = false;
        if (yearlyExpiryDatestr != '' && yearlyExpiryDatestr != null) {
          YearlyDate = DateTime.parse(yearlyExpiryDatestr);
          isExpired = !YearlyDate.isAfter(DateTime.now());
          print("YEAERLY EXPIRED $isExpired");
        }
        if (montlyExpiryDatestr != '' && montlyExpiryDatestr != null) {
          monthlyDate = DateTime.parse(montlyExpiryDatestr);

          isExpired = !monthlyDate.isAfter(DateTime.now());
          print("MONTHLY EXPIRED $isExpired");
        }

        ///TODO CHAIRMANS EXPIRY
        bool ispremium =
            (prefs.getString('isYearlyPkg') == '1') && isExpired == false
                ? true
                : prefs.getString('isFourMonthPkg') == '1' && isExpired == false
                    ? true
                    : false;
        print("ISPREMIUM FROM SHAREDPREF $ispremium");
        Timer(
            Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(
                      title: token,
                      ispremiumUser: ispremium,
                    ))));

        // WelcomeScreen(title: 'WelcomeScreen',);
      }
    });
  }

  Future ioSNotifcationHandler() async {
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }
  }

  notificationOnMessagehandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("foreground handler${message.data}");
      print(message);
      if (notification != null && android != null) {
        print('here !!!');
        print('notification title: ${notification.title}');
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title.toString(),
            notification.body.toString(),
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id.toString(),
                channel.name.toString(),
                enableVibration: true,
                enableLights: true,
                importance: Importance.max,
                priority: Priority.max,
                channelDescription: channel.description,
                playSound: true,
                color: Color(0xff009E61),
                icon: '@drawable/ic_notification_icon',
              ),
            ));
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(
                      title: 'token',
                      ispremiumUser: true,
                    )),
            (route) => false);
      } else {
        print('inside else');
      }
    });
  }

  notificationOnMessageOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //AwesomeNotifications().cancelAll();
      print("onmesage open handler${message.data}");
      print(message);
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(
                      title: 'token',
                      ispremiumUser: true,
                    )),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/green_bg.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/grid.png"),
                fit: BoxFit.cover,
                //scale: 0.5
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.2,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/logo.png"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: SvgPicture.asset(
                "assets/images/welcomelogo.svg",
                //  color: Colors.white,
              ))
        ],
      ),
    );
  }
}
