import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/home_view.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isOnboarded", true);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomeView()),
    );
  }

  Widget _buildImage(String assetName, [double width = 150]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const startPageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(color: Colors.black, fontSize: 16.0),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      //  titlePadding: EdgeInsets.fromLTRB(32, 132, 32, 32),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
    );

    return IntroductionScreen(
      color: Colors.white,
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: AppLocalizations.of(context)!.welcome,
          body: AppLocalizations.of(context)!.onboardingcontent1,
          image: _buildImage('images/FluttifyWhiteBlack.png'),
          decoration: startPageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboardingtitle2,
          body: AppLocalizations.of(context)!.onboardingcontent2,
          image: _buildImage('images/onboarding/playlist.png'),
          decoration: startPageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboardingtitle3,
          body: AppLocalizations.of(context)!.onboardingcontent3,
          image: _buildImage('images/onboarding/friends.png'),
          decoration: startPageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboardingtitle4,
          body: AppLocalizations.of(context)!.onboardingcontent4,
          image: _buildImage('images/onboarding/algorith.png'),
          decoration: startPageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.onboardingtitle5,
          body: AppLocalizations.of(context)!.onboardingcontent5,
          image: _buildImage('images/onboarding/interval.png'),
          decoration: startPageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Start', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
        activeColor: Theme.of(context).primaryColor,
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
