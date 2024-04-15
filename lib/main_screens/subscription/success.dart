import 'package:flutter/material.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscriptionSuccessPage extends StatefulWidget {
  const SubscriptionSuccessPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SubscriptionSuccessPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<SubscriptionSuccessPage> {
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
                        color: themeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.task_alt,size: 55,)
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "${AppLocalizations.of(context)!.thankyou}",
                    style: TextStyle(
                      color: themeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "${AppLocalizations.of(context)!.paymentsuccesstitle}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "${AppLocalizations.of(context)!.paymentsuccesssubmessage}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  Container(
                      height: 48,
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            colors: [
                              Colors.cyan,
                              Colors.greenAccent,
                            ],
                          ),
                          boxShadow: glowing
                              ? [
                            BoxShadow(
                              color: Colors.cyan.withOpacity(0.6),
                              spreadRadius: 1,
                              blurRadius: 16,
                              offset: Offset(-8, 0),
                            ),
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.6),
                              spreadRadius: 1,
                              blurRadius: 16,
                              offset: Offset(8, 0),
                            ),
                            BoxShadow(
                              color: Colors.cyan.withOpacity(0.2),
                              spreadRadius: 16,
                              blurRadius: 32,
                              offset: Offset(-8, 0),
                            ),
                            BoxShadow(
                              color: Colors.greenAccent.withOpacity(0.2),
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
                              '${AppLocalizations.of(context)!.backtoapp}',
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



