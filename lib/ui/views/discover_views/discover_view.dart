import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:fluttify/models/song.dart';
import 'package:fluttify/ui/views/discover_views/discover_viewmodel.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class DiscoverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscoverViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.refreshDiscoverSongs(),
      builder: (BuildContext context, DiscoverViewModel model, Widget? child) =>
          Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.discover,
              style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: FractionallySizedBox(
                widthFactor: 0.95,
                child: RefreshIndicator(
                  onRefresh: () async {
                    model.refreshDiscoverSongs();
                  },
                  child: Column(
                    children: [
                      Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (String genre in model.playlistGenres!)
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: InputChip(
                                      label: Text(genre),
                                      selected:
                                          model.selectedGenres.contains(genre),
                                      selectedColor: Colors.red,
                                      onSelected: (bool selected) {
                                        if (selected) {
                                          model.selectGenre(genre);
                                        } else {
                                          model.unselectGenre(genre);
                                        }
                                      }),
                                ),
                            ],
                          )),
                      !model.isLoading
                          ? Container(
                              //height: MediaQuery.of(context).size.height,
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    for (Song song
                                        in model.discoverService.discoverSongs)
                                      GestureDetector(
                                        onTap: () {
                                          launch(song.link!);
                                        },
                                        child: Column(
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              110,
                                                          padding: EdgeInsets
                                                              .fromLTRB(25, 10,
                                                                  0, 10),
                                                          child: LayoutBuilder(
                                                            builder: (_,
                                                                    constraints) =>
                                                                (TextPainter(
                                                                          textDirection: ui
                                                                              .TextDirection
                                                                              .ltr,
                                                                          text:
                                                                              TextSpan(text: song.name!),
                                                                          maxLines:
                                                                              1,
                                                                          textScaleFactor:
                                                                              MediaQuery.of(context).textScaleFactor,
                                                                        )
                                                                              ..layout())
                                                                            .size >=
                                                                        Offset(
                                                                            constraints
                                                                                .widthConstraints()
                                                                                .minWidth,
                                                                            0)
                                                                    ? ScrollingText(
                                                                        text: song
                                                                            .name!,
                                                                        textStyle: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2)
                                                                    : Text(
                                                                        song.name!,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .bodyText2,
                                                                      ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  25, 0, 0, 10),
                                                          child: Text(
                                                            song.artist!,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  song.image == null
                                                      ? Container(
                                                          height: 75,
                                                          width: 75,
                                                          child: Icon(
                                                            Icons.music_note,
                                                            size: 30,
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 75,
                                                          width: 75,
                                                          child: ClipRRect(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                              child: ClipRRect(
                                                                  child: Image
                                                                      .network(song
                                                                          .image!))),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                    ],
                  ),
                ),
              )),
        ),
      ),
      viewModelBuilder: () => DiscoverViewModel(),
    );
  }
}
