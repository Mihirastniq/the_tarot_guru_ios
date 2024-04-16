import 'package:flutter/material.dart';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:the_tarot_guru/main_screens/Profile/profile.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Sidebar extends StatelessWidget {

  final int selectedIndex;
  final Function(int) onItemTapped;

  const Sidebar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey,
              Colors.grey
              // Color.fromRGBO(102, 60, 248, 1),
              // Color.fromRGBO(132, 57, 246, 1),
            ],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  children: [
                    // Image.asset('assets/images/demoimg/logo.png',width: 75,height: 75,),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 0 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: ListTile(
                  title: Text('${AppLocalizations.of(context)!.home}', style: TextStyle(color: selectedIndex == 0 ? Colors.black : Colors.white)),
                  selected: selectedIndex == 0,
                  tileColor: selectedIndex == 0 ? Colors.black : Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppSelect(),),);
                    onItemTapped(0);
                    // Navigator.pop(context);
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 1 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text('${AppLocalizations.of(context)!.profile}', style: TextStyle(color: selectedIndex == 1 ? Colors.black : Colors.white)),
                  selected: selectedIndex == 1,
                  tileColor: selectedIndex == 1 ? Colors.black : Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile(),),);
                    onItemTapped(1);
                    // Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}