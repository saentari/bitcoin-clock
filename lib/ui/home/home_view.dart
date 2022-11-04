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
        child: GestureDetector(
          onTap: () => model.toggleTheme(context),
          child: Scaffold(
            body: Center(
              child: FlipFraseBoard(
                flipType: FlipType.middleFlip,
                axis: Axis.vertical,
                startFrase: model.data[model.previousDataItem],
                endFrase: model.data[model.currentDataItem],
                fontSize: 100.0,
                hingeWidth: 1.6,
                flipLetterHeight: 140.0,
                maxFlipDelay: 300,
                minFlipDelay: 200,
                letterColors: [Theme.of(context).colorScheme.onSecondary],
                hingeColor: Colors.transparent,
                startColors: [Theme.of(context).colorScheme.secondary],
                endColors: [Theme.of(context).colorScheme.secondary],
                letterSpacing: 2.0,
                // onDone: () => model.refresh(delay: 60),
                startNotifier: model.startNotifier,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
