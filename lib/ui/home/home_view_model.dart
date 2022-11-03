import 'package:flutter/cupertino.dart';

class HomeViewModel extends ChangeNotifier {
  // final _flipController = StreamController<int>.broadcast();
  // final _spinController = StreamController<int>.broadcast();
  // int _nextFlipValue = 0;
  // int _nextSpinValue = 0;

  void initialise(BuildContext context) {
    notifyListeners();
  }
}
