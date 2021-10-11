import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/playlist_sliver_headerbuttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlaylistSliverAppBar extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final EditPlaylistViewModel? model;

  const PlaylistSliverAppBar(
      {@required this.expandedHeight, @required this.model});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 60;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        if (!model!.playlist!.canEdit)
          buildBackground(
              shrinkOffset,
              model!.playlist!.image ??
                  "https://www.import.io/wp-content/uploads/2018/08/Screen-Shot-2018-08-20-at-11.16.18-AM-300x235.png"),
        buildAppBar(shrinkOffset, model!.playlist!.name, context),
        if (!model!.playlist!.canEdit)
          PlaylistSliverHeaderButtons(
              model: model,
              show: !model!.showHeader!,
              top: expandedHeight! - shrinkOffset - size / 2),
        buildOverlayContainer(shrinkOffset, context),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight!;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight!;

  Widget buildAppBar(double shrinkOffset, title, context) => Opacity(
        opacity: model!.playlist!.canEdit ? 1 : appear(shrinkOffset),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: !model!.playlist!.canEdit
              ? Text(model!.playlist!.name!,
                  style: Theme.of(context).textTheme.headline2)
              : Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
                      ],
                      controller: model!.nameController,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2),
                ),
          centerTitle: true,
        ),
      );

  Widget buildOverlayContainer(double shrinkOffset, BuildContext context) =>
      Positioned(
        right: 10,
        top: 35,
        left: 10,
        child: // Opacity(
            //opacity: appear(shrinkOffset),
            // child:
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              MaterialButton(
                minWidth: 10,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.comfortable,
                onPressed: () {
                  if (model!.playlist!.canEdit) {
                    model!.canEdit();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                elevation: 0.0,
                color: !model!.showHeader! && !model!.playlist!.canEdit
                    ? Colors.black.withOpacity(0.5)
                    : Theme.of(context).primaryColor,
                child: Icon(Icons.chevron_left, color: Colors.white, size: 25),
                padding: const EdgeInsets.all(10.0),
                shape: CircleBorder(),
              ),
              if (model!.playlist!.creator == model!.authService.currentUser.id)
                !model!.playlist!.canEdit
                    ? MaterialButton(
                        minWidth: 10,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.comfortable,
                        onPressed: () {
                          model!.canEdit();
                        },
                        elevation: 0.0,
                        color: !model!.showHeader! && !model!.playlist!.canEdit
                            ? Colors.black.withOpacity(0.5)
                            : Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      )
                    : MaterialButton(
                        minWidth: 10,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.comfortable,
                        onPressed: model!.selectedGenres.length != 0 &&
                                model!.nameController.text.isNotEmpty
                            ? () => model!.save(context)
                            : null, //
                        elevation: 0.0,
                        color: !model!.showHeader! && !model!.playlist!.canEdit
                            ? Colors.black.withOpacity(0.5)
                            : Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.save,
                            color: model!.selectedGenres.length != 0 &&
                                    model!.nameController.text.isNotEmpty
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            size: 20.0,
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      )
            ]),
      );

  Widget buildBackground(double shrinkOffset, String image) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Hero(
            tag: model!.playlist!.name!,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  @override
  double get maxExtent =>
      !model!.playlist!.canEdit ? expandedHeight! : minExtent;

  @override
  double get minExtent => kToolbarHeight + 30; // 56

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
