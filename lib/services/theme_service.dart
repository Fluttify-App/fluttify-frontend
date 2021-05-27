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
    primaryColor: Colors.white,
    accentColor: Color(0xffef473a),
    scaffoldBackgroundColor: Color(0xff1c1c1c),
    cardColor: Color(0xff424242),
    hintColor: Color(0xffbdb9ba),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xff424242)),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Color(0xff424242)),
    textTheme: TextTheme(
      button: const TextStyle(
          fontSize: 14, fontFamily: 'Montserrat', color: Colors.white),
      bodyText1: const TextStyle(
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      bodyText2: const TextStyle(
          fontSize: 18.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      headline1: const TextStyle(
          fontSize: 25.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      subtitle1: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
    ),
    backgroundColor: Color(0xff1c1c1c),
    dividerColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        //  side: BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color(0xffef473a),
        primary: Colors.white,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.black,
    accentColor: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Color(0xffcfcfcf),
    hintColor: Color(0xff3b3b3b),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.teal,
        titleTextStyle: TextStyle(color: Colors.black)),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.teal),
    textTheme: TextTheme(
      button: const TextStyle(
          fontSize: 14, fontFamily: 'Montserrat', color: Colors.black),
      bodyText1: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      bodyText2: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      headline1: const TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      subtitle1: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
    ),
    backgroundColor: Colors.black,
    dividerColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.teal,
        primary: Colors.black,
      ),
    ),
  );
}
