import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/views/community_views/community_view/community_viewmodel.dart';
import 'package:fluttify/ui/widgets/community_playlist_card.dart';
import 'package:fluttify/ui/widgets/fluttify_drawer.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommunityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.refreshCommunityPlaylists(),
      builder:
          (BuildContext context, CommunityViewModel model, Widget? child) =>
              Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.community,
              style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        key: model.navigationService.scaffoldkey,
        endDrawer: new FluttifyDrawer(),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: !model.isLoading
                ? RefreshIndicator(
                    onRefresh: () async {
                      model.refreshCommunityPlaylists();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            model.playlistService.communitylikedplaylists
                                    .isEmpty
                                ? Container()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 10, 0, 10),
                                        child: Text(
                                            AppLocalizations.of(context)!.liked,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
                                      ),
                                      for (Playlist playlist in model
                                          .playlistService
                                          .communitylikedplaylists
                                          .reversed)
                                        AnimationConfiguration.synchronized(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          child: SlideAnimation(
                                            horizontalOffset: 250.0,
                                            child: FadeInAnimation(
                                              child: CommunityPlaylistCard(
                                                model: model,
                                                playlist: playlist,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                            model.playlistService.communityplaylists.isEmpty
                                ? Container()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 10, 0, 10),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .morecommunity,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4),
                                      ),
                                      for (Playlist playlist in model
                                          .playlistService
                                          .communityplaylists
                                          .reversed)
                                        AnimationConfiguration.synchronized(
                                          duration:
                                              const Duration(milliseconds: 600),
                                          child: SlideAnimation(
                                            horizontalOffset: 250.0,
                                            child: FadeInAnimation(
                                              child: CommunityPlaylistCard(
                                                model: model,
                                                playlist: playlist,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor),
                  ),
          ),
        ),
      ),
      viewModelBuilder: () => CommunityViewModel(),
    );
  }
}
