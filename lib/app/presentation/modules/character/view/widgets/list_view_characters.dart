import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../domain/models/character/character.dart';
import '../../../../global/extensions/build_context_ext.dart';
import '../../../../routes/routes.dart';
import '../../controller/character_controller.dart';

class BodyCharger extends HookConsumerWidget {
  const BodyCharger({
    super.key,
    required this.listResult,
    required this.status,
  });

  final List<Result> listResult;
  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    useAutomaticKeepAlive();
    return NotificationListener(
      onNotification: (t) {
        if (t is ScrollEndNotification) {
          final offset = scrollController.position.pixels;
          final maxScrollExtent = scrollController.position.maxScrollExtent;
          if (offset >= maxScrollExtent) {
            int page =
                ref.read(characterController.notifier).characterState.page;
            ref.read(characterController.notifier).pagination(
                  status: status,
                  page: page += 1,
                );
          }
        }
        return true;
      },
      child: BodyList(
        listResult: listResult,
        scrollController: scrollController,
      ),
    );
  }
}

class BodyList extends StatelessWidget {
  const BodyList({
    super.key,
    required this.listResult,
    required this.scrollController,
  });

  final List<Result> listResult;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: listResult.length,
      itemBuilder: (_, i) {
        final data = listResult[i];

        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            Routes.DETAILS,
            arguments: data,
          ),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: data.image,
                      child: ExtendedImage.network(
                        data.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(15).copyWith(bottom: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            stops: const [
                              0.2,
                              0.8,
                              1,
                            ],
                            colors: [
                              Colors.transparent,
                              Colors.black45,
                              context.color.inversePrimary,
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              data.name,
                              style: context.textTheme.titleLarge,
                            ),
                            Row(
                              children: [
                                Text(data.species),
                                const SizedBox(width: 5),
                                Icon(
                                  !data.gender.contains('male')
                                      ? Icons.male
                                      : Icons.female,
                                  color: data.gender.contains('male')
                                      ? Colors.pinkAccent
                                      : Colors.blue.shade400,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
