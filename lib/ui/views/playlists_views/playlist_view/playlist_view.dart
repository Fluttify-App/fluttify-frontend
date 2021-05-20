import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/add_playlist_views/add_playlist_view.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaylistViewModel>.reactive(
      builder: (BuildContext context, PlaylistViewModel model, Widget child) =>
          Scaffold(
        appBar: AppBar(
          title: Text("Playlists"),
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
                ? FractionallySizedBox(
                    widthFactor: 0.95,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          for (Playlist playlist in model.playlists)
                            GestureDetector(
                              onTap: () => {model.navigateToEditPage(playlist)},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      25, 20, 0, 10),
                                                  // TODO: refresh page to see changes instant
                                                  child: Text(
                                                    playlist.name,
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style
                                                        .apply(
                                                            fontSizeFactor:
                                                                1.8),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              25, 0, 0, 20),
                                                      child: Text(
                                                        playlist.numberOfSongs
                                                                .toString() +
                                                            ' Songs',
                                                        style: DefaultTextStyle
                                                                .of(context)
                                                            .style
                                                            .apply(
                                                                fontSizeFactor:
                                                                    1.3),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: IconButton(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 5, 0),
                                              icon: Icon(
                                                Icons.share,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          playlist.image == null
                                              ? Container(
                                                  height: 100, width: 100)
                                              : Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            playlist.image),
                                                        fit: BoxFit.contain),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: gradientColor_1,
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
