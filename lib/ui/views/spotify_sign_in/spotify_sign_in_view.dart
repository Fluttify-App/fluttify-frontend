import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttify/services/api_service.dart';
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
                      colors: <Color>[gradientColor_1, gradientColor_2])),
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
                            'assets/images/Fluttify.png',
                            width: 280.0,
                          )
                        ],
                      ),
                      model.isLoading
                          ? SpinKitFadingCube(size: 36, color: Colors.green)
                          : Consumer<ApiService>(
                              builder: (_, auth, __) => TextButton(
                                onPressed: () => model.handleSignIn(auth),
                                child: Text("Anmelden",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900)),
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
