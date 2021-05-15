import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttify/services/api_service.dart';
import 'package:fluttify/ui/views/spotify_sign_in/spotify_sign_in_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SpotifySignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SpotifySignInViewModel>.reactive(
        builder: (BuildContext context, SpotifySignInViewModel model,
                Widget child) =>
            Scaffold(
              backgroundColor: Colors.green,
              extendBodyBehindAppBar: true,
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Fluttify.png',
                          width: 280.0,
                        )
                      ],
                    ),
                    model.isLoading
                        ? SpinKitFadingCube(size: 36, color: Colors.green)
                        : Consumer<ApiService>(
                            builder: (_, auth, __) => Column(
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0)),
                                      )),
                                  onPressed: () => model.loginWithSpotify(auth),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Sign in with Spotify",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                )
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => SpotifySignInViewModel());
  }
}
