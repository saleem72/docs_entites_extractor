//

import 'package:docs_entites_extractor/core/domain/models/founded_object.dart';
import 'package:flutter/material.dart';
import 'app_screens.dart';
import 'routing_error.dart';
import 'screens.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic>? generate(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case AppScreens.initial:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case AppScreens.idScreen:
        return MaterialPageRoute(
          builder: (context) => const IDDetectorScreen(),
        );
      case AppScreens.idResult:
        final object = arguments is FoundedObjectWithPhoto ? arguments : null;

        if (object == null) {
          return MaterialPageRoute(
            builder: (context) => const RoutingError(
                errorMessage: "IDDetectorResultScreen needs an object"),
          );
        }

        return MaterialPageRoute(
          builder: (context) => IDDetectorResultScreen(object: object),
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>
              RoutingError(errorMessage: "Unknown route ${settings.name}"),
        );
    }
  }
}
