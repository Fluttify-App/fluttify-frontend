import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/splashscreen_views/splashscreen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (BuildContext context, SplashScreenViewModel model,
                Widget? child) =>
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[fluttify_gradient_1, fluttify_gradient_2],
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                extendBodyBehindAppBar: true,
                resizeToAvoidBottomInset: false,
                body: Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'assets/images/FluttifyRed.png',
                            width: 280.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Container(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => SplashScreenViewModel());
  }
}
