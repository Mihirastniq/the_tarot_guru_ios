import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_tarot_guru/main_screens/controller/registration_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegistrationController _registrationController = RegistrationController();


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
                        'register',
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
                ),
              )
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


  Widget buildGenderRadioButtons(RegistrationController controller) {
    return Row(
      children: [
        Radio<String>(
          value: 'Male',
          groupValue: controller.gender.text,
          onChanged: (value) {
            controller.gender.text = value!;
          },
        ),
        Text('Male', style: TextStyle(color: Colors.grey[600])),
        Radio<String>(
          value: 'Female',
          groupValue: controller.gender.text,
          onChanged: (value) {
            controller.gender.text = value!;
          },
        ),
        Text('Female', style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

}
