import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttify/ui/views/home_view.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomeView()),
    );
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      titlePadding: EdgeInsets.fromLTRB(32, 132, 32, 32),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    const startPageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      //  titlePadding: EdgeInsets.fromLTRB(32, 132, 32, 32),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
    );

    return IntroductionScreen(
      color: Colors.white,
      key: introKey,
      globalBackgroundColor: Colors.white,
/*
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      */
      pages: [
        PageViewModel(
          title: AppLocalizations.of(context)!.welcome,
          body: AppLocalizations.of(context)!.onboardingcontent1,
          image: _buildImage('images/FluttifyRed.png'),
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
      dotsDecorator: const DotsDecorator(
        activeColor: Color.fromARGB(255, 203, 45, 62),
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
