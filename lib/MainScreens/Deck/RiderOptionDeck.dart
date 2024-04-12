import 'package:flutter/material.dart';
import 'package:the_tarot_guru/MainScreens/OtherScreens/settings.dart';
import 'RiderCards.dart';

class RiderDeckScreen extends StatefulWidget {
  final String tarotType;
  const RiderDeckScreen({super.key, required this.tarotType});

  @override
  State<RiderDeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<RiderDeckScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> deckOptions = []; // Initialize an empty list to store deck options


    if (widget.tarotType == 'Osho Zen') {
      deckOptions = [
        "Major Arcana",
        "Fire",
        "Water",
        "Earth",
        "Clouds",
      ];
    } else if (widget.tarotType == 'Rider Waite') {
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
                '${widget.tarotType} Tarot',
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

  Widget _buildButton(BuildContext context, String deckOption) {
    return GestureDetector(
        onTap:() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RiderCardsScreen(
                  tarotType: widget.tarotType,
                  deckOption: deckOption,
                )),
          );
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
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
                Text('${deckOption}',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w800),)
              ],
            ),
          ),
        )
    );}
}