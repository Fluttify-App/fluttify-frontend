import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class ThemeService extends ChangeNotifier {
  ThemeService(bool? darkMode, {Color? color}) {
    if (color != null) {
      _currentColor = color;
    }
    if (darkMode!) {
      _currentTheme = darkTheme;
      _currentDarkMode = true;
    } else {
      _currentTheme = lightTheme;
      _currentDarkMode = false;
    }
  }

  ThemeData? _currentTheme;
  bool? _currentDarkMode;
  static Color? _currentColor;

  ThemeData getTheme() => _currentTheme!;
  Color getColor() => _currentColor!;
  bool getDarkMode() {
    return _currentDarkMode!;
  }

  void setDarkMode(bool darkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentDarkMode = darkMode;
    prefs.setBool('darkMode', darkMode);
    if (darkMode) {
      _currentTheme = darkTheme.copyWith(
          accentColor: _currentColor,
          appBarTheme: AppBarTheme(backgroundColor: _currentColor));
    } else {
      _currentTheme = lightTheme.copyWith(
          accentColor: _currentColor,
          appBarTheme: AppBarTheme(backgroundColor: _currentColor));
    }
    notifyListeners();
  }

  void setColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme', color.value);
    _currentColor = color;
    _currentTheme = _currentTheme!.copyWith(
        accentColor: color, appBarTheme: AppBarTheme(backgroundColor: color));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
    ));
    notifyListeners();
  }

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.white,
    accentColor: _currentColor, //Color.fromARGB(255, 203, 45, 62),
    scaffoldBackgroundColor: Color(0xff1c1c1c),
    cardColor: Color(0xff424242),
    errorColor: Color(0xff424242), // Color.fromARGB(255, 203, 45, 62),
    hintColor: Color(0xffbdb9ba),
    highlightColor: Color(0xff008F61),
    appBarTheme: AppBarTheme(backgroundColor: _currentColor),
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
          color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w800),
      headline4: const TextStyle(
          color: Color(0xFF979797),
          fontSize: 15.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      headline5: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        primary: Colors.white,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.black,
    accentColor: _currentColor,
    scaffoldBackgroundColor: Color(0xffdae0e6),
    cardColor: Colors.white,
    hintColor: Color(0xff3b3b3b),
    highlightColor: Color(0xff008F61),
    errorColor: Color(
        0xff424242), // Color(0xff3b3b3b), //Color.fromARGB(255, 203, 45, 62),
    appBarTheme: AppBarTheme(
        backgroundColor: _currentColor,
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
          color: Colors.white, //Color(0xff1a1a1a),
          fontSize: 20.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      headline4: const TextStyle(
          color: Color(0xFF646464),
          fontSize: 15.0,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600),
      headline5: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
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
        primary: Colors.black,
      ),
    ),
  );
}
