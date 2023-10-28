import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/character_controller.dart';
import 'widgets/list_view_characters.dart';

enum Status { all, alive, dead, unknown }

class CharacterView extends HookConsumerWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(characterController);
    final valueStatus = useState(Status.all);
    return Column(
      children: [
        SegmentedButton(
          segments: const [
            ButtonSegment(value: Status.all, icon: Text('all')),
            ButtonSegment(value: Status.alive, icon: Text('alive')),
            ButtonSegment(value: Status.dead, icon: Text('dead')),
            ButtonSegment(value: Status.unknown, icon: Text('unknown')),
          ],
          selected: <Status>{valueStatus.value},
          onSelectionChanged: (value) {
            valueStatus.value = value.first;
            ref.read(characterController.notifier).init(
                  status: value.first.name,
                );
          },
        ),
        const SizedBox(height: 10),
        Expanded(
          child: value.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            failed: () => const Center(child: Icon(Icons.question_answer)),
            loaded: (data) => BodyCharger(listResult: data.results),
          ),
        ),
      ],
    );
  }
}
