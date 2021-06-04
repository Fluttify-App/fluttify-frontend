import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/services/theme_service.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/user_views/user_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
      builder: (BuildContext context, UserViewModel model, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          title: Text("User", style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                            model.authService.currentUser.avatarImageUrl ??
                                "https://img.icons8.com/color/452/avatar.png"),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          model.authService.currentUser.name!,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Theme.of(context).dividerColor, height: 10),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "E-Mail",
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
                        "Followers",
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
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark Mode",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Switch(
                        value: Provider.of<ThemeService>(context).getDarkMode(),
                        onChanged: (value) {
                          Provider.of<ThemeService>(context, listen: false)
                              .setDarkMode(value);
                        },
                        activeTrackColor: Color(0xffef473a),
                        activeColor: Color.fromARGB(255, 203, 45, 62),
                        inactiveThumbColor: Color.fromARGB(255, 203, 45, 62),
                      ),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor, height: 10),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FluttifyButton(
                      width: 150,
                      onPressed: () => {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(
                                'Logout',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                      'Would you like to logout from Fluttify?',
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
                                    text: 'No',
                                    width: 80,
                                    height: 35),
                                FluttifyButton(
                                    onPressed: () =>
                                        model.authService.logoutBackend(),
                                    text: 'Yes',
                                    width: 80,
                                    height: 35),
                              ],
                            );
                          },
                        ),
                      },
                      text: "Logout",
                      color: Color.fromARGB(255, 233, 30, 30),
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
