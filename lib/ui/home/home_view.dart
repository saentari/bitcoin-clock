import 'package:bitcoin_clock/widgets/flip_card_content_widget.dart';
import 'package:bitcoin_clock/widgets/flip_card_mask_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:widget_mask/widget_mask.dart';

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
          onTap: () => model.exitFullScreen(),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: model.isFullScreen == true ? 0 : AppBar().preferredSize.height,
              backgroundColor: Colors.black,
              actions: [
                Row(
                  children: [
                    IconButton(onPressed: () => model.randomBackgroundImage(), icon: const Icon(Icons.image)),
                    IconButton(onPressed: () => model.enterFullScreen(), icon: const Icon(Icons.fullscreen)),
                  ],
                ),
              ],
            ),
            body: OrientationBuilder(builder: (context, orientation) {
              model.toggleOrientation(context, orientation);
              return Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: WidgetMask(
                            childSaveLayer: true,
                            blendMode: BlendMode.srcATop,
                            mask: Image.network(
                              model.randomBackground,
                              fit: BoxFit.cover,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  width: model.flipCardWidth,
                                  height: model.flipCardHeight,
                                ),
                                FlipCardMaskWidget(model.flipCardWidth, model.flipCardHeight),
                                FlipCardMaskWidget(model.flipCardWidth, model.flipCardHeight),
                                FlipCardMaskWidget(model.flipCardWidth, model.flipCardHeight),
                                FlipCardMaskWidget(model.flipCardWidth, model.flipCardHeight),
                                FlipCardMaskWidget(model.flipCardWidth, model.flipCardHeight),
                                FlipCardMaskWidget(model.flipCardWidth, model.flipCardHeight),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlipCardContentWidget(
                                model.flipCardWidth, model.fontSize / 2.8, model.metadataTop[model.currentDataItem]),
                            const SizedBox(height: 8),
                            FlipCardContentWidget(
                                model.flipCardWidth, model.fontSize / 2.8, model.metadataBottom[model.currentDataItem]),
                          ],
                        ),
                        FlipCardContentWidget(
                            model.flipCardWidth, model.fontSize, model.data[model.currentDataItem][0]),
                        FlipCardContentWidget(
                            model.flipCardWidth, model.fontSize, model.data[model.currentDataItem][1]),
                        FlipCardContentWidget(
                            model.flipCardWidth, model.fontSize, model.data[model.currentDataItem][2]),
                        FlipCardContentWidget(
                            model.flipCardWidth, model.fontSize, model.data[model.currentDataItem][3]),
                        FlipCardContentWidget(
                            model.flipCardWidth, model.fontSize, model.data[model.currentDataItem][4]),
                        FlipCardContentWidget(
                            model.flipCardWidth, model.fontSize, model.data[model.currentDataItem][5]),
                      ],
                    ),
                    const Divider(
                      thickness: 4,
                      color: Colors.black,
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
