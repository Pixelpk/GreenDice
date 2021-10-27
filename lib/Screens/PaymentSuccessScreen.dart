import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'HomeScreen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  String? accesstoken;
  bool ispremiumUser ;
  PaymentSuccessScreen({Key? key, required this.accesstoken,required this.ispremiumUser}) : super(key: key);

  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => HomeScreen(
                    title: widget.accesstoken!,
                ispremiumUser: widget.ispremiumUser,
                  )),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdbf1e9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset('assets/images/successpayment.json'),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Payment Successfull',style: TextStyle(
            fontSize: 20
          ),)
        ],
      ),
    );
  }
}
