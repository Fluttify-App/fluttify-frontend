import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FluttifyButton(
                color: Theme.of(context).cardColor,
                text: "Back",
                icon: Icon(Icons.arrow_back),
                border: BorderSide(width: 2, color: Colors.white),
                width: ((MediaQuery.of(context).size.width - 20) / 3) - 20,
                onPressed: () {
                  model!.navigateBack(context);
                }),
            model!.playlist!.creator! == model!.authService.currentUser.id
                ? FluttifyButton(
                    color: Theme.of(context).cardColor,
                    text: "Edit",
                    width: ((MediaQuery.of(context).size.width - 20) / 3) - 20,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      model!.pressShare(model!.playlist!.dbID!);
                    },
                    border: BorderSide(width: 2, color: Colors.white))
                : Container(),
            !model!.playlist!.canEdit
                ? !model!.communityview!
                    ? !model!.playlist!.contributers!
                            .contains(model!.authService.currentUser.id)
                        ? FluttifyButton(
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)!.joinplaylist,
                            icon: Icon(Icons.logout, size: 15),
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            border: BorderSide(width: 2, color: Colors.white),
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
                                      FluttifyButton(
                                          onPressed: () =>
                                              model!.navigateBack(context),
                                          text:
                                              AppLocalizations.of(context)!.no,
                                          width: 80,
                                          height: 35),
                                      FluttifyButton(
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
                        : FluttifyButton(
                            color: Theme.of(context).cardColor,
                            text: AppLocalizations.of(context)!.leaveplaylist,
                            icon: Icon(Icons.logout, size: 15),
                            textStyle: Theme.of(context).textTheme.bodyText1,
                            border: BorderSide(width: 2, color: Colors.white),
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
                                      FluttifyButton(
                                          onPressed: () =>
                                              model!.navigateBack(context),
                                          text:
                                              AppLocalizations.of(context)!.no,
                                          width: 80,
                                          height: 35),
                                      FluttifyButton(
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
                        TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.share),
                                const SizedBox(width: 12),
                                Text(AppLocalizations.of(context)!.likeplaylist,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ],
                            ),
                            onPressed: () {
                              model!.likePlaylist(context);
                            },
                          )
                        : //UNLIKE BUTTON
                        TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.share),
                                const SizedBox(width: 12),
                                Text(
                                    AppLocalizations.of(context)!
                                        .unlikeplaylist,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                              ],
                            ),
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
