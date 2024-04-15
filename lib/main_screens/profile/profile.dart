import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/Drawer/drawer.dart';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:the_tarot_guru/main_screens/profile/profile_screens_options.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String _firstName = '';
  late String _lastName = '';
  late String _email = '';

  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName = prefs.getString('firstName') ?? '';
    _lastName = prefs.getString('lastName') ?? '';
    _email = prefs.getString('email') ?? '';
    setState(() {}); // Update the UI with fetched data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1C1C2D),
                  Color(0xFF1C1C2D),

                  // Color.fromRGBO(19, 14, 42, 1),
                  // Color.fromRGBO(19, 14, 42, 1),
                  // Colors.deepPurple.shade900.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/product.png', // Replace with your image path
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
              title: Text(
                '${AppLocalizations.of(context)!.profilelabel}',
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
                padding: EdgeInsets.only(
                  left: 20,
                  top: 25,
                  right: 20
                ),
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height- AppBar().preferredSize.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pink,
                                    Colors.yellow,
                                  ]
                                )
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF1C1C2D),
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Icon(
                                  Icons.person_2,
                                  color: Colors.white,
                                  size: 50.0,
                                  semanticLabel: 'user icon',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$_firstName $_lastName',style: TextStyle(color: Colors.white,fontSize: 30),),
                                Text('$_email',style: TextStyle(color: Colors.white,fontSize: 20),),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      const Divider(
                        height: 15,
                        thickness: 1,
                        indent: 5,
                        endIndent: 0,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(
                          text: '${AppLocalizations.of(context)!.userdetails}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserDetailsScreen()),
                            );
                          },
                          icon: Icons.person_2),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(text: '${AppLocalizations.of(context)!.addresslabel}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UserAddresses()),
                            );
                          },
                          icon: Icons.location_city),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(text: '${AppLocalizations.of(context)!.orderslabel}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrdersScreen()),
                            );
                          },
                          icon: Icons.shopping_cart),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(text: '${AppLocalizations.of(context)!.settinglabel}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SettingScreenClass()),
                            );
                          },
                          icon: Icons.settings),
                      SizedBox(
                        height: 15,
                      ),
                      ProfileButton(text: '${AppLocalizations.of(context)!.subscriptionlabel}', onPressed: (){}, icon: Icons.loyalty),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              )
            ],
          )
        ],
      ),
    );
  }
}
