import 'package:flutter/material.dart';
import 'package:the_tarot_guru/MainScreens/Deck/OshoCards.dart';
import 'package:the_tarot_guru/MainScreens/OtherScreens/settings.dart';

class DeckScreen extends StatelessWidget {
  final String tarotType;

  const DeckScreen({Key? key, required this.tarotType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> deckOptions = []; // Initialize an empty list to store deck options


    if (tarotType == 'Osho Zen') {
      deckOptions = [
        "Major Arcana",
        "Fire",
        "Water",
        "Earth",
        "Clouds",
      ];
    } else if (tarotType == 'Rider Waite') {
      deckOptions = [
        "Major Arcana",
        "Pentacles",
        "Cups",
        "Swords",
        "Wands",
      ];
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
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
          // Background Image
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(deckOptions.length, (index) {
                              return _buildButton(context, deckOptions[index]);
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '$tarotType Tarot',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildButton(BuildContext context, String text) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 90.0,
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [

                    Colors.indigo,
                    Colors.indigo
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OshoCardSelectionScreen(
                          tarotType: tarotType,
                          deckOption: text,
                        )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0, // Remove elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}