import 'package:flip_board/flip_board.dart';
import 'package:flip_board/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(context),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFECEFF4),
          body: Center(
            child: _flipFraseBoard(),
          ),
        ),
      ),
    );
  }
}

// Frase widget.
Widget _flipFraseBoard() {
  final startNotifier = ValueNotifier(0);
  return FlipFraseBoard(
    flipType: FlipType.middleFlip,
    axis: Axis.vertical,
    startFrase: '  11:49',
    endFrase: '\$ 20758',
    fontSize: 48.0,
    flipLetterHeight: 60.0,
    maxFlipDelay: 300,
    hingeWidth: 1.6,
    showBorder: false,
    letterColors: const [Color(0xFF404B59)],
    hingeColor: Colors.transparent,
    startColors: const [Color(0xFFFFFFFF)],
    endColors: const [Color(0xFFFFFFFF)],
    letterSpacing: 2.0,
    startNotifier: startNotifier,
  );
}
