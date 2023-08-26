import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/views/community_views/community_view/community_viewmodel.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommunityPlaylistCard extends StatelessWidget {
  final CommunityViewModel? model;
  final Playlist? playlist;

  CommunityPlaylistCard({required this.model, required this.playlist});

  String? getCreator() {
    String? creatorName;
    this.playlist!.displayContributers!.forEach((element) {
      if (element['id'] == playlist!.creator) creatorName = element['name'];
    });
    return creatorName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: GestureDetector(
        onTap: () => {model!.navigateToEditPage(playlist!)},
        child: Card(
          margin: const EdgeInsets.all(0),
          /*
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              */
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 180,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: playlist!.name!.length >= 20
                            ? ScrollingText(
                                text: playlist!.name!,
                                textStyle:
                                    Theme.of(context).textTheme.headline5)
                            : Text(
                                playlist!.name!,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getCreator()!,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Text(
                              playlist!.contributers!.length == 1
                                  ? '1 ' +
                                      AppLocalizations.of(context)!.contributor
                                  : playlist!.contributers!.length.toString() +
                                      ' ' +
                                      AppLocalizations.of(context)!
                                          .contributors,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Text(
                              playlist!.likes!.length == 1
                                  ? '1 ' + AppLocalizations.of(context)!.like
                                  : playlist!.likes!.length.toString() +
                                      ' ' +
                                      AppLocalizations.of(context)!.likes,
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  playlist!.image == null
                      ? Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.fromLTRB(0, 8, 20, 8),
                          child: Icon(
                            Icons.music_note,
                            size: 30,
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.fromLTRB(0, 8, 20, 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Hero(
                                tag: playlist!.id!,
                                child: Image.network(playlist!.image!)),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
