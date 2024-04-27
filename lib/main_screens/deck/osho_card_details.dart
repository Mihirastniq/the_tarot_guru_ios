import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OshoCardDetailsScreen extends StatelessWidget {
  final String tarotType;
  final String cardId;
  final String deckOption;

  const OshoCardDetailsScreen({
    Key? key,
    required this.tarotType,
    required this.cardId,
    required this.deckOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String CardFetchedName ="";
    return Scaffold(
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
              'assets/images/Screen_Backgrounds/bg1.png',
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
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder(
                      future: fetchCardDetails(tarotType, int.parse(cardId)),
                      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          final cardData = snapshot.data!;
                          CardFetchedName = cardData['card_name'];
                          print('card data is : $cardData');
                          print('card image: ${cardData['card_image']}');
                          print('card name: ${cardData['card_name']}');
                          return Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(25.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                            width: 150,
                                            "assets/images/tarot_cards/${tarotType}/${deckOption}/${cardData['card_image']}"
                                        ),
                                        SizedBox(
                                          height: 35,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor.withOpacity(0.6),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          width: MediaQuery.sizeOf(context).width*0.9,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(Icons.star,color: Colors.white,),
                                                  Text(cardData['card_name'],style: _getTitleTextStyle(context)),
                                                  Icon(Icons.star,color: Colors.white,)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text('${AppLocalizations.of(context)!.cardcategory}: ${cardData['card_translated_category']}',style: _getCustomTextStyle(context),),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text("${cardData['card_content']}",
                                                  style: _getCustomTextStyle(context)),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                '${AppLocalizations.of(context)!.descriptioninspread}',
                                                textAlign: TextAlign.center,
                                                style: _getTitleTextStyle(context)
                                              ),
                                              SizedBox(height: 8.0),
                                              Text(
                                                cardData['card_description'],
                                                style: _getCustomTextStyle(context),
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
                            ),);
                        }
                      },
                    ),
                  )
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
                "${CardFetchedName}",
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
                      MaterialPageRoute(builder: (context) => SettingScreenClass()),
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
  TextStyle _getCustomTextStyle(BuildContext context) {
    double lineHeight = 1.8;

    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: lineHeight
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: lineHeight
      );
    } else {
      return defaultStyle;
    }
  }
  TextStyle _getTitleTextStyle(BuildContext context) {
    // Define default text style
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.white,
        fontSize: 23,
        fontWeight:
        FontWeight.w600
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.white,
          fontSize: 23,
          fontWeight:
          FontWeight.w600
      );
    } else {
      return defaultStyle;
    }
  }
}

Future<Map<String, dynamic>> fetchCardDetails(String tarotType, int cardId) async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String language = sp.getString('lang') ?? 'en';

    String jsonString = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
    // Parse JSON data
    Map<String, dynamic> data = jsonDecode(jsonString);
    // Extract card details based on the card ID
    List<dynamic> cards = data[language]['cards'];
    Map<String, dynamic>? cardDetails;
    for (var card in cards) {

      if (card['id'] == cardId) {
        // print('=======================================');
        // print('card is ${card['id']} and type is ${card['id'].runtimeType}');
        // print('=======================================');
        // print(card);
        cardDetails = card;
        // print(cardDetails);
        break;
      }
    }
    // print(cardId);

    // return cardDetails;
    if (cardDetails != null) {
      print('=============================================');
      print('returning data is ${cardDetails}');
      print('=============================================');
      return cardDetails;
    } else {
      throw Exception('Card details not found');
    }
  } catch (e) {
    print('Failed to load card details: $e');
    throw Exception('Failed to load card details');
  }


}