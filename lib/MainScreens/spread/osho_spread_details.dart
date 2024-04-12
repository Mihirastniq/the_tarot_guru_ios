import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../OtherScreens/settings.dart';
import '../controller/functions.dart';
import 'ActiveSpread.dart';

class TheSpreadDetailsScreen extends StatefulWidget {
  final List<SelectedCard> selectedCards;
  final String tarotType;
  final String spreadName;

  TheSpreadDetailsScreen({
    required this.selectedCards,
    required this.tarotType,
    required this.spreadName,
  });
@override
_TheSpreadDetailsScreenState createState() => _TheSpreadDetailsScreenState();

}

class _TheSpreadDetailsScreenState extends State<TheSpreadDetailsScreen> {
  List<dynamic> cardData = [];

  // Future<List<dynamic>> fetchData() async {
  //   List<dynamic> allCardData = [];
  //
  //   try {
  //     String url = 'https://thetarotguru.com/tarotapi/spreadcard.php';
  //     String function = "Reveal";
  //     List<int> cardIds = widget.selectedCards.map((card) => card.id).toList();
  //     var requestData = {
  //       'function': 'SpreadDetails',
  //       'card_ids': cardIds,
  //       'tarotType': widget.tarotType,
  //     };
  //     print('Request Data: $requestData');
  //
  //     var response = await http.post(
  //       Uri.parse(url),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(requestData),
  //     );
  //     if (response.statusCode == 200) {
  //       print('Response: ${response.body}');
  //       print('Body:${response.body}');
  //       var jsonResponseList = response.body.split('}{');
  //       for (var jsonResponse in jsonResponseList) {
  //         if (!jsonResponse.startsWith('{')) {
  //           jsonResponse = '{$jsonResponse';
  //         }
  //         if (!jsonResponse.endsWith('}')) {
  //           jsonResponse = '$jsonResponse}';
  //         }
  //         var data = jsonDecode(jsonResponse);
  //         print('This is Card data screen: $data');
  //
  //         if (data.containsKey('card_data')) {
  //           allCardData.addAll(data['card_data']);
  //         } else {
  //           print('No card data found in response');
  //         }
  //       }
  //     } else {
  //       print('Failed to fetch card data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching card data: $e');
  //   }
  //
  //   return allCardData;
  // }
  Future<List<dynamic>> fetchData() async {
    List<dynamic> allCardData = [];

    try {
      String data = await rootBundle.loadString('assets/json/oshoo_zen_data.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      List<int> cardIds = widget.selectedCards.map((card) => card.id).toList();
      for (int id in cardIds) {
        Map<String, dynamic>? card = jsonData['en']['cards'].firstWhere(
              (card) => card['id'] == id.toString(),
          orElse: () => null,
        );

        if (card != null) {
          allCardData.add({
            'card_image': card['card_image'],
            'card_category': card['card_category'],
            'card_name': card['card_name'],
            'card_english_content':card['card_english_content'],
            'card_discription':card['card_discription'],
            'card_index':card['card_index'],
          });
        }
      }
    } catch (e) {
      print('Error fetching card data: $e');
    }

    return allCardData;
  }

  void init() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width * 0.9;
    double screenHeight = MediaQuery.of(context).size.height * 0.7;
    double containerHeight = screenHeight / 7;
    double imageAspectRatio = 2600 / 1480;

    double containerWidth = screenWidth / 2.5 - 5;
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
                  Color(0xFF272727),
                  Color(0xFF272727),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/product.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.1),
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
                "Spread Details",
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
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  // color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage('assets/images/other/osho_content_bg.png'),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(15)
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
                            padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        margin: EdgeInsets.fromLTRB(
                                            15, 15, 25, 0),
                                        width: containerWidth,
                                        height:
                                        containerHeightWithAspectRatio,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/other/cardbg.png'),
                                                fit: BoxFit.cover)
                                          // color: Colors.white
                                        ),
                                        // child: Text('image here'),
                                        child: Image.network(
                                          'https://thetarotguru.com/tarotapi/cards/${widget.tarotType}/${currentCard['card_category']}/${currentCard['card_image']}',
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
                                              currentCard['card_name'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 23,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                            Text(
                                              'Card Category : ${currentCard['card_category']}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
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
                                        "${currentCard['card_english_content']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Discription',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "${currentCard['card_discription']}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 15,
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
          )
        ],
      ),
    );
  }
}