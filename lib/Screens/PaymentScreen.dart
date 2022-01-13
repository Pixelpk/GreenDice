import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/PaymenyResponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LogoutLoading.dart';
import 'PaymentSuccessScreen.dart';

class PaymenyScreen extends StatefulWidget {
  String? accessToken;

  String? packageId;
  PaymenyScreen({required this.accessToken, required this.packageId});
  @override
  State<StatefulWidget> createState() {
    return PaymenyScreenState();
  }
}

class PaymenyScreenState extends State<PaymenyScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  bool isLoading = false;

  String isYearlyPkg = '0';
  String isFourMonthPkg = '0';
  String isCharmans = '0';

  Future<void> Loadprefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isYearlyPkg = prefs.getString('isYearlyPkg') ?? '0';
      isFourMonthPkg = prefs.getString('isFourMonthPkg') ?? '0';
      isCharmans = prefs.getString('isChairman') ?? '0';
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Loadprefs() ;
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset('assets/images/paymentProcessing.json'),
                  ),
                  SizedBox(height: 50),
                  Text("Processing . . .")
                ],
              )
            : Container(
                decoration: BoxDecoration(
                  color: Color(0xffdbf1e9),
                ),
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      CreditCardWidget(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        showBackView: isCvvFocused,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                        cardBgColor: Color(0xff009E61), //Colors.red,

                        isSwipeGestureEnabled: true,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {},
                        customCardTypeIcons: <CustomCardTypeIcon>[
                          CustomCardTypeIcon(
                            cardType: CardType.mastercard,
                            cardImage: Image.asset(
                              'assets/images/mastercard.png',
                              height: 48,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              CreditCardForm(
                                formKey: formKey,
                                obscureCvv: true,
                                obscureNumber: true,
                                cardNumber: cardNumber,
                                cvvCode: cvvCode,
                                isHolderNameVisible: false,
                                isCardNumberVisible: true,
                                isExpiryDateVisible: true,
                                cardHolderName: cardHolderName,
                                expiryDate: expiryDate,
                                themeColor: Colors.blue,
                                textColor: Colors.black,
                                cardNumberDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                  hintStyle: const TextStyle(
                                    color: Color(0xff009E61),
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Color(0xff009E61),
                                  ),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                ),
                                expiryDateDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: const TextStyle(
                                    color: Color(0xff009E61),
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Color(0xff009E61),
                                  ),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                ),

                                cvvCodeDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: const TextStyle(
                                    color: Color(0xff009E61),
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Color(0xff009E61),
                                  ),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                ),


                                cardHolderDecoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: const TextStyle(
                                    color: Color(0xff009E61),
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Color(0xff009E61),
                                  ),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'Card Holder',
                                ),
                                onCreditCardModelChange:
                                    onCreditCardModelChange,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  primary: const Color(0xff009E61),
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Center(
                                    child: const Text(
                                      ' Buy Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'halter',
                                        fontSize: 14,
                                        package: 'flutter_credit_card',
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    print('valid!');
                                    if (widget.packageId != null &&
                                        widget.accessToken != null) {
                                      BuyPackage(
                                          cardNumber: cardNumber,
                                          cvc: cvvCode,
                                          expiry: expiryDate,
                                          package_id: widget.packageId!);
                                    }
                                  } else {
                                    print('invalid!');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future BuyPackage(
      {required String package_id,
      required String cardNumber,
      required String expiry,
      required String cvc}) async {
    String exp_year = expiry.split("/")[1];
    String exp_month = expiry.split("/")[0];
    print("expire year $exp_year");
    print("expire motn $exp_month");
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    print("token = " + widget.accessToken!);
    var response = await http.post(
        Uri.parse("https://app.greendiceinvestments.com/api/stripsubscription"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + widget.accessToken!,
        },
        body: {
          "package_id": package_id,
          "number": cardNumber,
          "exp_month": exp_month,
          "exp_year": exp_year,
          "cvc": cvc
        });
    print(response.body);
    print("PACKAGE ID: ${widget.packageId}");
    print("YEarly active : $isYearlyPkg");
    print("Quaterly Active: $isFourMonthPkg");
    if (response.body.contains("Subscription successfull")) {
      PaymentResponse paymentResponse =
          PaymentResponse.fromJson(jsonDecode(response.body));
      print('API STATUS SUCCESS');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (widget.packageId == '3') {
        prefs.setString('isChairman', widget.packageId == "3" ? '1' : '0');

        prefs.setString('chairman_pkg_sub_id', paymentResponse.data!.subscription!.subcriptionId!);

        if (isYearlyPkg == '1') {
          prefs.setString('isYearlyPkg', '1');
        }
        if (isFourMonthPkg == '1') {
          prefs.setString('isFourMonthPkg', '1');
        }
        if (isYearlyPkg == '0') {
          prefs.setString('isYearlyPkg', '0');
        }
        if (isFourMonthPkg == '0') {
          prefs.setString('isFourMonthPkg', '0');
        }
      }
      if(widget.packageId == '1')
        {
           prefs.setString('yearly_pkg_sub_id',  paymentResponse.data!.subscription!.subcriptionId!);

          prefs.setString('isYearlyPkg', widget.packageId == "1" ? '1' : '0');
          if(isCharmans == '1')
            {
              prefs.setString('isChairman', '1');
            }
          if(isCharmans == '0')
          {
            prefs.setString('isChairman', '0');
          }
          if (isFourMonthPkg == '0') {
            prefs.setString('isFourMonthPkg', '0');
          }

        }
      if(widget.packageId == '2')
      {
        prefs.setString('isFourMonthPkg', widget.packageId == "2" ? '1' : '0');
         prefs.setString('four_month_pkg_sub_id', paymentResponse.data!.subscription!.subcriptionId!);
        if(isCharmans == '1')
        {
          prefs.setString('isChairman', '1');
        }
        if (isYearlyPkg == '0') {
          prefs.setString('isYearlyPkg', '0');
        }
        if(isCharmans == '0')
        {
          prefs.setString('isChairman', '0');
        }

      }

      // prefs.setString('isYearlyPkg', widget.packageId == "1" ? '1' : '0');
      // prefs.setString('isFourMonthPkg', widget.packageId == "2" ? '1' : '0');

      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => PaymentSuccessScreen(
                ispremiumUser: true,
                accesstoken: widget.accessToken,
              )));
    } else if (response.body.contains("Already subscribed")) {
      print('API STATUS SUCCESS , PACKAGE ALREADY SUBSCRIBED');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      Fluttertoast.showToast(
          msg: "Package is Already Active",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.white,
          textColor: Color(0xFF009d60));
    }
    else if (response.body.contains("Your card was declined. Your request was in test mode, but used a non test (live) card.")) {
      print('API STATUS SUCCESS , PACKAGE ALREADY SUBSCRIBED');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      Fluttertoast.showToast(
          msg: "Your Card was declined",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.white,
          textColor: Color(0xFF009d60));
    }
    else if (response.body.contains("Your card number is incorrect.")) {
      print('API STATUS SUCCESS , PACKAGE ALREADY SUBSCRIBED');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      Fluttertoast.showToast(
          msg: "Your card number is incorrect.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.white,
          textColor: Color(0xFF009d60));
    }
    else if (response.body.contains("Premium package already subscribed")) {
      print('API STATUS SUCCESS , PACKAGE ALREADY SUBSCRIBED');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      Fluttertoast.showToast(
          msg: "Package is Already Active",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.white,
          textColor: Color(0xFF009d60));
    } else {
      if(response.body.contains("Unauthenticated."))
      {
        Navigator.of(context)
            .pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) =>
                    LogoutLoading(
                        token:
                        widget.accessToken!)),
                (route) => false);
      }
      Fluttertoast.showToast(
          msg: "Error! Please try again later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Color(0xFF009d60),
          textColor: Colors.white);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(title: "HomScreen")),
      );*/
    }
  }
}
