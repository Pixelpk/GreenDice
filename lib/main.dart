import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // descriptionf
    importance: Importance.high,
    enableLights: true,
    enableVibration: true,
    showBadge: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("background handler${message.data}");
  print(message);

}
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,

  );

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
