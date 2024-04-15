// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:the_tarot_guru/main_screens/intro_screen.dart';
// import 'package:the_tarot_guru/main_screens/Login/login_pin.dart';
// import 'package:the_tarot_guru/introduction_animation/introduction_animation_screen.dart';
//
// class LoginController extends GetxController{
//   TextEditingController Username = TextEditingController();
//   TextEditingController password = TextEditingController();
//
//   String LOGINKEY = "isLogin";
//   bool? isLogin = false;
//
//   void UserLogin(BuildContext context) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (Username.text != "" || password.text != "") {
//       try {
//         String uri = "https://thetarotguru.com/tarotapi/userlogin.php";
//         var requestBody = {
//           "username": Username.text,
//           "password": password.text,
//         };
//         Fluttertoast.showToast(
//           msg: "Loading",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 15,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//         var res = await http.post(Uri.parse(uri), body: requestBody);
//         var response = jsonDecode(res.body);
//         if (response["status"] == 'success' ) {
//           prefs.setBool(LOGINKEY, true);
//           prefs.setString('firstName', response['firstName']);
//           prefs.setString('lastName', response['lastName']);
//           prefs.setString('email', response['email']);
//           prefs.setInt('phone', int.parse(response['phone']));
//           prefs.setInt('appPin', int.parse(response['appPin']));
//           prefs.setInt('userid', int.parse(response['userid']));
//           prefs.setString('lang', response['lang']);
//           prefs.setString('created_at', response['created_at']);
//           prefs.setInt('subscription_status', int.parse(response['subscription_status']));
//           prefs.setInt('free_by_admin', int.parse(response['free_by_admin']));
//           prefs.setInt('warning', int.parse(response['warning']));
//
//           Fluttertoast.showToast(
//             msg: "login Successs",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 15,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0,
//           );
//
//           NavigateToPinEntry(context);
//
//         } else {
//           Fluttertoast.showToast(
//             msg: response["message"],
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 15,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0,
//           );
//         }
//       } catch (e) {
//         print("Error: $e");
//       }
//     } else {
//       Fluttertoast.showToast(
//         msg: "fill all the fields",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 15,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }
//   void skipLogin() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     isLogin = prefs.getBool(LOGINKEY);
//
//     if(isLogin == true) {
//       print('home');
//       NavigateToPinEntry(Get.context!);
//     } else {
//       print('No home');
//       NavigateToIntro(Get.context!);
//       // NavigateToIntro();
//     }
//   }
//   @override
//   void onInit() {
//     super.onInit();
//     skipLogin();
//   }
//   void NavigateToPinEntry(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => PinEntryScreen()),
//     );
//   }
//   void NavigateToIntro(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => IntroductionAnimationScreen()),
//     );
//   }
//   void logout(BuildContext context) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(LOGINKEY, false);
//     NavigateToIntro(context);
//   }
// }
