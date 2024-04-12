import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/MainScreens/Register/otp_verify.dart';

class RegistrationController extends GetxController {
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();
  TextEditingController dobController = TextEditingController();

  DateTime? _dob;
  DateTime? get dob => _dob;

  void setDob(DateTime? dob) {
    _dob = dob;
  }

  Future<void> registerFunction(BuildContext context) async {
    final String dobString = _dob != null ? _dob.toString() : '';
    if (first_name.text.isNotEmpty &&
        last_name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phone_number.text.isNotEmpty &&
        dobString.isNotEmpty &&
        gender.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirm_password.text.isNotEmpty) {
      try {
        final String uri = "https://thetarotguru.com/tarotapi/userregistration.php";
        final Map<String, String> requestBody = {
          "fname": first_name.text,
          "lname": last_name.text,
          "email": email.text,
          "phone": phone_number.text,
          "dob": dobString,
          "gender": gender.text,
          "password": password.text,
          "confirm_password": confirm_password.text,
        };
        print("Request Body: $requestBody"); // Print request body
        final http.Response res = await http.post(Uri.parse(uri), body: requestBody);
        print("Response Status Code: ${res.statusCode}");
        print("Response Body: ${res.body}");

        final dynamic response = jsonDecode(res.body);
        if (response["status"] == 'success') {
          print("record inserted");
          _navigateToOTPVerifyPage(response, context);
        } else {
          Fluttertoast.showToast(
            msg: response["message"], // Get error message from response
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 15,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Please fill all fields");
    }
  }

  void _navigateToOTPVerifyPage(Map<String, dynamic> response, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OTPVerifyPageState(response)),
    );
  }
}
