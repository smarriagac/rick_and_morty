import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

import '../../../global/extensions/build_context_ext.dart';
import '../../character/view/character_view.dart';
import '../../episode/view/episode_view.dart';
import '../../location/view/location_view.dart';
import 'widgets/botton_appbar.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tapController = useTabController(initialLength: 3);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Serie Rick And Morty'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          TabBarView(
            controller: tapController,
            children: const [
              CharacterView(),
              LocationView(),
              EpisodeView(),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: AppBottonBar(
              tabController: tapController,
            ),
          )
        ],
      ),
    );
  }
}

class AppBottonBar extends StatefulWidget {
  const AppBottonBar({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  @override
  State<AppBottonBar> createState() => _AppBottonBarState();
}

class _AppBottonBarState extends State<AppBottonBar> {
  List<SMIInput<bool>?> inputs = [];
  List<Artboard> artboards = [];
  List<String> assetPaths = [
    'assets/fire.riv',
    'assets/land.riv',
    'assets/composer.riv',
  ];

  int currentActiveIndex = 0;

  initializeArtboard() async {
    for (var path in assetPaths) {
      final data = await rootBundle.load(path);

      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
      SMIInput<bool>? input;
      if (controller != null) {
        artboard.addController(controller);
        input = controller.findInput<bool>('status');
        input!.value = true;
      }
      inputs.add(input);
      artboards.add(artboard);
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initializeArtboard();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      height: 70,
      decoration: BoxDecoration(
        color: context.color.background.withAlpha(200),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: artboards.map<Widget>((artboard) {
          final index = artboards.indexOf(artboard);
          return BottomAppBarItem(
            artboard: artboard,
            currentIndex: currentActiveIndex,
            tabIndex: index,
            input: inputs[index],
            onpress: () {
              setState(() {
                currentActiveIndex = index;
                widget.tabController.animateTo(index);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
