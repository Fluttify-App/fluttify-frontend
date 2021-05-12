import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlaylistViewModel>.reactive(
      builder: (BuildContext context, PlaylistViewModel model, Widget child) =>
          Scaffold(
        appBar: AppBar(
          title: Text("Playlists"),
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          centerTitle: true,
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
                                return _PlaylistCardView(
                                    playlist: playlist, model: model);
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
                                                  "100 Songs",
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
                                      scale: 0.5,
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

class _PlaylistCardView extends StatelessWidget {
  const _PlaylistCardView({
    this.onTap,
    @required this.model,
    @required this.playlist,
  });

  final GestureTapCallback onTap;
  final Playlist playlist;
  final PlaylistViewModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
        backgroundColor: Color.fromARGB(255, 60, 60, 60),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          child: Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(playlist.image)),
            ),
          ),
        ),
      ),
    );
  }
}
