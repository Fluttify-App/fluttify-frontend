import 'package:flutter/material.dart';
import 'package:fluttify/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  LocaleService(this._locale);

  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(String locale) async {
    Locale newLocale = Locale(locale);
    if (!L10n.all.contains(newLocale)) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale);
    _locale = newLocale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
