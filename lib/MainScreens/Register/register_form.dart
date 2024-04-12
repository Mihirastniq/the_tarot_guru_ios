import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:the_tarot_guru/MainScreens/controller/registration_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegistrationController _registrationController = Get.put(RegistrationController());


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF38215E),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Create Your Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildTextField(Icons.account_circle, "First Name",
                              _registrationController.first_name),
                          SizedBox(height: 10),
                          buildTextField(Icons.account_circle, "Last Name",
                              _registrationController.last_name),
                          SizedBox(height: 10),
                          buildTextField(Icons.email, "E-mail",
                              _registrationController.email),
                          SizedBox(height: 10),
                          buildTextField(Icons.phone, "Phone",
                              _registrationController.phone_number,
                              isEmail: false),
                          SizedBox(height: 10),
                          buildTextField(
                              Icons.calendar_today,
                              "Date of Birth",
                              isDateOfBirth: true,
                              _registrationController.dobController), // Pass dob controller
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Text('Gender'),
                                SizedBox(
                                  width: 10,
                                ),
                                buildGenderRadioButtons(),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          buildTextField(Icons.lock, "Password",
                              _registrationController.password,
                              isPassword: true),
                          SizedBox(height: 10),
                          buildTextField(Icons.lock, "Confirm Password",
                              _registrationController.confirm_password,
                              isPassword: true),
                          SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _registrationController.registerFunction(
                                    context); // Call RegisterFunction and pass necessary parameters
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, TextEditingController controller,
      {bool isPassword = false, bool isEmail = true, bool isDateOfBirth = false}) {
    return GestureDetector(
      onTap: isDateOfBirth
          ? () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            _registrationController.setDob(pickedDate);
          });
        }
      }
          : null,
      child: AbsorbPointer(
        absorbing: isDateOfBirth,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              width: 1.0,
              color: const Color(0xFFEFEFEF),
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType:
            isEmail ? TextInputType.emailAddress : TextInputType.text,
            style: GoogleFonts.inter(
              fontSize: 16.0,
              color: const Color(0xFF15224F),
            ),
            maxLines: 1,
            cursorColor: const Color(0xFF15224F),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide.none,
              ), // OutlineInputBorder
              filled: true,
              fillColor: Color(0xFFe7edeb),
              hintText: hintText,
              prefixIcon: Icon(
                icon,
                color: Colors.grey[600],
              ), // Icon
            ),
          ),
        ),
      ),
    );
  }


  Widget buildGenderRadioButtons() {
    return GetBuilder<RegistrationController>(
      builder: (_) => Row(
        children: [
          Radio<String>(
            value: 'Male',
            groupValue: _.gender.text,
            onChanged: (value) {
              _.gender.text = value!;
            },
          ),
          Text('Male', style: TextStyle(color: Colors.grey[600])),
          Radio<String>(
            value: 'Female',
            groupValue: _.gender.text,
            onChanged: (value) {
              _.gender.text = value!;
            },
          ),
          Text('Female', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}

// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   String _gender = '';
//   final RegistrationController _registrationController = Get.put(RegistrationController());
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xFF38215E),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//             maxHeight: MediaQuery.of(context).size.height,
//           ),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade800, Colors.blue.shade600],
//               begin: Alignment.topLeft,
//               end: Alignment.centerRight,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Register',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 46,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Create Your Account',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 5,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(15),
//                       topRight: Radius.circular(15),
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         buildTextField(Icons.account_circle, "First Name"),
//                         SizedBox(height: 10),
//                         buildTextField(Icons.account_circle, "Last Name"),
//                         SizedBox(height: 10),
//                         buildTextField(Icons.email, "E-mail"),
//                         SizedBox(height: 10),
//                         buildTextField(Icons.phone, "Phone", isEmail: false),
//                         SizedBox(height: 10),
//                         buildTextField(Icons.calendar_today, "Date of Birth", isEmail: false),
//                         SizedBox(height: 10),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 15),
//                           child:  Row(
//                             children: [
//                               Text('Gender'),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               buildGenderRadioButtons(),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         buildTextField(Icons.lock, "Password", isPassword: true),
//                         SizedBox(height: 10),
//                         buildTextField(Icons.lock, "Confirm Password", isPassword: true),
//                         SizedBox(height: 16),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () {
//
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 20),),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextField(IconData icon, String hintText,
//       {bool isPassword = false, bool isEmail = true}) {
//     return Container(
//       alignment: Alignment.center,
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(
//           width: 1.0,
//           color: const Color(0xFFEFEFEF),
//         ),
//       ),
//       child: TextField(
//         obscureText: isPassword,
//         keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//         style: GoogleFonts.inter(
//           fontSize: 16.0,
//           color: const Color(0xFF15224F),
//         ),
//         maxLines: 1,
//         cursorColor: const Color(0xFF15224F),
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(0),
//             borderSide: BorderSide.none,
//           ), // OutlineInputBorder
//           filled: true,
//           fillColor: Color(0xFFe7edeb),
//           hintText: "Password",
//           prefixIcon: Icon(
//             Icons.lock,
//             color: Colors.grey[600],
//           ), // Icon
//         ),
//       ),
//     );
//   }
//
//   Widget buildGenderRadioButtons() {
//     return Row(
//       children: [
//         Radio<String>(
//           value: 'Male',
//           groupValue: _gender,
//           onChanged: (value) {
//             setState(() {
//               _gender = value!;
//             });
//           },
//         ),
//         Text('Male', style: TextStyle(color: Colors.grey[600])),
//         Radio<String>(
//           value: 'Female',
//           groupValue: _gender,
//           onChanged: (value) {
//             setState(() {
//               _gender = value!;
//             });
//           },
//         ),
//         Text('Female', style: TextStyle(color: Colors.grey[600])),
//       ],
//     );
//   }
//
// }
