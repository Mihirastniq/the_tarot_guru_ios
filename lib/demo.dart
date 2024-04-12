import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoDesign extends StatefulWidget {
  const DemoDesign({super.key});

  @override
  State<DemoDesign> createState() => _DemoDesignState();
}

class _DemoDesignState extends State<DemoDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF272727),
                  Color(0xFF272727),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/product.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.1),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Spread Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                // IconButton(
                //   icon: Icon(Icons.save),
                //   color: Colors.white,
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => Setting()),
                //     );
                //   },
                // ),
                // IconButton(
                //   icon: Icon(Icons.palette),
                //   color: Colors.white,
                //   onPressed: () {
                //     changeTheme(context);
                //   },
                // ),
              ],
            ),
          ),
          Center(
            child: Container(
              // color: Colors.white,
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                // color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/other/osho_content_bg.png'),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
