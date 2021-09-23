import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/playlist_card.dart';
import 'package:fluttify/ui/widgets/fluttify_drawer.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaylistViewModel>.reactive(
      onModelReady: (PlaylistViewModel viewModel) =>
          viewModel.refreshPlaylists(),
      builder: (BuildContext context, PlaylistViewModel model, Widget? child) =>
          Scaffold(
        key: model.navigationService.scaffoldkey,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.playlists,
              style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        endDrawer: new FluttifyDrawer(),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: !model.isLoading
                ? RefreshIndicator(
                    color: Theme.of(context).primaryColor,
                    onRefresh: () async {
                      model.refreshPlaylists();
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: MediaQuery.of(context).size.height,
                        child: model.playlistService.myplaylists.isNotEmpty ||
                                model.playlistService.contributed.isNotEmpty
                            ? SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    model.playlistService.myplaylists.isEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 10, 0, 10),
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .created,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                              ),
                                              for (Playlist playlist in model
                                                  .playlistService
                                                  .myplaylists
                                                  .reversed)
                                                AnimationConfiguration
                                                    .synchronized(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  child: SlideAnimation(
                                                    horizontalOffset: 250.0,
                                                    child: FadeInAnimation(
                                                      child: PlaylistCard(
                                                        model: model,
                                                        playlist: playlist,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                    model.playlistService.contributed.isEmpty
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 10, 0, 10),
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .joined,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                              ),
                                              for (Playlist playlist in model
                                                  .playlistService
                                                  .contributed
                                                  .reversed)
                                                AnimationConfiguration
                                                    .synchronized(
                                                  duration: const Duration(
                                                      milliseconds: 600),
                                                  child: SlideAnimation(
                                                    horizontalOffset: 250.0,
                                                    child: FadeInAnimation(
                                                      child: PlaylistCard(
                                                        model: model,
                                                        playlist: playlist,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                  ],
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .nothinghere,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                .createplaylists1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        Icon(Icons.add_outlined,
                                            color:
                                                Theme.of(context).accentColor),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .createplaylists2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1)
                                      ],
                                    ),
                                  ],
                                ))),
                  )
                : Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
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
