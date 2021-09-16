import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttify/services/locale_service.dart';
import 'package:fluttify/services/theme_service.dart';
import 'package:fluttify/ui/views/user_views/user_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
      builder: (BuildContext context, UserViewModel model, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.user,
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
                Container(
                  height: 100,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Center(
                              child: CachedNetworkImage(
                                progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                    CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                        value: downloadProgress.progress),
                                imageUrl: model.authService.currentUser
                                        .avatarImageUrl ??
                                    "https://img.icons8.com/color/452/avatar.png",
                              ),
                            )),
                      ),
                      Expanded(
                        //flex: 7,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            model.authService.currentUser.name!,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor, height: 10),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.email,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        model.authService.currentUser.email!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor, height: 10),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.followers,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        model.authService.currentUser.follower!.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor, height: 10),
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

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FluttifyButton(
                      color: Theme.of(context).errorColor,
                      width: 150,
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(
                                AppLocalizations.of(context)!.logout,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.logoutcheck,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FluttifyButton(
                                    onPressed: () =>
                                        model.navigateBack(context),
                                    text: AppLocalizations.of(context)!.no,
                                    width: 80,
                                    height: 35),
                                FluttifyButton(
                                    onPressed: () =>
                                        model.authService.logoutBackend(),
                                    text: AppLocalizations.of(context)!.yes,
                                    width: 80,
                                    height: 35),
                              ],
                            );
                          },
                        ),
                      },
                      text: AppLocalizations.of(context)!.logout,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => UserViewModel(),
    );
  }
}
