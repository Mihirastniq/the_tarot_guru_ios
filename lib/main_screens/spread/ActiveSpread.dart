import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_tarot_guru/main_screens/controller/audio/audio_controller.dart';
import 'package:the_tarot_guru/main_screens/controller/functions.dart';

import 'package:the_tarot_guru/main_screens/spread/osho_designs/Flying_bard.dart';
import 'osho_designs/Paradox.dart';
import 'osho_designs/Celtic_cross.dart';
import 'osho_designs/Single_card.dart';
import 'osho_designs/Diamond.dart';
import 'osho_designs/Three_card.dart';
import 'osho_designs/Key.dart';
import 'osho_designs/Mirror.dart';
import 'osho_designs/Relationship.dart';
import 'osho_designs/Unification.dart';

import 'rider_designs/SingleCard.dart';
import 'rider_designs/TwoCard.dart';
import 'rider_designs/ThreeCard.dart';
import 'rider_designs/FourCard.dart';
import 'rider_designs/FiveCard.dart';
import 'rider_designs/SixCard.dart';
import 'rider_designs/SevenCard.dart';
import 'rider_designs/EightCard.dart';
import 'rider_designs/NineCard.dart';
import 'rider_designs/TwelveCard.dart';
import 'rider_designs/CelticCross.dart';
import 'rider_designs/CircularSpread.dart';
import 'rider_designs/HarshShuSpread.dart';
import 'rider_designs/MoneySpread.dart';
import 'rider_designs/TheElcemist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActiveSpread extends StatefulWidget {
  final String spreadName;
  final int numberOfCards;
  final String tarotType;
  final String spreadEnglishName;

  ActiveSpread({
    required this.spreadName,
    required this.numberOfCards,
    required this.tarotType,
    required this.spreadEnglishName,
  });
  @override
  _ActiveSpreadState createState() => _ActiveSpreadState();
}

class _ActiveSpreadState extends State<ActiveSpread> {
  bool _isAnimating = false;
  late List<CardInfo> cards = [];
  late final List<bool> fixedPositions;

  int countdown = 5;
  bool showText = true;
  late final AudioController _audioController;
  bool countdownStarted = false;
  bool shufflingFinished = false;
  Set<int> selectedCards = {};
  bool isButtonVisible = false;
  bool _textvisible = true;
  bool _cardvisible = false;
  int animationCount = 0;
  int totalselectedcards = 0;

  @override
  void initState() {
    super.initState();
    fetchCards();
    _audioController = AudioController();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _audioController.initSharedPreferences();
    await _audioController.playSelectedAudio();
  }

  @override
  void dispose() {
    _audioController.stopAudio();
    super.dispose();
  }

  Future<void> _changePosition() async {
    setState(() {
      _textvisible = !_textvisible;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _cardvisible = !_cardvisible;
      _isAnimating = !_isAnimating;
    });

    if (_isAnimating) {
      for (int i = 0; i < 3; i++) {
        if (_isAnimating) {
          _updateCardPositions();
          await Future.delayed(Duration(milliseconds: 2100));
        }
      }
      setState(() {
        _isAnimating = false;
      });
    }
  }

  void stopAnimation() {
    setState(() {
      _isAnimating = false;
    });
  }

  void _updateCardPositions() {
    setState(() {
      for (int i = 0; i < cards.length; i++) {
        if (!fixedPositions[i]) {
          double newLeft = Random().nextDouble() *
              (MediaQuery.of(context).size.width * 0.9 - 90);
          double newTop = Random().nextDouble() *
              (MediaQuery.of(context).size.height * 0.7 - 120);
          cards[i].position = '$newLeft,$newTop'; // Store the new position
        }
      }
    });
  }

  void _animateCardRemoval(int cardId) {
    int index = cards.indexWhere((card) => card.id == cardId);
    if (index != -1) {
      setState(() {
        cards[index].position =
            '${MediaQuery.of(context).size.width}, ${MediaQuery.of(context).size.height}';
      });
    }
  }

