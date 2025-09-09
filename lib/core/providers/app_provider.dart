import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  // App state
  bool _isLoading = false;
  String _currentRoute = '/';
  ThemeMode _themeMode = ThemeMode.system;
  
  // Getters
  bool get isLoading => _isLoading;
  String get currentRoute => _currentRoute;
  ThemeMode get themeMode => _themeMode;
  
  // Setters
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void setCurrentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
  
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    notifyListeners();
  }
} 