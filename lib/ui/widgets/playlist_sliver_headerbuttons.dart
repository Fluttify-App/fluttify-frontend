import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttify/ui/widgets/sliver_header_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaylistSliverHeaderButtons extends StatefulWidget {
  final bool? show;
  final EditPlaylistViewModel? model;
  final double? top;
  final Function? onScroll;
  PlaylistSliverHeaderButtons({this.show, this.model, this.top, this.onScroll});

  @override
  State createState() => new PlaylistSliverHeaderButtonsState();
}

class PlaylistSliverHeaderButtonsState
    extends State<PlaylistSliverHeaderButtons> with TickerProviderStateMixin {
  final double size = 60;

  @override
  Widget build(BuildContext context) {
    final double slivearButtonWidth =
        ((MediaQuery.of(context).size.width - 20) / 3) - 50;
    return widget.show!
        ? Positioned(
            //top: expandedHeight! - shrinkOffset! - size / 2,
            top: widget.top,
            left: 10,
            right: 10,
            child: Visibility(
              visible: true,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SliverHeaderButton(
                    text: AppLocalizations.of(context)!.spotify,
                    color: Theme.of(context).cardColor,
                    width: slivearButtonWidth,
                    icon: Icon(Icons.link,
                        size: 15, color: Theme.of(context).accentColor),
                    onPressed: () {
                      launch(widget.model!.playlist!.href!);
                    },
                    border: BorderSide(width: 1, color: Colors.white),
                  ),
                  widget.model!.playlist!.creator! ==
                          widget.model!.authService.currentUser.id
                      ? SliverHeaderButton(
                          color: Theme.of(context).cardColor,
                          text: AppLocalizations.of(context)!.inviteplaylist,
                          width: slivearButtonWidth,
                          icon: Icon(Icons.share,
                              size: 15, color: Theme.of(context).accentColor),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .inviteplaylist,
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(children: <Widget>[
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .invitepopup,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SliverHeaderButton(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .inviteLink,
                                                    width: 90,
                                                    icon: Icon(Icons.link,
                                                        size: 15,
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      widget.model!.pressShare(
                                                          context,
                                                          widget.model!
                                                              .playlist!.dbID!);
                                                    }),
                                                SliverHeaderButton(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  width: 90,
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .qrCodeGenerate,
                                                  icon: Icon(Icons.qr_code,
                                                      size: 15,
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                  onPressed: () => {
                                                    Navigator.of(context).pop(),
                                                    widget.model!
                                                        .createQrCode(context),
                                                    widget.model!
                                                        .navigateToQrCodeImageView(
                                                            widget.model!
                                                                .playlist!)
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  );
                                });
                          },
                          border: BorderSide(width: 1, color: Colors.white))
                      : Container(),
                  !widget.model!.playlist!.canEdit
                      ? !widget.model!.communityview!
                          ? !widget.model!.playlist!.contributers!.contains(
                                  widget.model!.authService.currentUser.id)
                              ? SliverHeaderButton(
                                  color: Theme.of(context).cardColor,
                                  text: AppLocalizations.of(context)!
                                      .joinplaylist,
                                  icon: Icon(Icons.logout, size: 15),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  border:
                                      BorderSide(width: 1, color: Colors.white),
                                  width: slivearButtonWidth,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text(
                                            AppLocalizations.of(context)!
                                                .joinplaylist,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .joinplaylistcheck +
                                                      widget.model!.playlist!
                                                          .name! +
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
                                                onPressed: () => widget.model!
                                                    .navigateBack(context),
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .no,
                                                //color: Theme.of(context).cardColor,
                                                width: 80,
                                                height: 35),
                                            FluttifyButton(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                                onPressed: () => {
                                                      widget.model!
                                                          .joinPlaylist(
                                                              context),
                                                      widget.model!
                                                          .navigateBack(
                                                              context),
                                                    },
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .yes,
                                                width: 80,
                                                height: 35),
                                          ],
                                        );
                                      },
                                    );
                                  })

                              //LEAVE BUTTON
                              : SliverHeaderButton(
                                  color: Theme.of(context).errorColor,
                                  text: AppLocalizations.of(context)!
                                      .leaveplaylist,
                                  icon: Icon(Icons.logout, size: 15),
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
                                  border:
                                      BorderSide(width: 1, color: Colors.white),
                                  width: slivearButtonWidth,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text(
                                            AppLocalizations.of(context)!
                                                .leaveplaylist,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)!
                                                          .leaveplaylistcheck +
                                                      widget.model!.playlist!
                                                          .name! +
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
                                                onPressed: () => widget.model!
                                                    .navigateBack(context),
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .no,
                                                width: 80,
                                                height: 35),
                                            FluttifyButton(
                                                onPressed: () => {
                                                      widget.model!
                                                          .leavePlaylist(
                                                              context),
                                                      widget.model!
                                                          .navigateBack(context)
                                                    },
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .yes,
                                                width: 80,
                                                height: 35),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                )
                          : (!widget.model!.playlist!.likes!.contains(
                                  widget.model!.authService.currentUser.id))
                              ?
                              // LIKE BUTTON
                              SliverHeaderButton(
                                  icon: Icon(Icons.favorite_border, size: 15),
                                  text: AppLocalizations.of(context)!
                                      .likeplaylist,
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
                                  color: Theme.of(context).indicatorColor,
                                  onPressed: () {
                                    widget.model!.likePlaylist(context);
                                  },
                                )
                              : //UNLIKE BUTTON
                              SliverHeaderButton(
                                  icon: Icon(Icons.favorite, size: 15),
                                  text: AppLocalizations.of(context)!
                                      .unlikeplaylist,
                                  color: Theme.of(context).errorColor,
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle2,
                                  onPressed: () {
                                    widget.model!.unlikePlaylist(context);
                                  },
                                )
                      : Container(),
                ],
              ),
            ),
          )
        : Container();
  }
}
