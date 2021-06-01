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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.white, width: 10),
                              borderRadius: BorderRadius.circular(150)),
                          child: Image.asset(
                            'assets/images/FluttifyRed.png',
                            width: 280.0,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 64.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Colors.white,
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                padding: EdgeInsets.only(
                                    left: 32, right: 32, top: 8, bottom: 8),
                                primary: Color(0xffb1a1a1a)),
                            onPressed: () => model.handleSignIn(),
                            child: Text(
                              "Sign In With Spotify",
                              style: TextStyle(
                                  color: Colors
                                      .white, // Theme.of(context).accentColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
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