  List<Widget> _buildCards() {
    return cards.map((card) {
      List<String> positionValues = card.position.split(',');
      double left = double.parse(positionValues[0]);
      double top = double.parse(positionValues[1]);

      return CardWidget(
        cardInfo: card,
        tarotType: widget.tarotType,
        onCardTap: _onCardTap,
        selectedCards: selectedCards,
        left: left,
        top: top,
        isAnimating: _isAnimating,
        onStopAnimation: stopAnimation,
        onUpdatePosition: (newLeft, newTop) {
          setState(() {
            card.position = '$newLeft,$newTop';
          });
        },
      );
    }).toList();
  }

  void _onCardTap(CardInfo card) {
    if (_isAnimating == false) {
      if (!selectedCards.contains(card.id)) {
        if (selectedCards.length < widget.numberOfCards) {
          _animateCardRemoval(card.id);
          selectedCards.add(card.id);
          setState(() {
            totalselectedcards = totalselectedcards + 1;
          });
          if (selectedCards.length == widget.numberOfCards) {
            List<SelectedCard> selectedCardsList = selectedCards.map((id) {
              CardInfo card = cards.firstWhere((card) => card.id == id);
              return SelectedCard(id: card.id, name: card.name);
            }).toList();
            NavigateToRevealCard(
                selectedCards: selectedCardsList,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName);
          }
        } else {
          List<SelectedCard> selectedCardsList = selectedCards.map((id) {
            CardInfo card = cards.firstWhere((card) => card.id == id);
            return SelectedCard(id: card.id, name: card.name);
          }).toList();
          NavigateToRevealCard(
              selectedCards: selectedCardsList,
              tarotType: widget.tarotType,
              spreadName: widget.spreadName);
        }
      }
    } else {
      setState(() {
        _isAnimating = false;
      });
    }
  }

  void _autoDeal() {
    int totalCards = widget.numberOfCards;
    Set<int> selectedNumbers = {};

    while (selectedNumbers.length < totalCards) {
      int randomNumber =
          Random().nextInt(79) + 1; // Generate a random number from 1 to 79
      selectedNumbers.add(randomNumber); // Add the number to the set
    }

    selectedCards.clear();

    selectedNumbers.forEach((number) {
      selectedCards.add(number);
    });

    List<SelectedCard> selectedCardsList = selectedCards.map((id) {
      CardInfo card = cards.firstWhere((card) => card.id == id);
      return SelectedCard(id: card.id, name: card.name);
    }).toList();

    NavigateToRevealCard(
      selectedCards: selectedCardsList,
      tarotType: widget.tarotType,
      spreadName: widget.spreadName,
    );
  }

