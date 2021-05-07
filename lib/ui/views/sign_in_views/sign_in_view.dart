import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttify/ui/views/sign_in_views/sign_in_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:fluttify/services/spotify_auth.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      builder: (BuildContext context, SignInViewModel model, Widget child) =>
       Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/text_logo.png',
                  width: 280.0,
                )
              ],
            ),
            model.isLoading
                ? SpinKitFadingCube(size: 36, color: Colors.green)
                : Consumer<SpotifyAuth>(
                    builder: (_, auth, __) => TextButton(
                      onPressed: () => model.handleSignIn(auth),
                      child: Text("Anmelden",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900)),
                    ),
                  )
          ],
        ),
      ),
    ), 
    viewModelBuilder: () => SignInViewModel());
  }
}
