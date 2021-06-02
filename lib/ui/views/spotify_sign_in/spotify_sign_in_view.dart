import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/spotify_sign_in/spotify_sign_in_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

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
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset(
                          'assets/images/FluttifyRed.png',
                          width: 280.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 64.0),
                        child: Container(
                          child: FluttifyButton(
                            onPressed: () => model.handleSignIn(),
                            text: "Sign In With Spotify",
                            textStyle: Theme.of(context).textTheme.headline2,
                            color: Colors.transparent,
                            //color: Color.fromARGB(255, 233, 30, 30),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          child: FluttifyButton(
                            onPressed: () => model.handleSignIn(),
                            text: "Leave",
                            textStyle: Theme.of(context).textTheme.button,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => SpotifySignInViewModel());
  }
}
