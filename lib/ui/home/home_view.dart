import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(context),
      builder: (context, model, child) => SafeArea(
        child: GestureDetector(
          onTap: () => model.exitFullScreen(),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: model.isFullScreen == true ? 0 : AppBar().preferredSize.height,
              actions: [
                Row(
                  children: [
                    IconButton(onPressed: () => model.toggleTheme(context), icon: const Icon(Icons.dark_mode)),
                    IconButton(onPressed: () => model.showNext(), icon: const Icon(Icons.cached)),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: model.flipCardWidth,
                              child: Text(
                                model.metadataTop[model.currentDataItem],
                                style: TextStyle(fontSize: model.fontSize / 4.4),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: model.flipCardWidth,
                              child: Text(
                                model.metadataBottom[model.currentDataItem],
                                style: TextStyle(fontSize: model.fontSize / 4.4),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: model.flipCardWidth,
                          child: Text(
                            model.data[model.currentDataItem][0],
                            style: TextStyle(fontSize: model.fontSize),
                          ),
                        ),
                        SizedBox(
                          width: model.flipCardWidth,
                          child: Text(
                            model.data[model.currentDataItem][1],
                            style: TextStyle(fontSize: model.fontSize),
                          ),
                        ),
                        SizedBox(
                          width: model.flipCardWidth,
                          child: Text(
                            model.data[model.currentDataItem][2],
                            style: TextStyle(fontSize: model.fontSize),
                          ),
                        ),
                        SizedBox(
                          width: model.flipCardWidth,
                          child: Text(
                            model.data[model.currentDataItem][3],
                            style: TextStyle(fontSize: model.fontSize),
                          ),
                        ),
                        SizedBox(
                          width: model.flipCardWidth,
                          child: Text(
                            model.data[model.currentDataItem][4],
                            style: TextStyle(fontSize: model.fontSize),
                          ),
                        ),
                        SizedBox(
                          width: model.flipCardWidth,
                          child: Text(
                            model.data[model.currentDataItem][5],
                            style: TextStyle(fontSize: model.fontSize),
                          ),
                        ),
                      ],
                    ),
                    const Divider()
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
