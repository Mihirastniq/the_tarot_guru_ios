import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ActiveSpread.dart';
import 'package:the_tarot_guru/MainScreens/controller/functions.dart';

class NewSpread extends StatefulWidget {
  final String tarotType;

  const NewSpread({Key? key, required this.tarotType}) : super(key: key);

  @override
  _NewSpreadState createState() => _NewSpreadState();
}

class _NewSpreadState extends State<NewSpread> {
  Map<String, Map<String, dynamic>> optionCardCounts = {};

  @override
  void initState() {
    super.initState();
    fetchOptions();
  }

  void fetchOptions() {
    setState(() {
      if (widget.tarotType == 'Osho Zen') {
        optionCardCounts = {
          "Single Card": {
            "count": 1,
            "color1": Color(0xFFF09819),
            "color2": Color(0xFFEDDE5D),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/1.png',
            "iconBoxColor": Color(0xFF84663A),
          },
          "Three Card": {
            "count": 3,
            "color1": Color(0xFFEE0979),
            "color2": Color(0xFFFF6A00),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/2.png',
            "iconBoxColor": Color(0xFF74234B),
          },
          "The Diamond": {
            "count": 5,
            "color1": Color(0xFFE52D27),
            "color2": Color(0xFFB31217),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/3.png',
            "iconBoxColor": Color(0xFF521E1F),
          },
          "The Flying Bird": {
            "count": 7,
            "color1": Color(0xFFDA22FF),
            "color2": Color(0xFF9733EE),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/4.png',
            "iconBoxColor": Color(0xFF5F3A80),
          },
          "The Key": {
            "count": 8,
            "color1": Color(0xFF348F50),
            "color2": Color(0xFF56B4D3),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/5.png',
            "iconBoxColor": Color(0xFF487A8B),
          },
          "The Paradox": {
            "count": 3,
            "color1": Color(0xFF61045F),
            "color2": Color(0xFFAA076B),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/6.png',
            "iconBoxColor": Color(0xFF40253F),
          },
          "The Mirror": {
            "count": 12,
            "color1": Color(0xFFC21500),
            "color2": Color(0xFFFFC500),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/7.png',
            "iconBoxColor": Color(0xFF796B3B),
          },
          "Celtic Cross": {
            "count": 10,
            "color1": Color(0xFF56AB2F),
            "color2": Color(0xFFA8E063),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/8.png',
            "iconBoxColor": Color(0xFF3D622C),
          },
          "Relationship": {
            "count": 4,
            "color1": Color(0xFFFF4E50),
            "color2": Color(0xFFF9D423),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/9.png',
            "iconBoxColor": Color(0xFF524C2F),
          },
          "Unification": {
            "count": 10,
            "color1": Color(0xFF834D9B),
            "color2": Color(0xFFD04ED6),
            "opacity": 0.9,
            "imagePath": 'assets/images/patterns/osho/10.png',
            "iconBoxColor": Color(0xFF3B2A42),
          },
        };
      } else if (widget.tarotType == 'Rider Waite') {
        optionCardCounts = {
          "Single Card": {
            "count": 1,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Two Card": {
            "count": 2,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Three Card": {
            "count": 3,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Four Card Spread": {
            "count": 4,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Five Card Spread": {
            "count": 5,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Money Spread": {
            "count": 5,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Six Card Spread": {
            "count": 6,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Seven Card Spread": {
            "count": 7,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "The Horseshoe Spread": {
            "count": 7,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Eight Card Spread": {
            "count": 8,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Nine Card Spread": {
            "count": 9,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Celtic Cross": {
            "count": 10,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Twelve card spread": {
            "count": 12,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "Circular Spread": {
            "count": 13,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
          "The Elcemist": {
            "count": 6,
            "color1": Color(0xFF26A69A),
            "color2": Color(0xFF4DB6AC),
            "opacity": 0.9,
            "imagePath": 'assets/images/demoimg/logo.png',
            "iconBoxColor": Color(0xFF00796B),
          },
        };
      }

    });
  }

  void navigateToActiveSpread(String spreadName, int numberOfCards, Color color1, Color color2, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActiveSpread(
          tarotType: widget.tarotType,
          spreadName: spreadName,
          numberOfCards: numberOfCards,
        ),
      ),
    );
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
                  Color.fromRGBO(19, 14, 42, 1),
                  Color.fromRGBO(19, 14, 42, 1),
                  Colors.deepPurple.shade900.withOpacity(0.9),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/other/bluebg.jpg', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 25, 0,0),
                  padding: EdgeInsets.fromLTRB(15, 25, 25, 0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("New Spread",style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800
                      ),),
                      Text('Tarot : ${widget.tarotType}',style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      ),),
                    ],
                  )
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: optionCardCounts.length,
                  itemBuilder: (context, index) {
                    String option = optionCardCounts.keys.elementAt(index);
                    int cardCount = optionCardCounts[option]!['count'];
                    Color color1 = optionCardCounts[option]!['color1'];
                    Color color2 = optionCardCounts[option]!['color2'];
                    double opacity = optionCardCounts[option]!['opacity'];
                    String imagePath = optionCardCounts[option]!['imagePath'];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 150, // Fixed height for each button
                      child: _buildButton(
                        context,
                        option,
                        cardCount,
                        color1,
                        color2,
                        opacity,
                        imagePath,
                        optionCardCounts[option]!['iconBoxColor'],
                      ),
                    );
                  },
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
              leading: IconButton(
                icon: Icon(Icons.arrow_circle_left,size: 40,),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context,true);
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.palette),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context,
      String option,
      int cardCount,
      Color color1,
      Color color2,
      double opacity,
      String imagePath,
      Color iconBoxColor,
      ) {
    return GestureDetector(
      onTap: () {
        navigateToActiveSpread(option, cardCount, color1, color2, imagePath);
      },
      child: Container(
        width: double.infinity, // Full width
        height: 150.0, // Fixed height
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141945),Colors.deepPurple.shade900],
          ),
          borderRadius: BorderRadius.circular(8.0),

          border: Border.all(
            color: Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/other/stars.png'),
              fit: BoxFit.cover,
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      height: 100.0, // Adjust the height of the image
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}