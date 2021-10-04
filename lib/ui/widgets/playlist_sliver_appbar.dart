import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/playlist_sliver_headerbuttons.dart';

class PlaylistSliverAppBar extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final EditPlaylistViewModel? model;

  const PlaylistSliverAppBar(
      {@required this.expandedHeight, @required this.model});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 60;
    //final top = expandedHeight! - size / 2;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        buildBackground(
            shrinkOffset,
            model!.playlist!.image ??
                "https://www.import.io/wp-content/uploads/2018/08/Screen-Shot-2018-08-20-at-11.16.18-AM-300x235.png"),
        buildAppBar(shrinkOffset, model!.playlist!.name, context),
        PlaylistSliverHeaderButtons(
            model: model,
            show: !model!.showHeader!,
            top: expandedHeight! - shrinkOffset - size / 2)
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight!;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight!;

  Widget buildAppBar(double shrinkOffset, title, context) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(title),
          centerTitle: true,
        ),
      );

  Widget buildBackground(double shrinkOffset, String image) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      );

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight + 40; // 56 + 40 = 96

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
