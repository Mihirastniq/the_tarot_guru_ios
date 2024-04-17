import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tarot_guru/main_screens/Products/cart.dart';
import 'package:the_tarot_guru/main_screens/OshoZen.dart';
import 'package:the_tarot_guru/main_screens/RiderWaite.dart';
import 'package:the_tarot_guru/main_screens/Drawer/drawer.dart';
import 'package:the_tarot_guru/main_screens/controller/counter_provider.dart';
import 'package:the_tarot_guru/main_screens/products/products.dart';
import 'package:the_tarot_guru/main_screens/subscription/subscribe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main_screens/controller/language_controller/language_change_handler.dart';



class AppSelect extends StatefulWidget {
  @override
  _AppSelectState createState() => _AppSelectState();
}

class _AppSelectState extends State<AppSelect> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    super.initState();
    _loadFirstName();
  }

  _loadFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
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
                  Color.fromRGBO(19, 14, 42, 1),
                  Color.fromRGBO(19, 14, 42, 1),
                  Colors.deepPurple.shade900.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
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
              actions: [
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage(),
                    ),
                  );
                }, icon: Icon(
                  Icons.shopping_bag,
                  size: 30,
                  color: Colors.white,
                )),
                IconButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SubscribeApp(),
                    ),
                  );
                }, icon: Icon(
                  Icons.money,
                  size: 30,
                  color: Colors.white,
                ))
              ],
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height*2,
                    ),
                    Text(
                      AppLocalizations.of(context)!.hello,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      '${firstName} ${lastName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OshoZenTarot()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),

    image: DecorationImage(
                                  image: AssetImage('assets/images/other/LogoBg.png'),
                                  fit: BoxFit.cover,
                                  opacity: 0.5,
                                ),
                          border: Border.all(
                            width: 2,
                            color: Color(0xFF906BFF)
                          )
                        ),
                        width: double.infinity,
                        height: 150,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              height: 100,
                              width: 100,
                              child: Image.asset('assets/images/cards/osho.jpg',width: 50,height: 50,),
                            ),
                            Text('${AppLocalizations.of(context)!.oshotitle}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RiderWaiteTarot()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.grey.withOpacity(0.4),
                                  Colors.grey.withOpacity(0.4)
                                ]
                            ),
                            border: Border.all(
                                width: 2,
                                color: Color(0xFF906BFF)
                            )
                        ),
                        width: double.infinity,
                        height: 150,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey.withOpacity(0.1),

                              ),
                              height: 100,
                              width: 100,
                              child: Image.asset('assets/images/cards/rider.jpg',width: 75,height: 75,),
                            ),
                            Text('${AppLocalizations.of(context)!.ridertitle}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Products()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.grey.withOpacity(0.4),
                                  Colors.grey.withOpacity(0.4)
                                ]
                            ),
                          image: DecorationImage(
                            image: AssetImage('assets/images/other/LogoBg.png'),
                            fit: BoxFit.cover,
                            opacity: 0.5,
                          )
                        ),
                        width: double.infinity,
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('${AppLocalizations.of(context)!.producttitle}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}