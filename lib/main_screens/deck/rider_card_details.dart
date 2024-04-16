import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:the_tarot_guru/main_screens/other_screens/settings.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';
import 'package:path_provider/path_provider.dart';

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

  late String extractPath;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((directory) {
      setState(() {
        appDirectory = directory;
        extractPath = '${appDirectory.path}/tarot_assets';
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double imageAspectRatio = 2600 / 1480;

    double containerWidth = screenWidth / 2.5 - 5;
    double containerHeightWithAspectRatio = containerWidth * imageAspectRatio;

    String CardFetchedName ="";
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
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.fromLTRB(22, 60, 22, 60),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image:
                            AssetImage('assets/images/other/contentbg.png'),
                            fit: BoxFit.fitHeight,
                          )
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
                            print(cardData.keys.length);
                            CardFetchedName = cardData['card_name'];
                            return Padding(padding: const EdgeInsets.fromLTRB(20, 35, 20, 35),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),

                                ),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(15),
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 15, 25, 0),
                                              width: containerWidth,
                                              height:
                                              containerHeightWithAspectRatio,
                                              decoration: const BoxDecoration(
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/other/cardbg.png'),
                                                      fit: BoxFit.cover)
                                                // color: Colors.white
                                              ),
                                              // child: Text('image here'),
                                              child: Image.asset(
                                                'assets/images/tarot_cards/${widget.tarotType}/${widget.deckOption}/${cardData['card_image']}',
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    cardData['card_name'],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                  Text(
                                                    'Card Category : ${cardData['card_category']}',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${cardData['card_english_content']}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'Discription',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "${cardData['card_discription']}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'Reversed',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "${cardData['reversed_hindi_content']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "${cardData['card_niscurse_hindi']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),

                                          ],
                                        ),
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
                "${CardFetchedName}",
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


