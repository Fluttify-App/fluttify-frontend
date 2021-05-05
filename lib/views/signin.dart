import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:fluttify/services/spotify_auth.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in';

  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    //_initialSignIn();
  }

/*
  Future<void> _initialSignIn() async {
    final auth = context.read<SpotifyAuth>();
    final uriManager = SpotifyUriManager(auth);
    setState(() => _isLoading = true);
    try {
      final initialUri = await getInitialUri();
      if (initialUri == null) {
        _signInFromSavedTokens();
        return;
      }
      await uriManager.handleLoadFromUri(initialUri);
    } catch (e) {
      if (!mounted) return;
      uriManager.handleFail();
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInFromSavedTokens() async {
    final auth = context.read<SpotifyAuth>();
    setState(() => _isLoading = true);
    try {
      await auth.signInFromSavedTokens();
      Navigator.popAndPushNamed(context, HomePage.routeName);
    } catch (_) {} finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSignIn(SpotifyAuth auth, BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      await auth.authenticate();
      Navigator.popAndPushNamed(context, HomePage.routeName);
    } catch (e) {
      CustomToast.showTextToast(
          text: "Failed to sign in", toastType: ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }
*/

  Future<void> _handleSignIn(SpotifyAuth auth, BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      await auth.authenticate();
      print("Logged in");
      //Navigator.popAndPushNamed(context, HomePage.routeName);
    } catch (e) {
      //CustomToast.showTextToast(
      //   text: "Failed to sign in", toastType: ToastType.error);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _isLoading
                ? SpinKitFadingCube(size: 36, color: Colors.green)
                : Consumer<SpotifyAuth>(
                    builder: (_, auth, __) => TextButton(
                      onPressed: () => _handleSignIn(auth, context),
                      child: Text("Anmelden",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900)),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
