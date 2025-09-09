import 'package:detect_hans/views/home/home_page.dart';
import 'package:detect_hans/views/story/story_page.dart';
import 'package:detect_hans/views/questionnaire/questionnaire_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String initial = '/';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/story':
        final story = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => StoryPage(story: story));
      case '/questionnaire':
        return MaterialPageRoute(builder: (_) => const QuestionnairePage());
      // Add more routes here
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
