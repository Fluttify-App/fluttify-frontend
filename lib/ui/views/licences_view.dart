import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/licence.dart';
import 'package:fluttify/ui/widgets/licences_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LicencesScreen extends StatefulWidget {
  @override
  _LicencesScreenState createState() => _LicencesScreenState();
}

class _LicencesScreenState extends State<LicencesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        title: Text(AppLocalizations.of(context)!.thirdpartylicences),
      ),
      body: FutureBuilder<List<License>>(
        future: readLicense(),
        builder: (context, snapshot) {
          final allLicense = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor));
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Can not load Licenses'));
              } else {
                return Container(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: LicensesWidget(licenses: allLicense));
              }
          }
        },
      ),
    ));
  }

  Future<List<License>> readLicense() async =>
      LicenseRegistry.licenses.asyncMap<License>((license) async {
        final title = license.packages.join('\n');
        final text = license.paragraphs
            .map<String>((paragraph) => paragraph.text)
            .join('\n\n');

        return License(title, text);
      }).toList();
}
