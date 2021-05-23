import 'package:flutter/material.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  ThemeService(bool? darkMode) {
    if (darkMode!) {
      _currentTheme = darkTheme;
    } else {
      _currentTheme = lightTheme;
    }
  }

  ThemeData? _currentTheme;
  ThemeData getTheme() => _currentTheme!;

  bool getDarkMode() {
    return _currentTheme == darkTheme;
  }

  void setDarkMode(bool darkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', darkMode);
    if (darkMode) {
      _currentTheme = darkTheme;
    } else {
      _currentTheme = lightTheme;
    }
    notifyListeners();
  }

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color.fromARGB(255, 94, 8, 28), //Fluttify Red
    accentColor: Colors.teal,
    appBarTheme: AppBarTheme(backgroundColor: Color(0xffb424242)),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Color(0xffb424242)),
    textTheme: TextTheme(
      button: const TextStyle(
          fontSize: 18, fontFamily: 'Montserrat', color: Colors.white),
      bodyText1: const TextStyle(fontSize: 18.0, fontFamily: 'Montserrat'),
      headline1: const TextStyle(
          fontSize: 25.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
    ),
    dividerColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        //  side: BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.red,
        primary: Colors.white,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Color.fromARGB(255, 94, 8, 28), //Fluttify Red
    accentColor: Colors.teal,
    appBarTheme: AppBarTheme(backgroundColor: Colors.teal),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Color(0xffb424242)),
    textTheme: TextTheme(
      button: const TextStyle(
          fontSize: 18, fontFamily: 'Montserrat', color: Colors.black),
      bodyText1: const TextStyle(
          fontSize: 18.0, fontFamily: 'Montserrat', color: Colors.black),
      headline1: const TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
    ),
    dividerColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        //  side: BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.red,
        primary: Colors.black,
      ),
    ),
  );
}
