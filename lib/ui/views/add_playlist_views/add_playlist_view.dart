import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/add_playlist_views/add_playlist_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddPlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPlaylistViewModel>.reactive(
      builder: (BuildContext context, AddPlaylistViewModel model, Widget child) =>
          Scaffold(
            appBar: AppBar(
              title: Text("Add Playlist"),
               backgroundColor: appBar_red,
              centerTitle: true,
            ),
            body: Center(
              child: Text('Add Playlist')
            )
          ),
      viewModelBuilder: () => AddPlaylistViewModel(),
    );
  }
}