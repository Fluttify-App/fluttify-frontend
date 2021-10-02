import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //brightness: Brightness.dark,
          title: Text(AppLocalizations.of(context)!.privacy),
        ),
        body: Center(
          child: Text("Soon..."),
        ),
      ),
    );
  }
}
