import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/song.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class SongCard extends StatelessWidget {
  final Song song;

  SongCard({required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(song.link!);
      },
      child: Card(
        margin: const EdgeInsets.only(left: 0, right: 0, bottom: 8),
        /*
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            */
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  Expanded(
            //  child:
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 22,
                    width: MediaQuery.of(context).size.width - 110,
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 5),
                    child: LayoutBuilder(
                      builder: (_, constraints) => (TextPainter(
                                textDirection: ui.TextDirection.ltr,
                                text: TextSpan(text: song.name!),
                                maxLines: 1,
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                              )..layout())
                                  .size >=
                              Offset(constraints.widthConstraints().minWidth, 0)
                          ? ScrollingText(
                              text: song.name!,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.w600))
                          : Text(
                              song.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Text(
                      song.artist!,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),

            // ),
            song.image == null
                ? SizedBox(
                    height: 75,
                    width: 75,
                    child: Icon(
                      Icons.music_note,
                      size: 30,
                    ),
                  )
                : SizedBox(
                    height: 75,
                    width: 75,
                    child: ClipRRect(
                      child: Image.network(song.image!),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
