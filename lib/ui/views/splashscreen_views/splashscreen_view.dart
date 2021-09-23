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
                  color: Theme.of(context)
                      .scaffoldBackgroundColor //Color(0xff424242)
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
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/FluttifyWhiteBlack.png',
                              width: 150.0,
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: CircularProgressIndicator(
                                    strokeWidth: 6,
                                    color: Theme.of(context)
                                        .primaryColor // Colors.white //Color(0xffe70037) //ite,
                                    ),
                              ))
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => SplashScreenViewModel());
  }
}
