import 'package:flutter/material.dart';
import 'package:the_tarot_guru/main_screens/Drawer/drawer.dart';
import 'package:the_tarot_guru/main_screens/spread/rider_new_spread.dart';
import 'deck/rider_option_deck.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RiderWaiteTarot extends StatefulWidget {
  @override
  _AppSelectState createState() => _AppSelectState();
}

class _AppSelectState extends State<RiderWaiteTarot> with TickerProviderStateMixin{
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
      Sidebar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF171625),
                  Color(0xFF171625),
                  // Color.fromRGBO(19, 14, 42, 1),
                  // Colors.deepPurple.shade900.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg2.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.1),
            ),
          ),
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: AppBar(
              leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.segment_rounded,
                      color: Colors.white,
                      size: 35,
                    )),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '${AppLocalizations.of(context)!.apptitle}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Container(
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height- AppBar().preferredSize.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 0, 25),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.riderfulltitle}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RiderNewSpread(tarotType: "Rider Waite"),
                                      ),
                                    );
                                  },
                                  text: "${AppLocalizations.of(context)!.newspreadd}",
                                  color1: Color(0xFF8826FE),
                                  color2: Color(0xFF9443F6),
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              _buildButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RiderDeckScreen(tarotType: "Rider Waite"),
                                      ),
                                    );
                                  },
                                  text: "${AppLocalizations.of(context)!.decktitle}",
                                  color1: Color(0xFFD7735C),
                                  color2: Color(0xFFD87D68),
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              _buildButton(
                                  onPressed: () {

                                  },
                                  text: "${AppLocalizations.of(context)!.savespread}",
                                  color1: Color(0xFF00B493),
                                  color2: Color(0xFF1BB89C),
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              _buildButton(
                                  onPressed: () {},
                                  text: "${AppLocalizations.of(context)!.aboutriderwaite}",
                                  color1: Color(0xFF32C0D4),
                                  color2: Color(0xFF00A7BE),
                                  opacity: 0.9,
                                  imagePath:'assets/images/demoimg/logo.png'
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton({
    required Function()? onPressed,
    required String text,
    required Color color1,
    required Color color2,
    required double opacity,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap:onPressed,
      child: Container(
        color: Color(0xFF171625).withOpacity(0.6),
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          height: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/other/button.png'),
                fit: BoxFit.cover,
                opacity: 0.5,
              ),
              border: Border.all(
                width: 2,
                color: Colors.grey.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${text}',style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.w800),)
            ],
          ),
        ),
      )
    );}

}


