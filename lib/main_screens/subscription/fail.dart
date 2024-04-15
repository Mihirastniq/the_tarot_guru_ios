import 'package:flutter/material.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/subscription/success.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentFailScreen extends StatefulWidget {
  const PaymentFailScreen({super.key});

  @override
  State<PaymentFailScreen> createState() => _PaymentFailScreenState();
}

class _PaymentFailScreenState extends State<PaymentFailScreen> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);
  var glowing = false;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(19, 14, 42, 1),
                      Color.fromRGBO(19, 14, 42, 1),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Image.asset(
                  'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(.1),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        height: 170,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close,size: 55,)
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "${AppLocalizations.of(context)!.sorry}",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 36,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "${AppLocalizations.of(context)!.paymentfailtitle}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    Container(
                        height: 48,
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                              colors: [
                                Colors.red,
                                Colors.redAccent,
                              ],
                            ),
                            boxShadow: glowing
                                ? [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.6),
                                spreadRadius: 1,
                                blurRadius: 16,
                                offset: Offset(-8, 0),
                              ),
                              BoxShadow(
                                color: Colors.redAccent.withOpacity(0.6),
                                spreadRadius: 1,
                                blurRadius: 16,
                                offset: Offset(8, 0),
                              ),
                              BoxShadow(
                                color: Colors.red.withOpacity(0.2),
                                spreadRadius: 16,
                                blurRadius: 32,
                                offset: Offset(-8, 0),
                              ),
                              BoxShadow(
                                color: Colors.red.withOpacity(0.2),
                                spreadRadius: 16,
                                blurRadius: 32,
                                offset: Offset(8, 0),
                              )
                            ]
                                : []),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AppSelect(),
                              ),);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.backtohome}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_circle_right,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                    )

                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
