import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/community_views/community_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CommunityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityViewModel>.reactive(
      builder:
          (BuildContext context, CommunityViewModel model, Widget? child) =>
              Scaffold(
                  appBar: AppBar(
                    title: Text("Community",
                        style: Theme.of(context).textTheme.headline2),
                    centerTitle: true,
                    /*
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[fluttify_gradient_1, fluttify_gradient_2],
                    ),
                  ),
                ),
                */
                  ),
                  body: Center(child: Text('Community'))),
      viewModelBuilder: () => CommunityViewModel(),
    );
  }
}
