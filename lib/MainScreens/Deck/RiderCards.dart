// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:the_tarot_guru/MainScreens/Deck/ridercarddetails.dart';
// import 'dart:convert';
// import 'package:the_tarot_guru/MainScreens/OtherScreens/settings.dart';
// import 'package:the_tarot_guru/MainScreens/controller/functions.dart';
//
// class RiderCardsScreen extends StatefulWidget {
//   final String tarotType;
//   final String deckOption;
//
//   const RiderCardsScreen({super.key, required this.tarotType,
//     required this.deckOption,});
//
//   @override
//   State<RiderCardsScreen> createState() => _RiderDeckScreenState();
// }
//
// class _RiderDeckScreenState extends State<RiderCardsScreen> {
//   late String extractPath;
//   late Directory appDirectory;
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFF171625),
//                   Color(0xFF171625),
//                   // Color.fromRGBO(19, 14, 42, 1),
//                   // Colors.deepPurple.shade900.withOpacity(0.9),
//                 ],
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/Screen_Backgrounds/bg2.png', // Replace with your image path
//               fit: BoxFit.cover,
//               opacity: const AlwaysStoppedAnimation(.1),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(
//                 height: AppBar().preferredSize.height,
//               ),
//               Expanded(
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(15),
//                     child: Container(
//                       child: _buildCardGrid(context),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               title: Text(
//                 '${widget.deckOption}',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   icon: Icon(Icons.settings),
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Setting()),
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.palette),
//                   color: Colors.white,
//                   onPressed: () {
//                     changeTheme(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCardGrid(BuildContext context) {
//     return FutureBuilder(
//       future: fetchCardData(widget.tarotType, widget.deckOption),
//       builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10.0,
//               mainAxisSpacing: 10.0,
//             ),
//             itemCount: snapshot.data!.length,
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => RiderCardDetailsScreen(cardId: snapshot.data![index]['id'], tarotType: widget.tarotType,deckOption : widget.deckOption)),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/other/button.png'),
//                         fit: BoxFit.cover,
//                         opacity: 0.5,
//                       ),
//                       border: Border.all(
//                         width: 2,
//                         color: Colors.grey.withOpacity(0.5),
//                       ),
//                       borderRadius: BorderRadius.circular(15)
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/images/tarot_cards/${widget.tarotType}/${widget.deckOption}/${snapshot.data![index]['image']}',
//                         width: 80.0,
//                         height: 80.0,
//                       ),
//                       SizedBox(height: 10.0),
//                       Text(
//                         snapshot.data![index]['name'],
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> fetchCardData(String tarotType, String deckOption) async {
//     String uri = "https://thetarotguru.com/tarotapi/fetchcards.php";
//     var requestBody = {
//       'tarot_type': tarotType,
//       'deck_option': deckOption,
//     };
//     var res = await http.post(Uri.parse(uri), body: requestBody);
//     if (res.statusCode == 200) {
//       List<dynamic> responseData = json.decode(res.body);
//       List<Map<String, dynamic>> cardData = responseData.map((item) => {
//         'id': item['id'].toString(),
//         'name': item['name'].toString(),
//         'hindiname': item['card_hindi_name'].toString(),
//         'image': item['card_image'].toString(),
//       }).toList();
//       return cardData;
//     } else {
//       print("The data is :${res.body}");
//       throw Exception('Failed to load card data');
//     }
//   }
//
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading JSON file
import 'package:the_tarot_guru/MainScreens/Deck/ridercarddetails.dart';
import 'package:the_tarot_guru/MainScreens/OtherScreens/settings.dart';
import 'package:the_tarot_guru/MainScreens/controller/functions.dart';

class RiderCardsScreen extends StatefulWidget {
  final String tarotType;
  final String deckOption;

  const RiderCardsScreen({
    Key? key,
    required this.tarotType,
    required this.deckOption,
  });

  @override
  State<RiderCardsScreen> createState() => _RiderDeckScreenState();
}

class _RiderDeckScreenState extends State<RiderCardsScreen> {
  List<CardData> _cardData = [];

  @override
  void initState() {
    super.initState();
    _loadCardData();
  }

  Future<void> _loadCardData() async {
    try {
      // Load JSON file from assets
      String jsonString = await rootBundle.loadString('assets/json/rider_waite_data.json');
      // Parse JSON data
      Map<String, dynamic> data = jsonDecode(jsonString);
      // Extract card data based on language code and deck option
      List<dynamic> cards = data['en']['cards'];
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
                  Color(0xFF171625),
                  Color(0xFF171625),
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
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
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

  Widget _buildCardGrid() {
    if (_cardData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: _cardData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RiderCardDetailsScreen(
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
                    width: 80.0,
                    height: 80.0,
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
