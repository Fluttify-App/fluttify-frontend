import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
               backgroundColor: Color.fromARGB(255, 20, 20, 20),
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