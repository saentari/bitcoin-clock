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
            body: OrientationBuilder(builder: (context, orientation) {
              model.toggleOrientation(orientation);
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => model.showNext(),
                        child: _flipWidget(AxisDirection.down, model)),
                    GestureDetector(
                      onTap: () => model.refreshData(),
                      child: FlipFraseBoard(
                        flipType: FlipType.middleFlip,
                        axis: Axis.vertical,
                        startFrase: model.data[model.previousDataItem],
                        endFrase: model.data[model.currentDataItem],
                        fontSize: model.fontSize,
                        hingeWidth: 1.6,
                        maxFlipDelay: 300,
                        minFlipDelay: 200,
                        letterColors: [
                          Theme.of(context).colorScheme.onSecondary
                        ],
                        hingeColor: Colors.transparent,
                        startColors: [Theme.of(context).colorScheme.secondary],
                        endColors: [Theme.of(context).colorScheme.secondary],
                        // onDone: () => model.refresh(delay: 60),
                        startNotifier: model.startNotifier,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _flipWidget(AxisDirection direction, HomeViewModel model) {
    return FlipWidget(
      flipType: FlipType.middleFlip,
      itemStream: model.flipController.stream,
      itemBuilder: _itemBuilder,
      initialValue: model.metadata[model.currentDataItem],
      flipDirection: direction,
      flipCurve: FlipWidget.bounceFastFlip,
      flipDuration: const Duration(seconds: 1),
      perspectiveEffect: 0.008,
      hingeWidth: 2.0,
      hingeLength: 2.0,
      // hingeColor: Colors.transparent,
    );
  }

  Widget _itemBuilder(BuildContext context, dynamic value) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      height: 55.0,
      width: 50.0,
      child: Text(
        (value ?? 0).toString(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 24.0,
        ),
      ),
    );
  }
}
