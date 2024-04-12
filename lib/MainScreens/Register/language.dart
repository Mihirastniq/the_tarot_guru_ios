import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/home.dart';

class LanguageSelection extends StatefulWidget {
  final Map<String, dynamic> response;

  LanguageSelection({required this.response});

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String _selectedLanguage = 'English';

  String LOGINKEY = "isLogin";
  bool? isLogin = false;

  Future<void> updaterecord() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedLanguage.isNotEmpty) {
      widget.response['language'] = _selectedLanguage;
      try {
        String uri = "https://thetarotguru.com/tarotapi/userverifaction.php";
        widget.response['phone'] = widget.response['phone'].toString();
        widget.response['otp'] = widget.response['otp'].toString();
        var requestBody = widget.response;
        print("Update Request Body: $requestBody"); // Print request body
        var res = await http.post(Uri.parse(uri), body: requestBody);
        print("Response Status Code: ${res.statusCode}");
        print("Response Body: ${res.body}");

        var response = jsonDecode(res.body);
        if (response["status"] == 'success') {
          print("record inserted");
          prefs.setBool(LOGINKEY, true);
          prefs.setString('firstName', response['firstName']);
          prefs.setString('lastName', response['lastName']);
          prefs.setString('email', response['email']);
          prefs.setInt('phone', int.parse(response['phone']));
          prefs.setInt('appPin', int.parse(response['appPin']));
          prefs.setInt('userid', int.parse(response['userid']));
          prefs.setString('lang', response['lang']);
          prefs.setString('created_at', response['created_at']['created_at']);
          prefs.setInt('osho_zen_subscription', response['osho_zen_subscription']);
          prefs.setInt('rider_waite_subscription', response['rider_waite_subscription']);
          prefs.setInt('all_app_subscription', response['all_app_subscription']);
          prefs.setInt('free_by_admin', response['free_by_admin']);
          prefs.setInt('warning', response['warning']);
          _navigateToAppSelect();
        } else {
          print("some issue");
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Please select a language");
    }
  }

  void _storeCreatedAt(String createdAt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('created_at', createdAt);
  }

  void _navigateToAppSelect() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppSelect()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Select Language',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginbg.jpg'), // Replace with your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLanguageOption(context, 'English'),
                _buildLanguageOption(context, 'Hindi'),
                _buildLanguageOption(context, 'Gujarati'),
                _buildLanguageOption(context, 'Other Language'),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: updaterecord,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 97, 6, 215),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String language) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: _selectedLanguage == language ? Colors.white : Color(0xFFEF854F),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Row(
          children: [
            Icon(
              _selectedLanguage == language ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: _selectedLanguage == language ? Colors.black : Colors.white,
            ),
            SizedBox(width: 10.0),
            Text(
              language,
              style: TextStyle(
                color: _selectedLanguage == language ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            _selectedLanguage = language; // Update the selected language
          });
        },
      ),
    );
  }
}
