import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/licences_view.dart';
import 'package:fluttify/ui/views/privacy_view.dart';
import 'package:fluttify/ui/views/settings_views/settings_view.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FluttifyDrawer extends StatelessWidget {
  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.6,
        child: Drawer(
          backgroundColor: Theme.of(context).primaryColorDark,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      height: 180,
                      child: Stack(children: <Widget>[
                        Container(
                            alignment: Alignment.topCenter,
                            height: 90,
                            color: Theme.of(context).primaryColor),
                        Container(
                          height: 180,
                          alignment: Alignment.center,
                          //color: Colors.green,
                          child: Container(
                            decoration: BoxDecoration(
                              //  border: Border(),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                                locator<AuthService>()
                                        .currentUser
                                        .avatarImageUrl ??
                                    "https://img.icons8.com/color/452/avatar.png",
                                fit: BoxFit.fitHeight,
                                height: 130,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(color: Colors.grey);
                                },
                              ),
                            ),
                          ),
                        ),
                      ])),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.white,
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
              Expanded(
                child: ColoredBox(
                  color: Theme.of(context).primaryColorLight,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 24,
                            color: Theme.of(context).primaryColorDark),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColorDark),
                                child: ListTile(
                                    horizontalTitleGap: 0,
                                    dense: true,
                                    trailing: Icon(Icons.settings,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                    title: Text(
                                        AppLocalizations.of(context)!.settings,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    onTap: () {
                                      locator<PlaylistNavigationService>()
                                          .navigateTo(
                                              '/settings-view', SettingsView(),
                                              withNavBar: false);
                                    }),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColorDark),
                                child: ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  trailing: Icon(Icons.privacy_tip,
                                      color: Theme.of(context).iconTheme.color),
                                  title: Text(
                                      AppLocalizations.of(context)!.privacy,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2),
                                  onTap: () {
                                    _navigationService.navigateTo(
                                        '/privacy', PrivacyScreen(),
                                        withNavBar: false);
                                  },
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColorDark),
                                child: ListTile(
                                  horizontalTitleGap: 0,
                                  dense: true,
                                  trailing: Icon(Icons.description,
                                      color: Theme.of(context).iconTheme.color),
                                  title: Text(
                                    AppLocalizations.of(context)!.licence,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  onTap: () {
                                    _navigationService.navigateTo(
                                        '/licences', LicencesScreen(),
                                        withNavBar: false);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              ColoredBox(
                color: Theme.of(context).cardColor,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColorDark),
                          child: ListTile(
                            dense: true,
                            horizontalTitleGap: 0,
                            trailing: Icon(Icons.logout,
                                color: Theme.of(context).iconTheme.color),
                            /*leading: Icon(Icons.logout,
                                color: Theme.of(context).iconTheme.color),
                           */
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
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          text:
                                              AppLocalizations.of(context)!.no,
                                          width: 80,
                                          height: 35),
                                      FluttifyButton(
                                          onPressed: () =>
                                              locator<AuthService>()
                                                  .logoutBackend(),
                                          text:
                                              AppLocalizations.of(context)!.yes,
                                          width: 80,
                                          height: 35),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
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
