import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaylistViewModel>.reactive(
      builder: (BuildContext context, PlaylistViewModel model, Widget child) =>
          Scaffold(
            body: Center(
              child: Text('Playlists')
            )
          ),
      viewModelBuilder: () => PlaylistViewModel(),
    );
  }
}