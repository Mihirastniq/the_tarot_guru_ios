import 'package:flutter/material.dart';

class SubscriptionExpire extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onPressed;

  const SubscriptionExpire({
    Key? key,
    required this.title,
    required this.message,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFFF4E4BD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: MediaQuery.of(context).size.width * 0.2,
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: onPressed,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF8D7F55),
                                Color(0xFF8D7F55),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ElevatedButton(
                            onPressed: onPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Subscribe Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
