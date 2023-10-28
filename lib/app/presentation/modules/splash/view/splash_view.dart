import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../inject_dependencies.dart';
import '../../../global/extensions/build_context_ext.dart';
import '../../../routes/routes.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offline = ref.watch(Repositories.connectivity);
    final mountedF = useIsMounted();
    final mounted = mountedF();
    useMemoized(
      () => Future.delayed(
        const Duration(seconds: 2),
        () async {
          final asInternet = await offline.hasInternet;
          if (!mounted) return;
          context.router.pushReplacementNamed(
            !asInternet ? Routes.OFFLINE : Routes.HOME,
          );
        },
      ),
      [],
    );

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
