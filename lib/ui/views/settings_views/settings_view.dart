import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttify/services/locale_service.dart';
import 'package:fluttify/services/theme_service.dart';
import 'package:fluttify/ui/views/settings_views/settings_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      builder: (BuildContext context, SettingsViewModel model, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settings,
              style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                // THEME
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.color,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pick a color!'),
                                  content: SingleChildScrollView(
                                    child: BlockPicker(
                                      availableColors: [
                                        const Color.fromARGB(255, 203, 45, 62),
                                        Color(0xff008F61),
                                        Color(0xff005792)
                                      ],
                                      pickerColor: Provider.of<ThemeService>(
                                              context,
                                              listen: false)
                                          .getColor(),
                                      onColorChanged: (value) {
                                        Provider.of<ThemeService>(context,
                                                listen: false)
                                            .setColor(value);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.circle,
                            color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor, height: 10),
                // DARK MODE
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.darkmode,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Switch(
                        value: Provider.of<ThemeService>(context).getDarkMode(),
                        onChanged: (value) {
                          Provider.of<ThemeService>(context, listen: false)
                              .setDarkMode(value);
                        },
                        //activeTrackColor: Theme.of(context).accentColor,
                        activeColor: Theme.of(context).accentColor,
                        inactiveThumbColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor, height: 10),

                // LANGUAGE
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.language,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      ToggleSwitch(
                        initialLabelIndex:
                            Provider.of<LocaleService>(context, listen: false)
                                        .locale ==
                                    Locale("en")
                                ? 0
                                : 1,
                        labels: ["en", "de"],
                        activeBgColor: [
                          Theme.of(context).accentColor,
                        ],
                        activeFgColor: Colors.white,
                        inactiveFgColor: Colors.white,
                        onToggle: (int index) {
                          String newLocale = 'en';
                          if (index == 1) newLocale = 'de';
                          Provider.of<LocaleService>(context, listen: false)
                              .setLocale(newLocale);
                        },
                        totalSwitches: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SettingsViewModel(),
    );
  }
}