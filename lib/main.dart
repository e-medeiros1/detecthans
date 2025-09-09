import 'package:detect_hans/core/providers/app_provider.dart';
import 'package:detect_hans/core/routes/app_router.dart';
import 'package:detect_hans/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DetecHansApp());
}

class DetecHansApp extends StatelessWidget {
  const DetecHansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
      child: MaterialApp(
        title: 'DetectHans',
        theme: AppTheme.lightTheme.copyWith(scaffoldBackgroundColor: Colors.white),
        initialRoute: AppRouter.initial,
        onGenerateRoute: AppRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
