import 'package:flutter/material.dart';
import 'package:the_tarot_guru/MainScreens/Drawer/drawer.dart';
import 'package:the_tarot_guru/MainScreens/OtherScreens/settings.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
                'Profile',
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
                            Icon(Icons.account_circle_outlined,weight: 100,size: 100,color: Colors.white,),
                            SizedBox(
                              height: 10,
                            ),
                            Text('User Name',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w800),),
                            Text('User@gmail.com',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                        label: Text(
                          "User Details",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 3, 133, 194),
                          fixedSize: const Size(208, 43),
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                        label: Text(
                          "Orders",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 3, 133, 194),
                          fixedSize: const Size(208, 43),
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                        label: Text(
                          "Settings",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 3, 133, 194),
                          fixedSize: const Size(208, 43),
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                        label: Text(
                          "Subscription",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 3, 133, 194),
                          fixedSize: const Size(208, 43),
                        ),
                      )
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 24, right: 24, top: 16, bottom: 18),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       gradient: LinearGradient(colors: [
                      //         Color(0xFF2633C5),
                      //         Color(0xFF6F56E8)
                      //       ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(18.0),
                      //           bottomLeft: Radius.circular(18.0),
                      //           bottomRight: Radius.circular(18.0),
                      //           topRight: Radius.circular(18.0)),
                      //       boxShadow: <BoxShadow>[
                      //         BoxShadow(
                      //             color: Color(0xFF3A5160).withOpacity(0.6),
                      //             offset: Offset(1.1, 1.1),
                      //             blurRadius: 10.0),
                      //       ],
                      //     ),
                      //
                      //     child: Padding(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: Row(
                      //           children: [
                      //             Container(
                      //               padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      //               width: 200,
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: <Widget>[
                      //                   Text(
                      //                     'The Tarot Guru',
                      //                     textAlign: TextAlign.left,
                      //                     style: TextStyle(
                      //                       // fontFamily: FitnessAppTheme.fontName,
                      //                       fontWeight: FontWeight.normal,
                      //                       fontSize: 14,
                      //                       letterSpacing: 0.0,
                      //                       color: Color(0xFFFFFFFF),
                      //                     ),
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(top: 8.0),
                      //                     child: const Text(
                      //                       'Buy Books of Osho Zen Tarot And Rider Waite Tarot',
                      //                       textAlign: TextAlign.left,
                      //                       style: TextStyle(
                      //                         // fontFamily: FitnessAppTheme.fontName,
                      //                         fontWeight: FontWeight.normal,
                      //                         fontSize: 20,
                      //                         letterSpacing: 0.0,
                      //                         color: Color(0xFFFFFFFF),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   SizedBox(
                      //                     height: 32,
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(right: 4),
                      //                     child: Row(
                      //                       crossAxisAlignment: CrossAxisAlignment.end,
                      //                       mainAxisAlignment: MainAxisAlignment.start,
                      //                       children: <Widget>[
                      //                         Container(
                      //                             decoration: BoxDecoration(
                      //                               color: Colors.transparent,
                      //                               shape: BoxShape.circle,
                      //                             ),
                      //                             child: ElevatedButton(
                      //                               onPressed: () {
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(builder: (context) => Products(),
                      //                                   ),);
                      //                               },
                      //                               child: Text('Buy Now'),
                      //                             )
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             Container(
                      //               child: Image.asset('assets/images/cards/osho.jpg',width: 100,),
                      //             ),
                      //           ],
                      //         )
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 24, right: 24, top: 16, bottom: 18),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       gradient: LinearGradient(colors: [
                      //         Color(0xffFFC711),
                      //         Color(0xFFFFD52D)
                      //       ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(18.0),
                      //           bottomLeft: Radius.circular(18.0),
                      //           bottomRight: Radius.circular(18.0),
                      //           topRight: Radius.circular(18.0)),
                      //       boxShadow: <BoxShadow>[
                      //         BoxShadow(
                      //             color: Color(0xFF3A5160).withOpacity(0.6),
                      //             offset: Offset(1.1, 1.1),
                      //             blurRadius: 10.0),
                      //       ],
                      //     ),
                      //     child: Padding(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: Row(
                      //           children: [
                      //             Container(
                      //               padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      //               width: 200,
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: <Widget>[
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(top: 8.0),
                      //                     child: const Text(
                      //                       'Osho Zen\nTarot',
                      //                       textAlign: TextAlign.left,
                      //                       style: TextStyle(
                      //                         // fontFamily: FitnessAppTheme.fontName,
                      //                         fontWeight: FontWeight.w800,
                      //                         fontSize: 30,
                      //                         letterSpacing: 0.0,
                      //                         color: Color(0xFFFFFFFF),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   SizedBox(
                      //                     height: 32,
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(right: 4),
                      //                     child: Row(
                      //                       crossAxisAlignment: CrossAxisAlignment.end,
                      //                       mainAxisAlignment: MainAxisAlignment.start,
                      //                       children: <Widget>[
                      //                         Container(
                      //                             decoration: BoxDecoration(
                      //                               color: Colors.transparent,
                      //                               shape: BoxShape.circle,
                      //                             ),
                      //                             child: ElevatedButton(
                      //                               onPressed: () {
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(builder: (context) => OshoZenTarot(),
                      //                                   ),);
                      //                               },
                      //                               child: Text('Start'),
                      //                             )
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             Container(
                      //               child: Image.asset('assets/images/cards/osho.jpg',width: 100,),
                      //             ),
                      //           ],
                      //         )
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       left: 24, right: 24, top: 16, bottom: 18),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       gradient: LinearGradient(colors: [
                      //         Color(0xffFE5A1C),
                      //         Color(0xFFFE7C22)
                      //       ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(18.0),
                      //           bottomLeft: Radius.circular(18.0),
                      //           bottomRight: Radius.circular(18.0),
                      //           topRight: Radius.circular(18.0)),
                      //       boxShadow: <BoxShadow>[
                      //         BoxShadow(
                      //             color: Color(0xFF3A5160).withOpacity(0.6),
                      //             offset: Offset(1.1, 1.1),
                      //             blurRadius: 10.0),
                      //       ],
                      //     ),
                      //
                      //     child: Padding(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: Row(
                      //           children: [
                      //             Container(
                      //               padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      //               width: 200,
                      //               child: Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: <Widget>[
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(top: 8.0),
                      //                     child: const Text(
                      //                       'Rider Waite\nTarot',
                      //                       textAlign: TextAlign.left,
                      //                       style: TextStyle(
                      //                         // fontFamily: FitnessAppTheme.fontName,
                      //                         fontWeight: FontWeight.w800,
                      //                         fontSize: 30,
                      //                         letterSpacing: 0.0,
                      //                         color: Color(0xFFFFFFFF),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   SizedBox(
                      //                     height: 32,
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(right: 4),
                      //                     child: Row(
                      //                       crossAxisAlignment: CrossAxisAlignment.end,
                      //                       mainAxisAlignment: MainAxisAlignment.start,
                      //                       children: <Widget>[
                      //                         Container(
                      //                             decoration: BoxDecoration(
                      //                               color: Colors.transparent,
                      //                               shape: BoxShape.circle,
                      //                             ),
                      //                             child: ElevatedButton(
                      //                               onPressed: () {
                      //                                 Navigator.push(
                      //                                   context,
                      //                                   MaterialPageRoute(builder: (context) => RiderWaiteTarot(),
                      //                                   ),);
                      //                               },
                      //                               child: Text('Start'),
                      //                             )
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //             Container(
                      //               child: Image.asset('assets/images/cards/rider.jpg',width: 100,),
                      //             ),
                      //           ],
                      //         )
                      //     ),
                      //   ),
                      // ),
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
}
