import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttify/services/auth_service.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/spotify_sign_in/spotify_sign_in_viewmodel.dart';
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
                      colors: <Color>[
                    fluttify_gradient_1,
                    fluttify_gradient_2
                  ])),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                extendBodyBehindAppBar: true,
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/FluttifyRed.png',
                            width: 280.0,
                          )
                        ],
                      ),
                      model.isLoading
                          ? SpinKitFadingCube(size: 36, color: Colors.green)
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  padding: EdgeInsets.all(16),
                                  primary: Colors.black),
                              onPressed: () => model.handleSignIn(),
                              child: Text("Sign In with Spotify",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                            ),
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => SpotifySignInViewModel());
  }
}
