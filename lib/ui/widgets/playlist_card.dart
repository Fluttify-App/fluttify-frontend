import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_view/playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';

class PlaylistCard extends StatelessWidget {
  PlaylistViewModel? model;
  Playlist? playlist;
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
                'Delete Playlist',
                style: Theme.of(context).textTheme.headline1,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Would you like to delete playlist: ${playlist!.name}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FluttifyButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: 'No',
                    width: 80,
                    height: 35),
                FluttifyButton(
                    onPressed: () => {
                          model!.dismissPlaylist(playlist!, context),
                          model!.navigateBack(context),
                        },
                    text: 'Yes',
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
        margin: EdgeInsets.all(16.0),
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
                borderRadius: BorderRadius.circular(10.0)),
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
                                textStyle:
                                    Theme.of(context).textTheme.headline1)
                            : Text(
                                playlist!.name!,
                                style: Theme.of(context).textTheme.headline1,
                              ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
                        child: Text(
                          playlist!.numberOfSongs.toString() + ' Songs',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: IconButton(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        icon: Icon(
                          Icons.share,
                        ),
                        onPressed: () {
                          model!.pressShare(playlist!.dbID!);
                        },
                      ),
                    ),
                    playlist!.image == null
                        ? Container(
                            height: 100,
                            width: 100,
                            child: Icon(
                              Icons.music_note,
                              size: 30,
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 100,
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
      ),
    );
  }
}
