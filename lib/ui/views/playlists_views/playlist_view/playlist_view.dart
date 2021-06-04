import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/playlist_card.dart';
import 'package:stacked/stacked.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';

class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaylistViewModel>.reactive(
      onModelReady: (PlaylistViewModel viewModel) =>
          viewModel.refreshPlaylists(),
      builder: (BuildContext context, PlaylistViewModel model, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          title:
              Text("Playlists", style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: !model.isLoading
                ? FractionallySizedBox(
                    widthFactor: 0.95,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        model.refreshPlaylists();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (Playlist playlist
                                  in model.playlistService.myplaylists.reversed)
                                PlaylistCard(
                                  model: model,
                                  playlist: playlist,
                                ),
                              for (Playlist playlist
                                  in model.playlistService.contributed.reversed)
                                PlaylistCard(
                                  model: model,
                                  playlist: playlist,
                                ),
                              for (Playlist playlist
                                  in model.playlistService.liked.reversed)
                                PlaylistCard(
                                  model: model,
                                  playlist: playlist,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.white,
          onPressed: () {
            model.navigateToAddPlaylist();
          },
          child: Icon(Icons.add),
        ),
      ),
      viewModelBuilder: () => PlaylistViewModel(),
    );
  }
}
