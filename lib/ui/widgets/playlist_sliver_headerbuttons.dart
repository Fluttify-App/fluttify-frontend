import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttify/ui/widgets/sliver_header_button.dart';

class PlaylistSliverHeaderButtons extends StatelessWidget {
  final bool? show;
  final EditPlaylistViewModel? model;
  final double? top;

  const PlaylistSliverHeaderButtons(
      {@required this.show, @required this.model, @required this.top});

  final double size = 60;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      //top: expandedHeight! - shrinkOffset! - size / 2,
      top: top,
      left: 10,
      right: 10,
      child: Visibility(
        visible: show!,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            model!.playlist!.creator! == model!.authService.currentUser.id
                ? SliverHeaderButton(
                    color: Theme.of(context).cardColor,
                    text: AppLocalizations.of(context)!.inviteplaylist,
                    icon: Icon(Icons.share,
                        size: 15, color: Theme.of(context).accentColor),
                    onPressed: () {
                      model!.pressShare(model!.playlist!.dbID!);
                    },
                    border: BorderSide(width: 1, color: Colors.white))
                : Container(),
            !model!.playlist!.canEdit
                ? !model!.communityview!
                    ? !model!.playlist!.contributers!
                            .contains(model!.authService.currentUser.id)
                        ? SliverHeaderButton(
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)!.joinplaylist,
                            icon: Icon(Icons.logout, size: 15),
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            border: BorderSide(width: 1, color: Colors.white),
                            width:
                                ((MediaQuery.of(context).size.width - 20) / 3) -
                                    20,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .joinplaylist,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)!
                                                    .joinplaylistcheck +
                                                model!.playlist!.name! +
                                                '?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      SliverHeaderButton(
                                          onPressed: () =>
                                              model!.navigateBack(context),
                                          text:
                                              AppLocalizations.of(context)!.no,
                                          width: 80,
                                          height: 35),
                                      SliverHeaderButton(
                                          onPressed: () => {
                                                model!.joinPlaylist(context),
                                                model!.navigateBack(context),
                                              },
                                          text:
                                              AppLocalizations.of(context)!.yes,
                                          width: 80,
                                          height: 35),
                                    ],
                                  );
                                },
                              );
                            })
                        : SliverHeaderButton(
                            color: Theme.of(context).errorColor,
                            text: AppLocalizations.of(context)!.leaveplaylist,
                            icon: Icon(Icons.logout, size: 15),
                            textStyle: Theme.of(context).textTheme.subtitle2,
                            border: BorderSide(width: 1, color: Colors.white),
                            width:
                                ((MediaQuery.of(context).size.width - 20) / 3) -
                                    20,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .leaveplaylist,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)!
                                                    .leaveplaylistcheck +
                                                model!.playlist!.name! +
                                                '?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      SliverHeaderButton(
                                          onPressed: () =>
                                              model!.navigateBack(context),
                                          text:
                                              AppLocalizations.of(context)!.no,
                                          width: 80,
                                          height: 35),
                                      SliverHeaderButton(
                                          onPressed: () => {
                                                model!.leavePlaylist(context),
                                                model!.navigateBack(context)
                                              },
                                          text:
                                              AppLocalizations.of(context)!.yes,
                                          width: 80,
                                          height: 35),
                                    ],
                                  );
                                },
                              );
                            })
                    : (!model!.playlist!.likes!
                            .contains(model!.authService.currentUser.id))
                        ?
                        // LIKE BUTTON
                        SliverHeaderButton(
                            icon: Icon(Icons.favorite_border, size: 15),
                            text: AppLocalizations.of(context)!.likeplaylist,
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            color: Theme.of(context).indicatorColor,
                            onPressed: () {
                              model!.likePlaylist(context);
                            },
                          )
                        : //UNLIKE BUTTON
                        SliverHeaderButton(
                            icon: Icon(Icons.favorite, size: 15),
                            text: AppLocalizations.of(context)!.unlikeplaylist,
                            color: Theme.of(context).errorColor,
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            onPressed: () {
                              model!.unlikePlaylist(context);
                            },
                          )
                : Container(),
          ],
        ),
      ),
    );
  }
}
