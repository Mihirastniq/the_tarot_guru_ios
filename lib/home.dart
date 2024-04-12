import 'package:flutter/material.dart';
import 'package:the_tarot_guru/MainScreens/Products/cart.dart';
import 'package:the_tarot_guru/MainScreens/OshoZen.dart';
import 'package:the_tarot_guru/MainScreens/RiderWaite.dart';
import 'package:the_tarot_guru/MainScreens/Drawer/drawer.dart';
import 'package:the_tarot_guru/MainScreens/subscription/subscribe.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
  // ignore: unused_field
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
                'The Tarot Guru',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     SizedBox(
          //       height: AppBar().preferredSize.height,
          //     ),
          //     Container(
          //       height: MediaQuery.of(context).size.height - AppBar().preferredSize.height- AppBar().preferredSize.height,
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.vertical,
          //         child: Column(
          //           children: [
          //             Container(
          //               padding: EdgeInsets.fromLTRB(20, 30, 0, 25),
          //               width: MediaQuery.of(context).size.width,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     'hello',
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 35,
          //                         fontWeight: FontWeight.w800),
          //                   ),
          //                   Text(
          //                     '${firstName} ${lastName}',
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 23,
          //                         fontWeight: FontWeight.w600),
          //                   )
          //                 ],
          //               ),
          //             ),
          //             SizedBox(
          //               height: 10,
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(
          //                   left: 24, right: 24, top: 16, bottom: 18),
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(colors: [
          //                     Color(0xFF2633C5),
          //                     Color(0xFF6F56E8)
          //                   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          //                   borderRadius: BorderRadius.only(
          //                       topLeft: Radius.circular(18.0),
          //                       bottomLeft: Radius.circular(18.0),
          //                       bottomRight: Radius.circular(18.0),
          //                       topRight: Radius.circular(18.0)),
          //                   boxShadow: <BoxShadow>[
          //                     BoxShadow(
          //                         color: Color(0xFF3A5160).withOpacity(0.6),
          //                         offset: Offset(1.1, 1.1),
          //                         blurRadius: 10.0),
          //                   ],
          //                 ),
          //
          //                 child: Padding(
          //                     padding: const EdgeInsets.all(16.0),
          //                     child: Row(
          //                       children: [
          //                         Container(
          //                           padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          //                           width: 200,
          //                           child: Column(
          //                             mainAxisAlignment: MainAxisAlignment.center,
          //                             crossAxisAlignment: CrossAxisAlignment.start,
          //                             children: <Widget>[
          //                               Text(
          //                                 'The Tarot Guru',
          //                                 textAlign: TextAlign.left,
          //                                 style: TextStyle(
          //                                   // fontFamily: FitnessAppTheme.fontName,
          //                                   fontWeight: FontWeight.normal,
          //                                   fontSize: 14,
          //                                   letterSpacing: 0.0,
          //                                   color: Color(0xFFFFFFFF),
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsets.only(top: 8.0),
          //                                 child: const Text(
          //                                   'Buy Books of Osho Zen Tarot And Rider Waite Tarot',
          //                                   textAlign: TextAlign.left,
          //                                   style: TextStyle(
          //                                     // fontFamily: FitnessAppTheme.fontName,
          //                                     fontWeight: FontWeight.normal,
          //                                     fontSize: 20,
          //                                     letterSpacing: 0.0,
          //                                     color: Color(0xFFFFFFFF),
          //                                   ),
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 height: 32,
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsets.only(right: 4),
          //                                 child: Row(
          //                                   crossAxisAlignment: CrossAxisAlignment.end,
          //                                   mainAxisAlignment: MainAxisAlignment.start,
          //                                   children: <Widget>[
          //                                     Container(
          //                                         decoration: BoxDecoration(
          //                                           color: Colors.transparent,
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: ElevatedButton(
          //                                           onPressed: () {
          //                                             Navigator.push(
          //                                               context,
          //                                               MaterialPageRoute(builder: (context) => Products(),
          //                                               ),);
          //                                           },
          //                                           child: Text('Buy Now'),
          //                                         )
          //                                     ),
          //                                   ],
          //                                 ),
          //                               )
          //                             ],
          //                           ),
          //                         ),
          //                         Container(
          //                           child: Image.asset('assets/images/cards/osho.jpg',width: 100,),
          //                         ),
          //                       ],
          //                     )
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(
          //                   left: 24, right: 24, top: 16, bottom: 18),
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(colors: [
          //                     Color(0xffFFC711),
          //                     Color(0xFFFFD52D)
          //                   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          //                   borderRadius: BorderRadius.only(
          //                       topLeft: Radius.circular(18.0),
          //                       bottomLeft: Radius.circular(18.0),
          //                       bottomRight: Radius.circular(18.0),
          //                       topRight: Radius.circular(18.0)),
          //                   boxShadow: <BoxShadow>[
          //                     BoxShadow(
          //                         color: Color(0xFF3A5160).withOpacity(0.6),
          //                         offset: Offset(1.1, 1.1),
          //                         blurRadius: 10.0),
          //                   ],
          //                 ),
          //                 child: Padding(
          //                     padding: const EdgeInsets.all(16.0),
          //                     child: Row(
          //                       children: [
          //                         Container(
          //                           padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          //                           width: 200,
          //                           child: Column(
          //                             mainAxisAlignment: MainAxisAlignment.center,
          //                             crossAxisAlignment: CrossAxisAlignment.start,
          //                             children: <Widget>[
          //                               Padding(
          //                                 padding: const EdgeInsets.only(top: 8.0),
          //                                 child: const Text(
          //                                   'Osho Zen\nTarot',
          //                                   textAlign: TextAlign.left,
          //                                   style: TextStyle(
          //                                     // fontFamily: FitnessAppTheme.fontName,
          //                                     fontWeight: FontWeight.w800,
          //                                     fontSize: 30,
          //                                     letterSpacing: 0.0,
          //                                     color: Color(0xFFFFFFFF),
          //                                   ),
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 height: 32,
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsets.only(right: 4),
          //                                 child: Row(
          //                                   crossAxisAlignment: CrossAxisAlignment.end,
          //                                   mainAxisAlignment: MainAxisAlignment.start,
          //                                   children: <Widget>[
          //                                     Container(
          //                                         decoration: BoxDecoration(
          //                                           color: Colors.transparent,
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: ElevatedButton(
          //                                           onPressed: () {
          //                                             Navigator.push(
          //                                               context,
          //                                               MaterialPageRoute(builder: (context) => OshoZenTarot(),
          //                                               ),);
          //                                           },
          //                                           child: Text('Start'),
          //                                         )
          //                                     ),
          //                                   ],
          //                                 ),
          //                               )
          //                             ],
          //                           ),
          //                         ),
          //                         Container(
          //                           child: Image.asset('assets/images/cards/osho.jpg',width: 100,),
          //                         ),
          //                       ],
          //                     )
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(
          //                   left: 24, right: 24, top: 16, bottom: 18),
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(colors: [
          //                     Color(0xffFE5A1C),
          //                     Color(0xFFFE7C22)
          //                   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          //                   borderRadius: BorderRadius.only(
          //                       topLeft: Radius.circular(18.0),
          //                       bottomLeft: Radius.circular(18.0),
          //                       bottomRight: Radius.circular(18.0),
          //                       topRight: Radius.circular(18.0)),
          //                   boxShadow: <BoxShadow>[
          //                     BoxShadow(
          //                         color: Color(0xFF3A5160).withOpacity(0.6),
          //                         offset: Offset(1.1, 1.1),
          //                         blurRadius: 10.0),
          //                   ],
          //                 ),
          //
          //                 child: Padding(
          //                     padding: const EdgeInsets.all(16.0),
          //                     child: Row(
          //                       children: [
          //                         Container(
          //                           padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
          //                           width: 200,
          //                           child: Column(
          //                             mainAxisAlignment: MainAxisAlignment.center,
          //                             crossAxisAlignment: CrossAxisAlignment.start,
          //                             children: <Widget>[
          //                               Padding(
          //                                 padding: const EdgeInsets.only(top: 8.0),
          //                                 child: const Text(
          //                                   'Rider Waite\nTarot',
          //                                   textAlign: TextAlign.left,
          //                                   style: TextStyle(
          //                                     // fontFamily: FitnessAppTheme.fontName,
          //                                     fontWeight: FontWeight.w800,
          //                                     fontSize: 30,
          //                                     letterSpacing: 0.0,
          //                                     color: Color(0xFFFFFFFF),
          //                                   ),
          //                                 ),
          //                               ),
          //                               SizedBox(
          //                                 height: 32,
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsets.only(right: 4),
          //                                 child: Row(
          //                                   crossAxisAlignment: CrossAxisAlignment.end,
          //                                   mainAxisAlignment: MainAxisAlignment.start,
          //                                   children: <Widget>[
          //                                     Container(
          //                                         decoration: BoxDecoration(
          //                                           color: Colors.transparent,
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: ElevatedButton(
          //                                           onPressed: () {
          //                                             Navigator.push(
          //                                               context,
          //                                               MaterialPageRoute(builder: (context) => RiderWaiteTarot(),
          //                                               ),);
          //                                           },
          //                                           child: Text('Start'),
          //                                         )
          //                                     ),
          //                                   ],
          //                                 ),
          //                               )
          //                             ],
          //                           ),
          //                         ),
          //                         Container(
          //                           child: Image.asset('assets/images/cards/rider.jpg',width: 100,),
          //                         ),
          //                       ],
          //                     )
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // )
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
                      'Hello,',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      'User Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                      ),
                    )
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
                          color: Color(0xFF9C89B3),
                          gradient: LinearGradient(
                            colors: [
                              // Color(0xff633CF7),
                              // Color(0xff8339F7),
                              // Color(0xff8339F7)
                              Color(0xff2B1B4D),
                              Color(0xff2B1B4D),
                              // Colors.grey.withOpacity(0.4),
                              // Colors.grey.withOpacity(0.4)
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
                              child: Image.asset('assets/images/cards/osho.jpg',width: 50,height: 50,),
                            ),
                            Text('Osho zen',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),)
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
                            Text('Rider Waite',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: (){},
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
                              child: Image.asset('assets/images/cards/osho.jpg',width: 75,height: 75,),
                            ),
                            Text('Products',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // GestureDetector(
                    //   onTap: (){},
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(25),
                    //         gradient: LinearGradient(
                    //             colors: [
                    //               Colors.grey.withOpacity(0.4),
                    //               Colors.grey.withOpacity(0.4)
                    //             ]
                    //         )
                    //     ),
                    //     width: double.infinity,
                    //     height: 150,
                    //     child: Row(
                    //       children: [
                    //         Container(
                    //           margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    //           padding: EdgeInsets.all(20),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(100),
                    //             color: Colors.grey.withOpacity(0.1),
                    //           ),
                    //           height: 100,
                    //           width: 100,
                    //           child: Icon(Icons.question_mark,size: 50,color: Colors.white,)
                    //         ),
                    //         Text('About The Tarot Guru',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),)
                    //       ],
                    //     ),
                    //   ),
                    // ),
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