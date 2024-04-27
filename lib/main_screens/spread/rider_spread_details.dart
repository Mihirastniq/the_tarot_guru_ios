import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/controller/audio/audio_controller.dart';
import '../other_screens/settings.dart';
import '../controller/functions.dart';
import 'ActiveSpread.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TheRiderSpreadDetailsScreen extends StatefulWidget {
  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  TheRiderSpreadDetailsScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });
  @override
  _TheSpreadDetailsScreenState createState() => _TheSpreadDetailsScreenState();
}

class _TheSpreadDetailsScreenState extends State<TheRiderSpreadDetailsScreen> {
  List<dynamic> cardData = [];
  late final AudioController _audioController;
  Future<List<dynamic>> fetchData() async {
    List<dynamic> allCardData = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String language = sp.getString('lang') ?? 'en';
    try {
      String data =
          await rootBundle.loadString('assets/json/rider_waite_data.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      // Access the top-level cards array directly
      List<dynamic>? cards = jsonData[language]['cards'];

      // Check if cards exist and iterate through them
      if (cards != null) {
        List<int> cardIds =
            widget.selectedCards.map((card) => card.id).toList();
        for (int id in cardIds) {
          Map<String, dynamic>? card = cards.firstWhere(
            (card) => card['id'] == id,
            orElse: () => null,
          );
          if (card != null) {
            allCardData.add({
              'card_image': card['card_image'] ?? '',
              'card_category': card['card_category'] ?? '',
              'card_name': card['card_name'] ?? '',
              'card_content': card['card_content'] ?? '',
              'card_description': card['card_description'] ?? '',
              'card_index': card['card_index'] ?? '',
              'reversed_content': card['reversed_content'] ?? '',
              'niscure_content': card['niscure_content'] ?? '',
              'vivran_content': card['vivran_content'] ?? '',
              'parinam_content': card['parinam_content'] ?? '',
              'vishesta_content': card['vishesta_content'] ?? '',
              'card_translated_category': card['card_translated_category'] ?? '',
            });
          }
        }
      }
    } catch (e) {
      print('Error fetching card data: $e');
    }

    return allCardData;
  }

  void initState() {
    super.initState();
    _audioController = AudioController();
    fetchData();
  }
  @override
  void dispose() {
    _audioController.stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height * 0.75;
    double imageAspectRatio = 2600 / 1480;
    double containerWidth = screenWidth / 2 - 10;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;
    return Scaffold(
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
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "${AppLocalizations.of(context)!.spreaddetails}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.save),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingScreenClass()),
                    );
                  },
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Center(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FutureBuilder<List<dynamic>>(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // or any other loading indicator
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<dynamic> cardData = snapshot.data!;
                                return ListView.builder(
                                  itemCount: cardData.length,
                                  itemBuilder: (context, index) {
                                    var currentCard = cardData[index];
                                    // Build UI for each card here
                                    return Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Container(
                                                  // padding: EdgeInsets.all(15),
                                                  // margin: EdgeInsets.fromLTRB(15, 15, 25, 0),
                                                  width: containerWidth,
                                                  height:
                                                  containerHeightWithAspectRatio,
                                                  child: Image.asset(
                                                    'assets/images/tarot_cards/${widget.tarotType}/${currentCard['card_category']}/${currentCard['card_image']}',
                                                    width: containerWidth,
                                                    height:
                                                    containerHeightWithAspectRatio,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(15)),
                                                  width: MediaQuery.sizeOf(context)
                                                      .width *
                                                      0.9,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            currentCard['card_name'],
                                                            style: _getTitleTextStyle(
                                                                context),
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.black,
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '${AppLocalizations.of(context)!.cardcategory} : ${currentCard['card_translated_category']}',
                                                        style: _getCustomTextStyle(
                                                            context),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      currentCard['card_content'] != null && currentCard['card_content'].isNotEmpty?
                                                      Column(
                                                        children: [
                                                          Text(
                                                            currentCard['card_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                            style: _getCustomTextStyle(context),
                                                          ),
                                                        ],
                                                      ) : SizedBox( height: 1,),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      currentCard['card_description'] != null && currentCard['card_description'].isNotEmpty ?
                                                      Column(
                                                        children: [
                                                          Text(
                                                              '${AppLocalizations.of(context)!.descriptioninspread}',
                                                              textAlign: TextAlign.center,
                                                              style: _getTitleTextStyle(context)
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                            currentCard['card_description'] ?? '', // If 'card_discription' is null, use an empty string
                                                            style: _getCustomTextStyle(context),
                                                          ),
                                                        ],
                                                      ) : SizedBox(
                                                        height: 1,
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      currentCard['reversed_content'] != null && currentCard['reversed_content'].isNotEmpty?
                                                      Column(
                                                        children: [
                                                          Text(
                                                              '${AppLocalizations.of(context)!.reversedinspread}',
                                                              textAlign: TextAlign.center,
                                                              style: _getTitleTextStyle(context)
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                            currentCard['reversed_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                            style: _getCustomTextStyle(context),
                                                          ),
                                                        ],
                                                      ) : SizedBox(
                                                        height: 1,
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      currentCard['niscure_content'] != null && currentCard['niscure_content'].isNotEmpty?
                                                      Column(
                                                        children: [
                                                          Text(
                                                              '${AppLocalizations.of(context)!.niscureinspread}',
                                                              textAlign: TextAlign.center,
                                                              style: _getTitleTextStyle(context)
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                            currentCard['niscure_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                            style: _getCustomTextStyle(context),
                                                          ),
                                                        ],
                                                      ) : SizedBox(
                                                        height: 1,
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      currentCard['vivran_content'] != null && currentCard['vivran_content'].isNotEmpty?
                                                      Column(
                                                        children: [
                                                          Text(
                                                              '${AppLocalizations.of(context)!.vivraninspread}',
                                                              textAlign: TextAlign.center,
                                                              style: _getTitleTextStyle(context)
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                            currentCard['vivran_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                            style: _getCustomTextStyle(context),
                                                          ),
                                                        ],
                                                      ) : SizedBox(
                                                        height: 1,
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      currentCard['parinam_content'] != null && currentCard['parinam_content'].isNotEmpty?
                                                      Column(
                                                        children: [
                                                          Text(
                                                              '${AppLocalizations.of(context)!.parinaminspread}',
                                                              textAlign: TextAlign.center,
                                                              style: _getTitleTextStyle(context)
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                            currentCard['parinam_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                            style: _getCustomTextStyle(context),
                                                          ),
                                                        ],
                                                      ) : SizedBox(
                                                        height: 1,
                                                      ),

                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      currentCard['vishesta_content'] != null && currentCard['vishesta_content'].isNotEmpty?
                                                      Column(
                                                        children: [
                                                          Text(
                                                              '${AppLocalizations.of(context)!.vishestainspread}',
                                                              textAlign: TextAlign.center,
                                                              style: _getTitleTextStyle(context)
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                            currentCard['vishesta_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                            style: _getCustomTextStyle(context),
                                                          ),
                                                        ],
                                                      ) : SizedBox(
                                                        height: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                    )
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF7CB89C), Color(0xFF7CB89C)],
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                _audioController.stopAudio();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => AppSelect()),
                                      (route) => false, // Remove all routes
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // Make button transparent
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                '${AppLocalizations.of(context)!.backtohome}',
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextStyle _getCustomTextStyle(BuildContext context) {
    double lineHeight = 1.8;

    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        height: lineHeight);

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          height: lineHeight);
    } else {
      return defaultStyle;
    }
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.black, fontSize: 23, fontWeight: FontWeight.w600);

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.black, fontSize: 23, fontWeight: FontWeight.w600);
    } else {
      return defaultStyle;
    }
  }
}
