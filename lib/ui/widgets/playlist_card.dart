import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaylistCard extends StatelessWidget {
  final PlaylistViewModel? model;
  final Playlist? playlist;
  PlaylistCard({required this.model, required this.playlist});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(playlist!.dbID!),
      confirmDismiss: (direction) async {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.deleteplaylist,
                style: Theme.of(context).textTheme.headline1,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.deleteplaylistcheck +
                          playlist!.name! +
                          "?",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FluttifyButton(
                    onPressed: () => model!.navigateBack(context),
                    text: AppLocalizations.of(context)!.no,
                    width: 80,
                    height: 35),
                FluttifyButton(
                    onPressed: () => {
                          model!.dismissPlaylist(playlist!, context),
                          model!.navigateBack(context),
                        },
                    text: AppLocalizations.of(context)!.yes,
                    width: 80,
                    height: 35),
              ],
            );
          },
        );
      },
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.redAccent,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Padding(
          padding: const EdgeInsets.only(right: 22.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.endToStart,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: GestureDetector(
          onTap: () => {model!.navigateToEditPage(playlist!)},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
                          child: Text(
                            playlist!.numberOfSongs.toString() +
                                " " +
                                AppLocalizations.of(context)!.songs,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
                          child: Text(
                            playlist!.contributers!.length == 1
                                ? '1 ' +
                                    AppLocalizations.of(context)!.contributor
                                : playlist!.contributers!.length.toString() +
                                    ' ' +
                                    AppLocalizations.of(context)!.contributors,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    if (playlist!.creator == model!.authService.currentUser.id)
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.person_add_alt_1,
                          ),
                          onPressed: () {
                            model!.pressShare(playlist!.dbID!);
                          },
                        ),
                      ),
                    if (playlist!.image == null)
                      Container(
                        height: 100,
                        width: 100,
                        child: Icon(
                          Icons.image,
                          size: 30,
                        ),
                      )
                    else
                      Container(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Hero(
                              tag: playlist!.id!,
                              child: Image.network(playlist!.image!)),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
