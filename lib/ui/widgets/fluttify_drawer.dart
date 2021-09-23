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
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: new Drawer(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      height: 180,
                      //alignment: Alignment.center,
                      child: Stack(children: <Widget>[
                        Container(
                            alignment: Alignment.topCenter,
                            height: 90,
                            color: Theme.of(context).primaryColor),
                        Container(
                          height: 180,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  locator<AuthService>()
                                          .currentUser
                                          .avatarImageUrl ??
                                      "https://img.icons8.com/color/452/avatar.png",
                                  fit: BoxFit.fitHeight,
                                  height: 130,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: IconButton(
                          icon: Icon(Icons.close),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(locator<AuthService>().currentUser.name!,
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  Text(locator<AuthService>().currentUser.email!,
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
              //   new Column(children: ),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Divider(),
                      ),
                      ListTile(
                          dense: true,
                          leading: new Icon(Icons.settings),
                          title: new Text(
                              AppLocalizations.of(context)!.settings,
                              style: Theme.of(context).textTheme.bodyText2),
                          onTap: () {
                            locator<PlaylistNavigationService>().navigateTo(
                                '/settings-view', SettingsView(),
                                withNavBar: false);
                          }),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.privacy_tip),
                        title: Text(AppLocalizations.of(context)!.privacy,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      ListTile(
                        dense: true,
                        leading: Icon(Icons.description),
                        title: Text(AppLocalizations.of(context)!.licence,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ]),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.logout),
                          title: Text(AppLocalizations.of(context)!.logout,
                              style: Theme.of(context).textTheme.bodyText2),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    AppLocalizations.of(context)!.logout,
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!
                                              .logoutcheck,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
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
                                        onPressed: () => locator<AuthService>()
                                            .logoutBackend(),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
