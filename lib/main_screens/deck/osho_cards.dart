import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading JSON file
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/Deck/osho_card_details.dart';
import 'package:the_tarot_guru/main_screens/Deck/rider_card_details.dart';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';

class OshoCardSelectionScreen extends StatefulWidget {
  final String tarotType;
  final String deckOption;

  const OshoCardSelectionScreen({
    Key? key,
    required this.tarotType,
    required this.deckOption,
  });

  @override
  _OshoCardSelectionScreenState createState() => _OshoCardSelectionScreenState();
}

class _OshoCardSelectionScreenState extends State<OshoCardSelectionScreen> {
  List<CardData> _cardData = [];

  @override
  void initState() {
    super.initState();
    _loadCardData();
  }

  Future<void> _loadCardData() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      final String language = sp.getString('lang') ?? 'en';

      String jsonString = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
      // Parse JSON data
      Map<String, dynamic> data = jsonDecode(jsonString);
      // Extract card data based on language code and deck option
      List<dynamic> cards = data[language]['cards'];
      _cardData = cards
          .where((card) =>
      card['card_category'] == widget.deckOption)
          .map((card) => CardData.fromJson(card))
          .toList();
      setState(() {});
    } catch (e) {
      print('Error loading card data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
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
                  // Color(0xFF171625),
                  // Color(0xFF171625),
                  Color.fromRGBO(19, 14, 42, 1),
                  Colors.deepPurple.shade900.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg2.png',
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: _buildCardGrid(),
                  ),
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
                '${widget.deckOption}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
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

  Widget _buildCardGrid() {
    if (_cardData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemCount: _cardData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OshoCardDetailsScreen(
                    cardId: _cardData[index].id,
                    tarotType: widget.tarotType,
                    deckOption: widget.deckOption,
                  ),
                ),
              );
            },
            child: Container(

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
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/tarot_cards/${widget.tarotType}/${widget.deckOption}/${_cardData[index].cardImage}',
                    width: 50.0,
                    height: 50.0,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    _cardData[index].cardName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}

class CardData {
  final String id;
  final String cardName;
  final String cardImage;
  final String cardCategory;
  final String cardEnglishContent;

  CardData({
    required this.id,
    required this.cardName,
    required this.cardImage,
    required this.cardCategory,
    required this.cardEnglishContent,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      id: json['id'],
      cardName: json['card_name'],
      cardImage: json['card_image'],
      cardCategory: json['card_category'],
      cardEnglishContent: json['card_english_content'],
    );
  }
}
