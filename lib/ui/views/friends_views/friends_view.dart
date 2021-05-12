import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/friends_views/friends_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FriendsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FriendsViewModel>.reactive(
      builder: (BuildContext context, FriendsViewModel model, Widget child) =>
          Scaffold(
            appBar: AppBar(
              title: Text("Friends"),
               backgroundColor: Color.fromARGB(255, 20, 20, 20),
              centerTitle: true,
            ),
            body: Center(
              child: Text('Friends')
            )
          ),
      viewModelBuilder: () => FriendsViewModel(),
    );
  }
}