import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
              alignment: Alignment.topLeft,
              child: Text(
                "Beschreibung",
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.95,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  padding: EdgeInsets.all(13),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    playlist.description,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Genres",
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.95,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: [
                    for (String genre in playlist.genres)
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                        child: Card(
                          color: Color.fromARGB(255, 94, 8, 28),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                            child: Text(
                              genre,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
             Container(
              padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
              alignment: Alignment.topLeft,
              child: Text(
                "Collaborators",
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.95,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: [
                    for (String collaborator in playlist.collaborators)
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                        child: Card(
                          color: Color.fromARGB(255, 94, 8, 28),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                            child: Text(
                              collaborator,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
