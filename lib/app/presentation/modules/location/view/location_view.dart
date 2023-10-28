import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/location_controller.dart';

class LocationView extends HookConsumerWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();

    final state = ref.watch(locationProvider);
    return Scaffold(
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        failed: () => const Center(
          child: Text('Loaction'),
        ),
        loaded: (value) => ListView.separated(
          itemBuilder: (_, i) {
            final location = value.results[i];
            return ListTile(
              title: Text(location.name),
              subtitle: Text(location.dimension),
            );
          },
          separatorBuilder: (_, i) => const SizedBox(height: 10),
          itemCount: value.results.length,
        ),
      ),
    );
  }
}
