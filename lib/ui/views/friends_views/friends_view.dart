import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/friends_views/friends_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FriendsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FriendsViewModel>.reactive(
      builder: (BuildContext context, FriendsViewModel model, Widget? child) =>
          Scaffold(
              appBar: AppBar(
                title: Text("Playlists"),
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
              body: Center(child: Text('Friends'))),
      viewModelBuilder: () => FriendsViewModel(),
    );
  }
}
