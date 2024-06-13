import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/main_screens/other_screens/forgot_pass_otp.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _SignInFiveState();
}

class _SignInFiveState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  Color fieldbbackground = Color(0xFF272B34);
  bool _emailflag = false;

  void _sendForgotPasswordRequest(String email) async {
    try {
      final response = await http.post(
        Uri.parse('https://thetarotguru.com/tarotapi/forgotpassword.php'),
        body: {
          'email': email,
          'request_type': 'forgot_password',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Check the status from the response
        if (jsonResponse['status'] == 'success') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForgotPasswordOTPVerify(email: jsonResponse['email'], otp: jsonResponse['otp']),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Incorrect email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 15,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Server error, Please try again after some time.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 15,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Technical error, Please try again after some time.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 15,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF02051F),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(4, 2, 12, 1.0),
                      Color.fromRGBO(4, 2, 12, 1.0),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Image.asset(
                  'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.1),
                ),
              ),
              //left side background design. I use a svg image here
              Positioned(
                left: -34,
                top: 181.0,
                child: SvgPicture.string(
                  // Group 3178
                  '<svg viewBox="-34.0 181.0 99.0 99.0" ><path transform="translate(-34.0, 181.0)" d="M 74.25 0 L 99 49.5 L 74.25 99 L 24.74999618530273 99 L 0 49.49999618530273 L 24.7500057220459 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-26.57, 206.25)" d="M 0 0 L 42.07500076293945 16.82999992370605 L 84.15000152587891 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(15.5, 223.07)" d="M 0 56.42999649047852 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 99.0,
                  height: 99.0,
                ),
              ),

              //right side background design. I use a svg image here
              Positioned(
                right: -52,
                top: 45.0,
                child: SvgPicture.string(
                  // Group 3177
                  '<svg viewBox="288.0 45.0 139.0 139.0" ><path transform="translate(288.0, 45.0)" d="M 104.25 0 L 139 69.5 L 104.25 139 L 34.74999618530273 139 L 0 69.5 L 34.75000762939453 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(298.42, 80.45)" d="M 0 0 L 59.07500076293945 23.63000106811523 L 118.1500015258789 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(357.5, 104.07)" d="M 0 79.22999572753906 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 139.0,
                  height: 139.0,
                ),
              ),

              //content ui
              Positioned(
                top: 8.0,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //logo section
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              logo(size.height / 8, size.height / 8),
                              const SizedBox(
                                height: 16,
                              ),
                              richText(23.12),
                            ],
                          ),
                        ),

                        //continue with email for sign in app text
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Enter your gmail for reset your password',
                            style: GoogleFonts.inter(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        //email and password TextField here
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              emailTextField(size),
                              customTextWidget('${AppLocalizations.of(context)!.regiureemail}', flag: _emailflag),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),

                        //sign in button & continue with text here
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              signInButton(size),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/images/intro/logo.png',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text(
      'Forgot Password',
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget emailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: fieldbbackground,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //mail icon
            const Icon(
              Icons.mail_rounded,
              color: Colors.white70,
            ),
            const SizedBox(
              width: 16,
            ),

            //divider svg
            SvgPicture.string(
              '<svg viewBox="99.0 332.0 1.0 15.5" ><path transform="translate(99.0, 332.0)" d="M 0 0 L 0 15.5" fill="none" fill-opacity="0.6" stroke="#ffffff" stroke-width="1" stroke-opacity="0.6" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 1.0,
              height: 15.5,
            ),
            const SizedBox(
              width: 16,
            ),

            //email address textField
            Expanded(
              child: TextField(
                maxLines: 1,
                controller: _emailController,
                cursorColor: Colors.white70,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                    hintText: '${AppLocalizations.of(context)!.loginemaillabel}',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.0,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextWidget(String text, {bool flag = true}) {
    return flag
        ? Text(
      text,
      style: TextStyle(
        fontSize: 19,
        color: Colors.white,
      ),
      textAlign: TextAlign.left,
    )
        : SizedBox.shrink(); // If flag is false, return an empty SizedBox
  }

  Widget signInButton(Size size) {
    return GestureDetector(
      onTap: () {
        setState(() {

          if (_emailController.text.isEmpty) {
            setState(() {
              _emailflag = true;
            });
          } else {
            setState(() {
              _emailflag = false;
            });
          }

          if (!_emailflag) {
            _sendForgotPasswordRequest(_emailController.text);
          }
        });


      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Text(
          'Forgot Password',
          style: GoogleFonts.inter(
            fontSize: 22.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}