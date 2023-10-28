import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/episodes_controller.dart';

class EpisodeView extends HookConsumerWidget {
  const EpisodeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final state = ref.watch(episodesProvider);
    return Scaffold(
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        failed: () => const Center(
          child: Text('Episodes'),
        ),
        loaded: (value) => ListView.separated(
          itemBuilder: (_, i) {
            final episodes = value.results[i];
            return ListTile(
              title: Text(episodes.name),
              subtitle: Text(episodes.episode),
            );
          },
          separatorBuilder: (_, i) => const SizedBox(height: 10),
          itemCount: value.results.length,
        ),
      ),
    );
  }
}
