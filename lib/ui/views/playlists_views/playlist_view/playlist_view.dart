import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';

class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaylistViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.refreshPlaylists(),
      builder: (BuildContext context, PlaylistViewModel model, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          title:
              Text("Playlists", style: Theme.of(context).textTheme.headline1),
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
                            children: [
                              for (Playlist playlist
                                  in model.playlistService.myplaylists.reversed)
                                Dismissible(
                                  key: Key(playlist.dbID!),
                                  confirmDismiss: (direction) async {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text('Delete Playlist'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    'Would you like to delete playlist: ${playlist.name}'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('No'),
                                              onPressed: () {
                                                model.navigateBack(context);
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Yes'),
                                              onPressed: () {
                                                model.dismissPlaylist(
                                                    playlist, context);
                                                model.navigateBack(context);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  background: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.redAccent,
                                    ),
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.all(16.0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 22.0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                  direction: DismissDirection.endToStart,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: GestureDetector(
                                      onTap: () =>
                                          {model.navigateToEditPage(playlist)},
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height: 60,
                                                    width: MediaQuery.of(context).size.width - 180,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            25, 20, 0, 10),
                                                    child: playlist
                                                                .name!.length >=
                                                            20
                                                        ? ScrollingText(
                                                            text:
                                                                playlist.name!,
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1)
                                                        : Text(
                                                            playlist.name!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline1,
                                                          ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            25, 0, 0, 20),
                                                    child: Text(
                                                      playlist.numberOfSongs
                                                              .toString() +
                                                          ' Songs',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: IconButton(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 5, 0),
                                                    icon: Icon(
                                                      Icons.share,
                                                    ),
                                                    onPressed: () {
                                                      model.pressShare(
                                                          playlist.dbID!);
                                                    },
                                                  ),
                                                ),
                                                playlist.image == null
                                                    ? Container(
                                                        height: 100,
                                                        width: 100,
                                                        child: Icon(
                                                          Icons.music_note,
                                                          size: 30,
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 100,
                                                        width: 100,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          10)),
                                                          child: Image.network(
                                                              playlist.image!),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
