import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_viewmodel.dart';
import 'package:fluttify/ui/views/edit_playlist_views/edit_playlist_view.dart';
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
            child: FractionallySizedBox(
              widthFactor: 0.95,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    for (Playlist playlist in model.playlists)
                      GestureDetector(
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return EditPlaylistView(playlist: playlist);
                              },
                            ),
                          ),
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            child: Text(
                                              playlist.name,
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style
                                                      .apply(
                                                          fontSizeFactor: 2.0),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    25, 0, 0, 20),
                                                child: Text(
                                                  playlist.numberOfSongs
                                                          .toString() +
                                                      ' Songs',
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style
                                                      .apply(
                                                          fontSizeFactor: 1.3),
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
                              Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  padding:
                                      const EdgeInsets.fromLTRB(60, 0, 0, 0),
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(playlist.image),
                                      fit: BoxFit.contain),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => PlaylistViewModel(),
    );
  }
}