  void NavigateToRevealCard(
      {required List<SelectedCard> selectedCards,
      required String tarotType,
      required String spreadName}) {
    if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.singlecard}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingleCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.threecard}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheThreeCardSpread(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.thediamond}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheDiamondScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.theflyingbird}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheFlyingBirdScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.thekey}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheKeyScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.theparadox}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheParadoxScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.themirror}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheMirrorScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.celticcross}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheCelticCrossScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.relationship}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheRelationSpread(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Osho Zen" &&
        widget.spreadName == "${AppLocalizations.of(context)!.unification}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TheUnificationScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "${AppLocalizations.of(context)!.singlecard}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderSingleCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "${AppLocalizations.of(context)!.twocard}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderTwoCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "${AppLocalizations.of(context)!.threecard}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderThreeCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName ==
            "${AppLocalizations.of(context)!.fourcardspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderFourCardScreen(
                  selectedCards: selectedCards,
                  tarotType: widget.tarotType,
                  spreadName: widget.spreadName,
                )),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName ==
            "${AppLocalizations.of(context)!.fivecardspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderFiveCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "${AppLocalizations.of(context)!.moneyspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderMoneySpreadScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "${AppLocalizations.of(context)!.sixcardspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderSixCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName ==
            "${AppLocalizations.of(context)!.sevencardspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderSevenCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName ==
            "${AppLocalizations.of(context)!.thehorseshoespread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderHarshuShuCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName ==
            "${AppLocalizations.of(context)!.eightcardspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderEightCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName ==
            "${AppLocalizations.of(context)!.ninecardspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderNineCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "${AppLocalizations.of(context)!.celticcross}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderCelticCrossCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName ==
            "${AppLocalizations.of(context)!.twelvecardspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderTwelveCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName ==
            "${AppLocalizations.of(context)!.circularspread}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderCircularCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    } else if (widget.tarotType == "Rider Waite" &&
        widget.spreadName == "${AppLocalizations.of(context)!.theelcemist}") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RiderElcemistCardScreen(
                selectedCards: selectedCards,
                tarotType: widget.tarotType,
                spreadName: widget.spreadName)),
      );
    }
  }

  Future<void> fetchCards() async {
    try {
      int numberOfCards = 79; // Assuming 78 cards for example
      setState(() {
        cards = List<CardInfo>.generate(
          numberOfCards,
          (index) => CardInfo(
            id: index + 1,
            position: '0,0',
            name: '',
          ),
        );
        fixedPositions = List<bool>.filled(numberOfCards, false);
      });
    } catch (e) {
      print('Error fetching cards: $e');
    }
  }

  String getOptionText(
      BuildContext context, String tarotType, String spreadName) {
    if (tarotType == 'Osho Zen') {
      switch (widget.spreadEnglishName) {
        case 'Osho Single Card':
          return AppLocalizations.of(context)!.oshoSingleCardText;
        case 'Osho Three Card':
          return AppLocalizations.of(context)!.oshoThreeCardText;
        case 'Osho The Diamond':
          return AppLocalizations.of(context)!.oshoTheDiamondText;
        case 'Osho The Flying Bird':
          return AppLocalizations.of(context)!.oshoTheFlyingBirdText;
        case 'Osho The Key':
          return AppLocalizations.of(context)!.oshoTheKeyText;
        case 'Osho The Paradox':
          return AppLocalizations.of(context)!.oshoTheParadoxText;
        case 'Osho The Mirror':
          return AppLocalizations.of(context)!.oshoTheMirrorText;
        case 'Osho Celtic Cross':
          return AppLocalizations.of(context)!.oshoCelticCrossText;
        case 'Osho Relationship':
          return AppLocalizations.of(context)!.oshoRelationshipText;
        case 'Osho Unification':
          return AppLocalizations.of(context)!.oshoUnificationText;
        default:
          return '';
      }
    } else if (tarotType == 'Rider Waite') {
      switch (widget.spreadEnglishName) {
        case 'Single Card':
          return AppLocalizations.of(context)!.riderSingleCardText;
        case 'Two Card':
          return AppLocalizations.of(context)!.riderTwoCardText;
        case 'Three Card':
          return AppLocalizations.of(context)!.riderThreeCardText;
        case 'Four Card Spread':
          return AppLocalizations.of(context)!.riderFourCardSpreadText;
        case 'Five Card Spread':
          return AppLocalizations.of(context)!.riderFiveCardSpreadText;
        case 'Money Spread':
          return AppLocalizations.of(context)!.riderMoneySpreadText;
        case 'Six Card Spread':
          return AppLocalizations.of(context)!.riderSixCardSpreadText;
        case 'Seven Card Spread':
          return AppLocalizations.of(context)!.riderSevenCardSpreadText;
        case 'The Horseshoe Spread':
          return AppLocalizations.of(context)!.riderTheHorseshoeSpreadText;
        case 'Eight Card Spread':
          return AppLocalizations.of(context)!.riderEightCardSpreadText;
        case 'Nine Card Spread':
          return AppLocalizations.of(context)!.riderNineCardSpreadText;
        case 'Celtic Cross':
          return AppLocalizations.of(context)!.riderCelticCrossSpreadText;
        case 'Twelve card':
          return AppLocalizations.of(context)!.riderTwelveCardSpreadText;
        case 'Circular Spread':
          return AppLocalizations.of(context)!.riderCircularSpreadText;
        case 'The Elcemist':
          return AppLocalizations.of(context)!.riderTheElcemistText;
        default:
          return '';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
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
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg3.png', // Replace with your image path
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
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_circle_left,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              title: Text(
                '${widget.spreadName}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.music_note),
                  color: Colors.white,
                  onPressed: () {
                    _audioController.toggleAudio();
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
          Column(
            children: [
              SizedBox(
                height: AppBar().preferredSize.height,
              ),
            ],
          ),
          Center(
            child: Visibility(
              visible: _textvisible,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${getOptionText(context, widget.tarotType, widget.spreadName)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: _changePosition,
                        child: Text(_isAnimating ? '' : 'Start Spread'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: !_textvisible,
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.1,
                    AppBar().preferredSize.height +
                        (AppBar().preferredSize.height +
                            (AppBar().preferredSize.height / 2)),
                    0,
                    0),
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Stack(
                  children: _buildCards(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: AppBar().preferredSize.height - 20,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Selected $totalselectedcards / ${widget.numberOfCards}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Visibility(
                    visible:
                        !_isAnimating, // Show the button only when not animating
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _autoDeal();
                          },
                          child: Text('Auto Deal'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedCard {
  final int id;
  final String name;
  SelectedCard({required this.id, required this.name});
}

class CardInfo {
  final int id;
  String position;
  final String name;

  CardInfo({
    required this.id,
    required this.name,
    required this.position,
  });
}

class CardWidget extends StatefulWidget {
  final CardInfo cardInfo;
  final String tarotType;
  final Function(CardInfo) onCardTap;
  final Set<int> selectedCards;
  final double left;
  final double top;
  final bool isAnimating;
  final Function(double, double) onUpdatePosition;
  final Function() onStopAnimation;

  const CardWidget({
    required this.cardInfo,
    required this.tarotType,
    required this.onCardTap,
    required this.selectedCards,
    required this.left,
    required this.top,
    required this.isAnimating,
    required this.onUpdatePosition,
    required this.onStopAnimation,
  });

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  bool isVisible = true;
  bool isDragging = false;
  bool isDragged = false;
  Offset position = Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(widget.left, widget.top),
      end: Offset(widget.left, widget.top),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }


  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    double oshoimageAspectRatio = 671 / 457;
    double riderimageAspectRatio = 2600 / 1480;
    double imagewidth = 0;
    double imageheight = 0;
    Color bordercolor = Colors.white;

    late double newtop = widget.top;
    late double newleft = widget.left;

    if (widget.tarotType == 'Osho Zen') {
      imageUrl = 'assets/images/cards/osho.jpg';
      imagewidth = 45;
      imageheight = imagewidth * oshoimageAspectRatio;
      bordercolor = Colors.white;
    } else if (widget.tarotType == 'Rider Waite') {
      imageUrl = 'assets/images/cards/rider.jpg';
      imagewidth = 50;
      imageheight = imagewidth * riderimageAspectRatio;
      bordercolor = Colors.black;
    }

    return Visibility(
      visible: isVisible,
      child: AnimatedPositioned(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        top: newtop,
        left: newleft,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanStart: (details) {
            if (widget.isAnimating == false) {
              setState(() {
                isDragging = true;
              });
            }
          },
          onPanUpdate: (details) {
            if (isDragging) {
              setState(() {
                newleft += details.delta.dx;
                newtop += details.delta.dy;
                widget.onUpdatePosition(newleft, newtop);
              });
            }
          },
          onPanEnd: (details) {
            setState(() {
              isDragged = true;
              isDragging = false;
            });
          },
          child: SlideTransition(
            position: _offsetAnimation,
            child: Transform.translate(
                offset: Offset(position.dx, position.dy),
                child: GestureDetector(
                  onTap: () {
                    widget.onCardTap(widget.cardInfo);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.red,
                      border: Border.all(
                        width: 1,
                        color: bordercolor,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7.0),
                      child: Image.asset(
                        imageUrl,
                        width: imagewidth,
                        height: imageheight,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
