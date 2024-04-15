// import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/home.dart';
// import 'package:the_tarot_guru/main_screens/controller/audio_controller.dart';
//
// class PinEntryScreen extends StatefulWidget {
//   @override
//   _PinEntryScreenState createState() => _PinEntryScreenState();
// }
//
// class _PinEntryScreenState extends State<PinEntryScreen> {
//   String _pin = '';
//
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//
//   // Function to handle pin digit input
//   void _onDigitPress(String digit) {
//     if (_pin.length < 4) {
//       setState(() {
//         _pin += digit;
//       });
//     }
//   }
//
//   // Function to handle backspace
//   void _onBackspacePress() {
//     if (_pin.isNotEmpty) {
//       setState(() {
//         _pin = _pin.substring(0, _pin.length - 1);
//       });
//     }
//   }
//
//   void _onContinuePress() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final int? storedLoginPin = prefs.getInt('appPin');
//
//     if (int.parse(_pin) == storedLoginPin) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => AppSelect()),
//         );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Incorrect PIN. Please try again. your pin is ${storedLoginPin}',
//             style: TextStyle(color: Colors.black),
//           ),
//           backgroundColor: Colors.white,
//         ),
//       );
//       setState(() {
//         _pin = '';
//       });
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Theme.of(context).primaryColor,
//                   Theme.of(context).scaffoldBackgroundColor, // Use scaffold background color
//                 ],
//               ),
//             ),
//           ),
//           // Image overlay
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/pngbackround.png', // Replace with your image path
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // PIN entry section
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   child: Container(
//                     padding: EdgeInsets.all(20.0),
//                     color: Colors.transparent,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Title: Enter PIN
//                         Text(
//                           'Enter PIN',
//                           style: TextStyle(
//                             fontSize: 30.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: 20.0),
//                         // PIN Fields
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: List.generate(
//                             4,
//                                 (index) => Container(
//                               width: 50.0,
//                               height: 50.0,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).unselectedWidgetColor, // Background color
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               child: Text(
//                                 index < _pin.length ? '*' : '',
//                                 style: TextStyle(
//                                   fontSize: 24.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.6,
//                   child: Container(
//                     padding: EdgeInsets.all(20.0),
//                     color: Colors.transparent,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildKeypadButton('1'),
//                             _buildKeypadButton('2'),
//                             _buildKeypadButton('3'),
//                           ],
//                         ),
//                         SizedBox(height: 10.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildKeypadButton('4'),
//                             _buildKeypadButton('5'),
//                             _buildKeypadButton('6'),
//                           ],
//                         ),
//                         SizedBox(height: 10.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildKeypadButton('7'),
//                             _buildKeypadButton('8'),
//                             _buildKeypadButton('9'),
//                           ],
//                         ),
//                         SizedBox(height: 10.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             SizedBox(width: 70.0),
//                             _buildKeypadButton('0'),
//                             GestureDetector(
//                               onTap: _onBackspacePress,
//                               child: Container(
//                                 width: 70.0,
//                                 height: 70.0,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).unselectedWidgetColor, // Background color
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: Icon(
//                                   Icons.backspace,
//                                   // color: Theme.of(context).iconTheme,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10.0),
//                         // Continue button
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child:Container(
//                                 height: 44.0,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     gradient: LinearGradient(
//                                         colors: [
//                                           Theme.of(context).hoverColor,
//                                           Theme.of(context).highlightColor
//                                         ])),
//                                 child: ElevatedButton(
//                                   onPressed: _onContinuePress,
//                                   style: ElevatedButton.styleFrom(
//                                       foregroundColor: Colors.white,
//                                       backgroundColor: Colors.transparent,
//                                       shadowColor: Colors.transparent),
//                                   child: Text('Verify'),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Function to build keypad button
//   Widget _buildKeypadButton(String digit) {
//     return GestureDetector(
//       onTap: () {
//         if (digit.isNotEmpty) {
//           _onDigitPress(digit);
//         }
//       },
//       child: Container(
//         width: 70.0,
//         height: 70.0,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: Theme.of(context).unselectedWidgetColor,
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Text(
//           digit,
//           style: TextStyle(
//             fontSize: 24.0,
//             // color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

//
import 'package:flutter/material.dart';

class PinEntryScreen extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<PinEntryScreen> {
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? storedLoginPin = prefs.getInt('appPin');

    String pin = _controller1.text + _controller2.text + _controller3.text + _controller4.text;

    if (int.parse(pin) == storedLoginPin) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppSelect()),
        );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          Fluttertoast.showToast(
            msg: 'Incorrect PIN. Please try again.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 20.0,
          ) as SnackBar
      );
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
                  // child: Image.asset(
                  //   'assets/images/demoimg/logo.png',
                  // ),
                  child: Text('logo',style: TextStyle(fontSize: 20),),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Enter Your Pin',
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
                  "Verify your secret pin",
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
                              'Verify',
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
