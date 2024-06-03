import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class OshoCardDetailsScreen extends StatefulWidget {
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
  State<OshoCardDetailsScreen> createState() => _OshoCardDetailsScreenState();
}

class _OshoCardDetailsScreenState extends State<OshoCardDetailsScreen> {
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
                      future: fetchCardDetails(widget.tarotType, int.parse(widget.cardId)),
                      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          final cardData = snapshot.data!;
                          CardFetchedName = cardData['card_name'];
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
                                            "assets/images/tarot_cards/${widget.tarotType}/${widget.deckOption}/${cardData['card_image']}"
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
        fontSize: ContentFontsSize,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: lineHeight
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: ContentFontsSize,
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
        fontSize: TitleFontsSize,
        fontWeight:
        FontWeight.w600
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.white,
          fontSize: TitleFontsSize,
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