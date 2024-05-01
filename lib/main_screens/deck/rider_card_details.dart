import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RiderCardDetailsScreen extends StatefulWidget {
  final String tarotType;
  final String cardId;
  final String deckOption;

  const RiderCardDetailsScreen({
    Key? key,
    required this.tarotType,
    required this.cardId,
    required this.deckOption,
  }) : super(key: key);

  @override
  _RiderCardDetailsScreenState createState() => _RiderCardDetailsScreenState();
}



class _RiderCardDetailsScreenState extends State<RiderCardDetailsScreen> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double imageAspectRatio = 2600 / 1480;

    double containerWidth = screenWidth / 2.5 - 5;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        // color: Colors.white
                      ),
                      child: FutureBuilder(
                        future: fetchCardDetails(widget.tarotType, widget.cardId),
                        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            final cardData = snapshot.data!;
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          width: containerWidth,
                                          height: containerHeightWithAspectRatio,
                                          'assets/images/tarot_cards/${widget.tarotType}/${widget.deckOption}/${cardData['card_image']}',
                                        ),
                                        SizedBox(
                                          height: 35,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              // color: Theme.of(context).primaryColor.withOpacity(0.6),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          width: MediaQuery.sizeOf(context).width*0.9,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(context).width *0.1,
                                                    child: Icon(Icons.star,color: Colors.white,),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.sizeOf(context).width * 0.5,
                                                    child: Text(cardData['card_name'],style: _getTitleTextStyle(context),textAlign: TextAlign.center,),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.sizeOf(context).width *0.1,
                                                    child: Icon(Icons.star,color: Colors.white,),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text('${AppLocalizations.of(context)!.cardcategory}: ${cardData['card_translated_category']}',style: _getCustomTextStyle(context),),

                                              SizedBox(
                                                height: 20,
                                              ),
                                              cardData['card_content'] != null && cardData['card_content'].isNotEmpty?
                                              Column(
                                                children: [
                                                  Text(
                                                    cardData['card_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                    style: _getCustomTextStyle(context),
                                                  ),
                                                ],
                                              ) : SizedBox( height: 1,),

                                              SizedBox(
                                                height: 20,
                                              ),
                                              cardData['card_description'] != null && cardData['card_description'].isNotEmpty ?
                                                  Column(
                                                    children: [
                                                      Text(
                                                          '${AppLocalizations.of(context)!.descriptioninspread}',
                                                          textAlign: TextAlign.center,
                                                          style: _getTitleTextStyle(context)
                                                      ),
                                                      SizedBox(height: 8.0),
                                                      Text(
                                                        cardData['card_description'] ?? '', // If 'card_discription' is null, use an empty string
                                                        style: _getCustomTextStyle(context),
                                                      ),
                                                    ],
                                                  ) : SizedBox(
                                                height: 1,
                                              ),

                                              SizedBox(
                                                height: 20,
                                              ),
                                              cardData['reversed_content'] != null && cardData['reversed_content'].isNotEmpty?
                                              Column(
                                                children: [
                                                  Text(
                                                      '${AppLocalizations.of(context)!.reversedinspread}',
                                                      textAlign: TextAlign.center,
                                                      style: _getTitleTextStyle(context)
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    cardData['reversed_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                    style: _getCustomTextStyle(context),
                                                  ),
                                                ],
                                              ) : SizedBox(
                                                height: 1,
                                              ),

                                              SizedBox(
                                                height: 20,
                                              ),
                                              cardData['niscure_content'] != null && cardData['niscure_content'].isNotEmpty?
                                              Column(
                                                children: [
                                                  Text(
                                                      '${AppLocalizations.of(context)!.niscureinspread}',
                                                      textAlign: TextAlign.center,
                                                      style: _getTitleTextStyle(context)
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    cardData['niscure_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                    style: _getCustomTextStyle(context),
                                                  ),
                                                ],
                                              ) : SizedBox(
                                                height: 1,
                                              ),

                                              SizedBox(
                                                height: 20,
                                              ),
                                              cardData['vivran_content'] != null && cardData['vivran_content'].isNotEmpty?
                                              Column(
                                                children: [
                                                  Text(
                                                      '${AppLocalizations.of(context)!.vivraninspread}',
                                                      textAlign: TextAlign.center,
                                                      style: _getTitleTextStyle(context)
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    cardData['vivran_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                    style: _getCustomTextStyle(context),
                                                  ),
                                                ],
                                              ) : SizedBox(
                                                height: 1,
                                              ),

                                              SizedBox(
                                                height: 20,
                                              ),
                                              cardData['parinam_content'] != null && cardData['parinam_content'].isNotEmpty?
                                              Column(
                                                children: [
                                                  Text(
                                                      '${AppLocalizations.of(context)!.parinaminspread}',
                                                      textAlign: TextAlign.center,
                                                      style: _getTitleTextStyle(context)
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    cardData['parinam_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                    style: _getCustomTextStyle(context),
                                                  ),
                                                ],
                                              ) : SizedBox(
                                                height: 1,
                                              ),

                                              SizedBox(
                                                height: 20,
                                              ),
                                              cardData['vishesta_content'] != null && cardData['vishesta_content'].isNotEmpty?
                                              Column(
                                                children: [
                                                  Text(
                                                      '${AppLocalizations.of(context)!.vishestainspread}',
                                                      textAlign: TextAlign.center,
                                                      style: _getTitleTextStyle(context)
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    cardData['vishesta_content'] ?? '', // If 'card_discription' is null, use an empty string
                                                    style: _getCustomTextStyle(context),
                                                  ),
                                                ],
                                              ) : SizedBox(
                                                height: 1,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 35,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 60.0,
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF7CB89C),
                                  Color(0xFF7CB89C)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent, // Make button transparent
                                elevation: 0, // Remove elevation
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Back to home',
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                "Card Details",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingScreenClass()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.palette),
                  color: Colors.white,
                  onPressed: () {
                    changeTheme(context);
                  },
                ),
              ],
            ),
          ),
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
        height: lineHeight
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          height: lineHeight
      );
    } else {
      return defaultStyle;
    }
  }
  TextStyle _getTitleTextStyle(BuildContext context) {
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.black,
        fontSize: 23,
        fontWeight:
        FontWeight.w600
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.black,
          fontSize: 23,
          fontWeight:
          FontWeight.w600
      );
    } else {
      return defaultStyle;
    }
  }
}

Future<Map<String, dynamic>> fetchCardDetails(String tarotType, String cardId) async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String language = sp.getString('lang') ?? 'en';
    String jsonString = await rootBundle.loadString('assets/json/rider_waite_data.json');
    // Parse JSON data
    Map<String, dynamic> data = jsonDecode(jsonString);
    // Extract card details based on the card ID
    List<dynamic> cards = data[language]['cards'];
    Map<String, dynamic>? cardDetails;
    for (var card in cards) {
      if (card['id'].toString() == cardId) {
        cardDetails = card;
        break;
      }
    }
    if (cardDetails != null) {
      return cardDetails;
    } else {
      throw Exception('Card details not found');
    }
  } catch (e) {
    print('Failed to load card details: $e');
    throw Exception('Failed to load card details');
  }
}


