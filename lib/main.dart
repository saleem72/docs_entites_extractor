import 'package:docs_entites_extractor/core/configuration/routing/app_router.dart';
import 'package:docs_entites_extractor/core/configuration/routing/app_screens.dart';
import 'package:flutter/material.dart';
import 'package:my_core/my_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeProvider.lightTheme(),
      onGenerateRoute: AppRouter.generate,
      initialRoute: AppScreens.initial,
    );
  }
}
