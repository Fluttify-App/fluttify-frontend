import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/views/community_views/community_view/community_viewmodel.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommunityPlaylistCard extends StatelessWidget {
  final CommunityViewModel? model;
  final Playlist? playlist;
  CommunityPlaylistCard({required this.model, required this.playlist, t});

  String? getCreator() {
    String? creatorName;
    playlist!.displayContributers!.forEach((element) {
      if (element['id'] == playlist!.creator) creatorName = element['name'];
    });
    return creatorName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () => {model!.navigateToEditPage(playlist!)},
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 180,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(25, 20, 0, 10),
                      child: playlist!.name!.length >= 20
                          ? ScrollingText(
                              text: playlist!.name!,
                              textStyle: Theme.of(context).textTheme.headline1)
                          : Text(
                              playlist!.name!,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getCreator() ?? playlist!.creator.toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            playlist!.contributers!.length == 1
                                ? '1 ' +
                                    AppLocalizations.of(context)!.contributor
                                : playlist!.contributers!.length.toString() +
                                    ' ' +
                                    AppLocalizations.of(context)!.contributors,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  playlist!.image == null
                      ? Container(
                          height: 130,
                          width: 130,
                          child: Icon(
                            Icons.music_note,
                            size: 30,
                          ),
                        )
                      : Container(
                          height: 130,
                          width: 130,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            child: Image.network(playlist!.image!),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
