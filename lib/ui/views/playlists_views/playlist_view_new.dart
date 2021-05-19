import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:fluttify/ui/views/edit_playlist_views/edit_playlist_view.dart';
import 'package:stacked/stacked.dart';
import 'package:fluttify/services/api_service.dart';

class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaylistViewModel>.reactive(
      builder: (BuildContext context, PlaylistViewModel model, Widget child) =>
          Scaffold(
        appBar: AppBar(
          title: Text("Playlists New"),
          backgroundColor: appBar_red,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[gradientColor_1, gradientColor_2],
              ),
            ),
          ),
        ),
        body: Center(
          child: Container(
              child: !model.isLoading
                  ? ListView.builder(
                      itemCount: model.playlists.length,
                      itemBuilder: (context, index) {
                        return Text(model.playlists[index].name);
                      })
                  : Container()),
        ),
      ),
      viewModelBuilder: () => PlaylistViewModel(),
    );
  }
}
