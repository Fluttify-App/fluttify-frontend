import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/settings_views/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      builder: (BuildContext context, SettingsViewModel model, Widget? child) =>
          Scaffold(
              appBar: AppBar(
                title: Text("Settings"),
                backgroundColor: fluttify_Red,
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[fluttify_gradient_1, fluttify_gradient_2],
                    ),
                  ),
                ),
              ),
              body: Center(child: Text('Settings'))),
      viewModelBuilder: () => SettingsViewModel(),
    );
  }
}
