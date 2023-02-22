import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:intl/intl.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../services/exchange_manager.dart';
import '../theme_setup.dart';

class HomeViewModel extends ChangeNotifier {
  final startNotifier = ValueNotifier(0);

  var nextFlipValue = 0;
  var fontSize = 50.0;
  var flipCardWidth = 0.0;
  var flipCardHeight = 0.0;
  var timerInterval = 30;

  var isFullScreen = false;
  var showTime = true;
  var showBitcoinPrice = true;

  // Data items must always have 7 characters.
  late List<String> data;
  late List<String> metadataTop;
  late List<String> metadataBottom;
  late int previousDataItem;
  late int currentDataItem;
  late Timer timer;
  late String randomBackground;

  Future<void> initialise(BuildContext context) async {
    // Launch text.
    data = ['      '];
    metadataTop = ['TIME', 'BTC'];
    metadataBottom = [' '];

    currentDataItem = 0;
    previousDataItem = data.length - 1;

    // Set random background.
    int randomNumber = randomImageNumber();
    randomBackground = 'https://raw.githubusercontent.com/saentari/bitcoin-clock/main/assets/images/$randomNumber.jpeg';

    // Set the screen width.
    flipCardWidth = MediaQuery.of(context).size.width / 8;
    flipCardHeight = MediaQuery.of(context).size.height / 8;

    // Retrieve time & price.
    data = await composeData();

    // Get the timeZone from device.
    metadataBottom = await composeMetadataBottom();

    // New [data] changes the [previousDataItem] index.
    previousDataItem = data.length - 1;
    notifyListeners();

    // Activate a timer for switching between data.
    timer = Timer.periodic(Duration(seconds: timerInterval), (Timer timer) => showNext());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void toggleOrientation(BuildContext context, Orientation orientation) {
    // Adjust font size when orientation changes.
    if (orientation == Orientation.portrait) {
      fontSize = MediaQuery.of(context).size.height / 12;
      flipCardWidth = MediaQuery.of(context).size.width / 8;
      flipCardHeight = MediaQuery.of(context).size.height / 8;
    }
    if (orientation == Orientation.landscape) {
      fontSize = MediaQuery.of(context).size.height / 3;
      flipCardWidth = MediaQuery.of(context).size.width / 9;
      flipCardHeight = MediaQuery.of(context).size.height / 2;
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
    // Stop old timer.
    timer.cancel();

    // Rebuild the [data] list with up-to-date data
    data = await composeData();

    // Rebuild the [metadata] list
    metadataBottom = await composeMetadataBottom();

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
    notifyListeners();

    // Reset new timer.
    timer = Timer.periodic(Duration(seconds: timerInterval), (Timer timer) => showNext());
  }

  Future<void> refreshData() async {
    // Rebuild the [data] list with up-to-date data
    data = await composeData();

    // Rebuild the [metadata] list
    metadataBottom = await composeMetadataBottom();

    // Update [ValueNotifier].
    startNotifier.notifyListeners();

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

  Future<List<String>> composeMetadataBottom() async {
    // Add time (4 characters).
    final timeZoneName = DateTime.now().timeZoneName;
    final timeZone = timeZoneName;

    // Default fiat currency (USD).
    const currency = 'USD';

    // Return updated [data].
    return [timeZone, currency];
  }

  String timeToString() {
    return ' ${DateFormat.Hm('en_US').format(DateTime.now())}';
  }

  Future<String> priceToString() async {
    final exchange = ExchangeManager();
    final price = await exchange.price('USD');
    final roundedPrice = price.ceil().toString();
    return roundedPrice.padLeft(6, ' ');
  }

  int randomImageNumber() {
    return Random().nextInt(12) + 1;
  }

  randomBackgroundImage() {
    int randomNumber = randomImageNumber();
    randomBackground = 'https://raw.githubusercontent.com/saentari/bitcoin-clock/main/assets/images/$randomNumber.jpeg';
    notifyListeners();
  }

  void enterFullScreen() {
    print('is: $isFullScreen');

    FullScreen.enterFullScreen(FullScreenMode.LEANBACK);
    isFullScreen = true;
    print('entering');

    print('is now: $isFullScreen');
    notifyListeners();
  }

  void exitFullScreen() {
    print('is: $isFullScreen');

    FullScreen.exitFullScreen();
    isFullScreen = false;
    print('entering');

    print('is now: $isFullScreen');
    notifyListeners();
  }
}
