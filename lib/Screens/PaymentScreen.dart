import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:greendice/ModelClasses/PaymenyResponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:lottie/lottie.dart';

import 'PaymentSuccessScreen.dart';

class PaymenyScreen extends StatefulWidget {
  String? accessToken;
  String? packagePriceID;
  PaymenyScreen({required this.accessToken, required this.packagePriceID});
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
        resizeToAvoidBottomInset: false,
        body: isLoading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Lottie.asset('assets/images/paymentProcessing.json'),
                  ),
                SizedBox(height:50),
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
                                isHolderNameVisible: true,
                                isCardNumberVisible: true,
                                isExpiryDateVisible: true,
                                cardHolderName: cardHolderName,
                                expiryDate: expiryDate,
                                themeColor: Colors.blue,
                                textColor: Colors.white,
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
                                height: 20,
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
                                    if (widget.packagePriceID != null &&
                                        widget.accessToken != null) {
                                      BuyPackage(
                                          cardNumber: cardNumber,
                                          cvc: cvvCode,
                                          expiry: expiryDate,
                                          priceId: widget.packagePriceID!);
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
      {required String priceId,
      required String cardNumber,
      required String expiry,
      required String cvc}) async {
    String exp_year = expiry.split("/")[1];
    String exp_month = expiry.split("/")[0];
    print("expire year $exp_year");
    print("expire motn $exp_month");
    setState(() {
      isLoading = true;
    });
    print("token = " + widget.accessToken!);
    var response = await http.post(
        Uri.parse("http://syedu12.sg-host.com/api/stripsubscription"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + widget.accessToken!,
        },
        body: {
          "price": priceId,
          "number": cardNumber,
          "exp_month": exp_month,
          "exp_year": exp_year,
          "cvc": cvc
        });

    PaymentResponse paymentResponse =
        PaymentResponse.fromJson(jsonDecode(response.body));

    var val = '${paymentResponse.success}';
    print(jsonDecode(response.body));

    print(val);
    if (val == "1") {
      print('API STATUS SUCCESS');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => PaymentSuccessScreen(
                accesstoken: widget.accessToken,
              )));
    } else {
      Fluttertoast.showToast(
        msg: "Error! Please try again later",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
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
