import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pin_set.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OTPVerifyPageState extends StatefulWidget {

  final Map<String, dynamic> response;
  OTPVerifyPageState(this.response);


  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<OTPVerifyPageState> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  late FocusNode _focusNode1;
  late FocusNode _focusNode2;
  late FocusNode _focusNode3;
  late FocusNode _focusNode4;

  @override
  void initState() {
    super.initState();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
    _focusNode3 = FocusNode();
    _focusNode4 = FocusNode();
  }

  void _onContinuePress() async {
    String pin = _controller1.text + _controller2.text + _controller3.text + _controller4.text;

    int otpFromResponse = widget.response['otp']; // Get the OTP from the response object
    String otpFromResponseString = otpFromResponse.toString(); // Convert it to a string
    if (pin == otpFromResponseString) { // Compare the entered OTP with the OTP from the response
      widget.response['otp_status'] = 'match';
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SetLoginPin(response: widget.response)),
      );
    } else {
      // Incorrect OTP entered, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Incorrect OTP. Please try again.',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
      // Clear the entered OTP
      setState(() {
        pin = '';
      });
    }

  }


  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Screen_Backgrounds/introbgdark.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/demoimg/logo.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  '${AppLocalizations.of(context)!.otpscreenlabel}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${AppLocalizations.of(context)!.otpscreensubtitle}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: _textFieldOTP(first: true, last: false, controller: _controller1, focusNode: _focusNode1)),
                          SizedBox(width: 10), // Add space between boxes
                          Expanded(child: _textFieldOTP(first: false, last: false, controller: _controller2, focusNode: _focusNode2)),
                          SizedBox(width: 10), // Add space between boxes
                          Expanded(child: _textFieldOTP(first: false, last: false, controller: _controller3, focusNode: _focusNode3)),
                          SizedBox(width: 10), // Add space between boxes
                          Expanded(child: _textFieldOTP(first: false, last: true, controller: _controller4, focusNode: _focusNode4)),
                        ],
                      ),

                      SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onContinuePress,
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              '${AppLocalizations.of(context)!.verifylabel}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _textFieldOTP({bool first = false, bool last = false, required TextEditingController controller, required FocusNode focusNode}) {
    return Container(
      height: 85,
      width: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: first, // Autofocus on the first field
          controller: controller,
          focusNode: focusNode, // Pass the focus node
          onChanged: (value) {
            if (value.isNotEmpty && !last) {
              // If the current field is not the last one and becomes non-empty, move focus to the next field
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && !first) {
              // If the current field is not the first one and becomes empty, move focus to the previous field
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}