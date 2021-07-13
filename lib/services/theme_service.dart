import 'package:flutter/material.dart';
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
    accentColor: Color.fromARGB(255, 203, 45, 62),
    scaffoldBackgroundColor: Color(0xff1c1c1c),
    cardColor: Color(0xff424242),
    hintColor: Color(0xffbdb9ba),
    appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 203, 45, 62)),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Color(0xff424242)),
    textTheme: TextTheme(
      button: const TextStyle(
          fontSize: 16, fontFamily: 'Montserrat', color: Colors.white),
      bodyText1: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      bodyText2: const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      headline1: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      headline2: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      headline3: const TextStyle(
          color: Color(0xff1a1a1a),
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w800),
      headline4: const TextStyle(
          color: Color(0xFF979797),
          fontSize: 15.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      subtitle1: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      subtitle2: const TextStyle(
          color: Colors.white,
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
        backgroundColor: Color.fromARGB(255, 203, 45, 62),
        primary: Colors.white,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.black,
    accentColor: Color.fromARGB(255, 203, 45, 62),
    scaffoldBackgroundColor: Color(0xffdae0e6),
    cardColor: Colors.white,
    hintColor: Color(0xff3b3b3b),
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 203, 45, 62),
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.white),
    textTheme: TextTheme(
      button: const TextStyle(
          fontSize: 16, fontFamily: 'Montserrat', color: Colors.white),
      bodyText1: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      bodyText2: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      headline1: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      headline2: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      headline3: const TextStyle(
          color: Color(0xff1a1a1a),
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      headline4: const TextStyle(
          color: Color(0xFF646464),
          fontSize: 15.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      subtitle1: const TextStyle(
          color: Colors.black,
          fontSize: 12.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal),
      subtitle2: const TextStyle(
          color: Colors.white,
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
        backgroundColor: Color.fromARGB(255, 203, 45, 62),
        primary: Colors.black,
      ),
    ),
  );
}
