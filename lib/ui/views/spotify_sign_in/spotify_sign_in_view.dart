import 'package:flutter/material.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/spotify_sign_in/spotify_sign_in_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpotifySignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SpotifySignInViewModel>.reactive(
        builder: (BuildContext context, SpotifySignInViewModel model,
                Widget? child) =>
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[fluttify_gradient_1, fluttify_gradient_2],
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                extendBodyBehindAppBar: true,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 8,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.title,
                                  style: TextStyle(
                                      fontFamily: 'Kellvin',
                                      fontSize: 80,
                                      color: Color(0xff1a1a1a))),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 22.0),
                                child: Text(
                                    AppLocalizations.of(context)!.subtitle,
                                    style: TextStyle(
                                        fontFamily: 'Kellvin',
                                        fontSize: 22,
                                        color: Color(0xff1a1a1a))),
                              ),
                              Image.asset(
                                'assets/images/FluttifyRed.png',
                                width: 220.0,
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff1a1a1a),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )),
                          child: Center(
                            child: FluttifyButton(
                                width: 300,
                                height: 50,
                                onPressed: () => model.handleSignIn(),
                                text: AppLocalizations.of(context)!
                                    .signin, //"Sign In With Spotify",
                                textStyle:
                                    Theme.of(context).textTheme.headline3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => SpotifySignInViewModel());
  }
}
