import 'package:flutter/material.dart';
import 'package:the_tarot_guru/main_screens/Deck/osho_cards.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeckScreen extends StatefulWidget {
  final String tarotType;
  const DeckScreen({Key? key, required this.tarotType});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  late double TitleFontsSize = 23;
  late double SubTitleFontsSize = 18;
  late double ContentFontsSize =16 ;
  late double ButtonFontsSize =25;
  @override
  void initState() {
    super.initState();
    _loadLocalData();
  }
  _loadLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      TitleFontsSize = prefs.getDouble('TitleFontSize') ?? 23;
      SubTitleFontsSize = prefs.getDouble('SubtitleFontSize') ?? 18;
      ContentFontsSize = prefs.getDouble('ContentFontSize') ?? 16;
      ButtonFontsSize = prefs.getDouble('ButtonFontSize') ?? 25;
    });
  }

  @override
  Widget build(BuildContext context) {
    late Map<String, String> deckOptions;

    if (widget.tarotType == 'Osho Zen') {
      deckOptions = {
        "Major Arcana": "${AppLocalizations.of(context)!.oshomajorarcana}",
        "Fire": "${AppLocalizations.of(context)!.oshofire}",
        "Water": "${AppLocalizations.of(context)!.oshowater}",
        "Earth": "${AppLocalizations.of(context)!.oshoearth}",
        "Clouds": "${AppLocalizations.of(context)!.oshoclouds}",
      };
    } else if (widget.tarotType == 'Rider Waite') {
      deckOptions = {
        "Major Arcana": "${AppLocalizations.of(context)!.ridermajorarcana}",
        "Pentacles": "${AppLocalizations.of(context)!.riderpentacles}",
        "Cups": "${AppLocalizations.of(context)!.ridercups}",
        "Swords": "${AppLocalizations.of(context)!.riderswords}",
        "Wands": "${AppLocalizations.of(context)!.riderwands}",
      };
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
                            children: deckOptions.entries.map((entry) {
                              return _buildButton(context, entry.key, entry.value);
                            }).toList(),
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
                '${AppLocalizations.of(context)!.oshofulltitle}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildButton(BuildContext context, String key, String deckOption) {
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
                          tarotType: widget.tarotType,
                          deckOption: key,
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
                  deckOption,
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: ButtonFontsSize,
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