import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';

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
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        
                    ),
                    child: FutureBuilder(
                      future: fetchCardDetails(tarotType, cardId),
                      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else {
                          final cardData = snapshot.data!;
                          print(cardData.keys.length);
                          CardFetchedName = cardData['card_name'];
                          return Padding(padding: EdgeInsets.fromLTRB(20, 35, 20, 35),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Display card image
                                    Image.asset(
                                      "assets/images/tarot_cards/${tarotType}/${deckOption}/${cardData['card_image']}",
                                      width: 150,
                                    ),
                                    SizedBox(height: 16.0),
                                    // Display card name
                                    Center(
                                      child: Text(
                                        cardData['card_name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    // Display card name
                                    SizedBox(height: 8.0),
                                    Text(
                                      cardData['card_english_content'],
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      'Discription',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 22,color: Colors.white,),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      cardData['card_discription'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 22.0,color: Colors.white,),
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
                IconButton(
                  icon: Icon(Icons.palette),
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
}

Future<Map<String, dynamic>> fetchCardDetails(String tarotType, String cardId) async {
  try {
    // Load JSON file from assets
    String jsonString = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
    // Parse JSON data
    Map<String, dynamic> data = jsonDecode(jsonString);
    // Extract card details based on the card ID
    List<dynamic> cards = data['en']['cards'];
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