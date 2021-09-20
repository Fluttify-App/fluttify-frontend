import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_viewmodel.dart';
import 'package:fluttify/ui/views/settings_views/settings_view.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';

class FluttifyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 250,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              currentAccountPictureSize: Size.square(120),
              accountName: new Text(locator<AuthService>().currentUser.name!,
                  style: Theme.of(context).textTheme.headline1),
              accountEmail: new Text(locator<AuthService>().currentUser.email!,
                  style: Theme.of(context).textTheme.headline5),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    locator<AuthService>().currentUser.avatarImageUrl ??
                        "https://img.icons8.com/color/452/avatar.png"),
              ),
            ),
          ),
          //   new Column(children: ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.settings),
                      title: new Text(AppLocalizations.of(context)!.settings,
                          style: Theme.of(context).textTheme.bodyText1),
                      onTap: () {
                        locator<PlaylistNavigationService>().navigateTo(
                            '/settings-view', SettingsView(),
                            withNavBar: false);
                      }),
                  ListTile(
                    leading: Icon(Icons.privacy_tip),
                    title: Text(AppLocalizations.of(context)!.privacy,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ]),
          ),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text(AppLocalizations.of(context)!.deleteprofile,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text(AppLocalizations.of(context)!.logout,
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
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
                                  onPressed: () => Navigator.pop(context),
                                  text: AppLocalizations.of(context)!.no,
                                  width: 80,
                                  height: 35),
                              FluttifyButton(
                                  onPressed: () =>
                                      locator<AuthService>().logoutBackend(),
                                  text: AppLocalizations.of(context)!.yes,
                                  width: 80,
                                  height: 35),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
