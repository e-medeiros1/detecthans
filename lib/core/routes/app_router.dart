import 'package:detect_hans/views/questionnaire/questionnaire_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String initial = '/';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const QuestionnairePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const QuestionnairePage(),
        );
    }
  }
}
