import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/inject_dependencies.dart';
import 'app/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
