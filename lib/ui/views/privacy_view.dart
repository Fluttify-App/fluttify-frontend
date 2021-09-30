import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/licence.dart';
import 'package:fluttify/ui/widgets/licences_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          brightness: Brightness.dark,
          title: Text(AppLocalizations.of(context)!.privacy),
        ),
        body: Center(
          child: Text("Soon..."),
        ),
      ),
    );
  }
}
