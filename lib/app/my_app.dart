import 'package:flutter/material.dart';

import 'presentation/global/theme/theme.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serie Rick And Morty',
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      theme: getTheme(true),
    );
  }
}
