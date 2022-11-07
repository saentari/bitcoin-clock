import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../services/exchange_manager.dart';
import '../theme_setup.dart';

class HomeViewModel extends ChangeNotifier {
  final startNotifier = ValueNotifier(0);
  final flipController = StreamController.broadcast();
  final flipController2 = StreamController.broadcast();
  int nextFlipValue = 0;

  var fontSize = 50.0;

  // Data items must always have 7 characters.
  late List<String> data;
  late List<String> metadata;
  late int previousDataItem;
  late int currentDataItem;
  late Timer timer;

  Future<void> initialise(BuildContext context) async {
    // Launch text.
    data = ['012345'];
    metadata = ['ABC\nDEF'];

    currentDataItem = 0;
    previousDataItem = data.length - 1;

    // Retrieve time & price.
    data = await composeData();

    // New [data] changes the [previousDataItem] index.
    previousDataItem = data.length - 1;
    notifyListeners();

    // Activate a timer for switching between data.
    timer = Timer.periodic(
        const Duration(seconds: 30), (Timer timer) => showNext());
  }

  @override
  void dispose() {
    flipController.close();
    timer.cancel();
    super.dispose();
  }

  void toggleOrientation(Orientation orientation) {
    // Adjust font size when orientation changes.
    if (orientation == Orientation.portrait) {
      fontSize = 50.0;
    }
    if (orientation == Orientation.landscape) {
      fontSize = 90.0;
    }
  }

  void toggleTheme(BuildContext context) {
    // If there is no next theme, use the first one.
    var newThemeIndex = 0;

    // Retrieve the index of the current theme.
    var themeIndex = getThemeManager(context).selectedThemeIndex;

    // Count the total number of themes.
    var numberOfThemes = getThemes().length;

    // Increment to the next theme or start anew.
    if (themeIndex! < numberOfThemes - 1) {
      newThemeIndex = themeIndex + 1;
    }

    // Set the new theme.
    getThemeManager(context).selectThemeAtIndex(newThemeIndex);

    // Trigger an instant refresh when changing the theme.
    refreshData();
  }

  Future<void> showNext() async {
    // Rebuild the [data] list with up-to-date data
    data = await composeData();

    // Rebuild the [metadata] list
    metadata = await composeMetadata();

    // Start with first data item in the list.
    currentDataItem = 0;
    previousDataItem = data.length - 1;

    // Increment to the next item or start anew.
    if (startNotifier.value < data.length - 1) {
      previousDataItem = startNotifier.value;
      currentDataItem = startNotifier.value + 1;
    }

    // Update [ValueNotifier].
    startNotifier.value = currentDataItem;

    // Flip metadata widget at the front.
    _flip(metadata[currentDataItem]);
    notifyListeners();
  }

  Future<void> refreshData() async {
    // Rebuild the [data] list with up-to-date data
    data = await composeData();

    // Rebuild the [metadata] list
    metadata = await composeMetadata();

    // Update [ValueNotifier].
    startNotifier.notifyListeners();

    // Flip metadata widget at the front.
    _flip(metadata[currentDataItem]);
    notifyListeners();
  }

  Future<List<String>> composeData() async {
    // Add time (6 characters).
    final time = timeToString();

    // Bitcoin price (USD).
    final price = await priceToString();

    // Return updated [data].
    return [time, price];
  }

  Future<List<String>> composeMetadata() async {
    // Add time (7 characters).
    final timezone = 'TIME\nGMT ';

    // Bitcoin price (USD).
    final currency = 'BTC \nUSD ';

    // Return updated [data].
    return [timezone, currency];
  }

  String timeToString() {
    return ' ${DateFormat.Hm('en_US').format(DateTime.now())}';
  }

  Future<String> priceToString() async {
    // TODO: catch network error.
    final exchange = ExchangeManager();
    final price = await exchange.price('USD');
    final roundedPrice = price.ceil().toString();
    return roundedPrice.padLeft(6, ' ');
  }

  void _flip(String character) => flipController.add(character);
}
