import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/spread/ActiveSpread.dart';

Future<void> saveSpread(String name, String tarotType, String spreadName, List<SelectedCard> selectedCards) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get the list of saved spreads from SharedPreferences
  List<String>? savedSpreads = prefs.getStringList('savedSpreads');
  savedSpreads ??= [];

  // Extract card IDs from selectedCards
  List<int> cardIds = selectedCards.map((card) => card.id).toList();

  // Add the new spread to the list
  savedSpreads.add(jsonEncode({
    'name': name,
    'tarotType': tarotType,
    'spreadName': spreadName,
    'selectedCardIds': cardIds,
  }));


  // Save the updated list back to SharedPreferences
  await prefs.setStringList('savedSpreads', savedSpreads);
}

