import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/community_views/community_view/community_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';

class CommunityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityViewModel>.reactive(
      onModelReady: (viewModel) => viewModel.refreshCommunityPlaylists(),
      builder:
          (BuildContext context, CommunityViewModel model, Widget? child) =>
              Scaffold(
        appBar: AppBar(
          title:
              Text("Playlists", style: Theme.of(context).textTheme.headline1),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: !model.isLoading
                ? FractionallySizedBox(
                    widthFactor: 0.95,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        model.refreshCommunityPlaylists();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              for (Playlist playlist in model
                                  .playlistService.communityplaylists.reversed)
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: GestureDetector(
                                    onTap: () =>
                                        {model.navigateToEditPage(playlist)},
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  height: 60,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      180,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: EdgeInsets.fromLTRB(
                                                      25, 20, 0, 10),
                                                  child: playlist
                                                              .name!.length >=
                                                          20
                                                      ? ScrollingText(
                                                          text: playlist.name!,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1)
                                                      : Text(
                                                          playlist.name!,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1,
                                                        ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      25, 0, 0, 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        playlist
                                                            .displayContributers![
                                                                0]["name"]
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      Text(
                                                        playlist.contributers!
                                                                    .length ==
                                                                1
                                                            ? '1 Contributer'
                                                            : playlist
                                                                    .contributers!
                                                                    .length
                                                                    .toString() +
                                                                " Contributers",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      ),
                                                      Text(
                                                        playlist.likes!
                                                                    .length ==
                                                                1
                                                            ? '1 Like'
                                                            : playlist.likes!
                                                                    .length
                                                                    .toString() +
                                                                ' Likes',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              playlist.image == null
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
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        child: Image.network(
                                                            playlist.image!),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
      viewModelBuilder: () => CommunityViewModel(),
    );
  }
}
