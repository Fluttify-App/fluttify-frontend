import 'package:fluttify/models/song.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_bottom_sheet_field.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_chip_display.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_list_type.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class EditPlaylistView extends StatelessWidget {
  const EditPlaylistView({required this.playlistId});
  final String playlistId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (EditPlaylistViewModel model) {
          model.getPlaylist(playlistId);
        },
        builder: (BuildContext context, EditPlaylistViewModel model,
                Widget? child) =>
            model.playlist != null
                ? Scaffold(
                    appBar: AppBar(
                      // back button is only visible when you're not editing the playlist
                      automaticallyImplyLeading: !model.playlist!.canEdit,
                      actions: [
                        !model.playlist!.canEdit &&
                                model.playlist!.creator ==
                                    model.authService.currentUser.id
                            ? Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: GestureDetector(
                                  child: Icon(Icons.edit),
                                  onTap: () => {
                                    model.canEdit(),
                                  },
                                ),
                              )
                            : Container()
                      ],
                      title: model.playlist!.canEdit
                          ? TextField(
                              inputFormatters: [
                                  LengthLimitingTextInputFormatter(13),
                                ],
                              controller: model.nameController,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline1)
                          : Text(model.playlist!.name!,
                              style: Theme.of(context).textTheme.bodyText1),
                      centerTitle: true,
                      titleTextStyle: Theme.of(context).textTheme.headline1,
                    ),
                    body: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              if (model.playlist!.image == null)
                                Container(
                                  height: 150,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.music_note,
                                    size: 50,
                                  ),
                                )
                              else
                                Container(
                                    height: 250,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 9,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ]),
                                    child: GestureDetector(
                                      onTap: () {
                                        launch(model.playlist!.href!);
                                      },
                                      child: Stack(children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.network(
                                              model.playlist!.image!),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(Icons.launch),
                                        )
                                      ]),
                                    )),
                              Container(
                                padding: EdgeInsets.fromLTRB(25, 40, 0, 15),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text("Beschreibung"),
                                  style: Theme.of(context).textTheme.bodyText1!,
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Container(
                                    padding: EdgeInsets.all(13),
                                    alignment: Alignment.centerLeft,
                                    child: model.playlist!.canEdit
                                        ? TextField(
                                            controller:
                                                model.descriptionController,
                                            maxLines: null)
                                        : Text(model.playlist!.description!),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
                                alignment: Alignment.centerLeft,
                                child: DefaultTextStyle(
                                  child: Text("Genres"),
                                  style: Theme.of(context).textTheme.bodyText1!,
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: FractionallySizedBox(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          MultiSelectBottomSheetField(
                                            canEdit: model.playlist!.canEdit,
                                            decoration: BoxDecoration(),
                                            initialValue:
                                                model.playlist!.genres,
                                            initialChildSize: 0.4,
                                            listType: MultiSelectListType.CHIP,
                                            selectedItemsTextStyle:
                                                Theme.of(context)
                                                    .textTheme
                                                    .button,
                                            selectedColor:
                                                Theme.of(context).accentColor,
                                            itemsTextStyle: Theme.of(context)
                                                .textTheme
                                                .button,
                                            searchable: true,
                                            buttonText: Text("Genres",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2),
                                            title: Text("Genres",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                            items: model.playlistGenre!,
                                            onConfirm: (values) {
                                              model.addGenre(values);
                                            },
                                            chipDisplay: MultiSelectChipDisplay(
                                              chipColor:
                                                  Theme.of(context).accentColor,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                              onTap: (String value) =>
                                                  model.removeGenre(value),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              model.playlist!.canEdit
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              25, 25, 0, 15),
                                          alignment: Alignment.topLeft,
                                          child: DefaultTextStyle(
                                            child: Text("Contributors"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 25, 25, 15),
                                            icon: Icon(
                                              Icons.share,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              model.pressShare(
                                                  model.playlist!.dbID!);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      padding:
                                          EdgeInsets.fromLTRB(25, 25, 0, 15),
                                      alignment: Alignment.topLeft,
                                      child: DefaultTextStyle(
                                        child: Text("Contributors"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!,
                                      ),
                                    ),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: [
                                      for (dynamic contributers in model
                                          .playlist!.displayContributers!)
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 5, 0, 5),
                                          child: Card(
                                            color:
                                                Theme.of(context).accentColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  12, 5, 12, 5),
                                              child: Text(contributers['name'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              model.playlist!.canEdit
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: SizedBox(
                                              height: 45,
                                              width: 100,
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .accentColor,
                                                      shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent))),
                                                  child: Text('Cancel',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1),
                                                  onPressed: () =>
                                                      model.canEdit()),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: SizedBox(
                                              height: 45,
                                              width: 100,
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .accentColor,
                                                      shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent))),
                                                  child: Text('Save',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1),
                                                  onPressed: () =>
                                                      model.save(context)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              if (!model.playlist!.canEdit)
                                Column(
                                  children: [
                                    Divider(
                                      color: Theme.of(context).dividerColor,
                                      height: 50,
                                    ),
                                    Container(
                                      child: FractionallySizedBox(
                                        widthFactor: 0.95,
                                        child: Column(
                                          children: [
                                            for (Song song
                                                in model.playlist!.songs!)
                                              GestureDetector(
                                                onTap: () {
                                                  launch(song.link!);
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          25,
                                                                          10,
                                                                          0,
                                                                          10),
                                                              child: Text(
                                                                song.name!,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          25,
                                                                          0,
                                                                          0,
                                                                          10),
                                                              child: Text(
                                                                song.artist!,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      song.image == null
                                                          ? Container(
                                                              height: 50,
                                                              width: 50,
                                                              child: Icon(
                                                                Icons
                                                                    .music_note,
                                                                size: 30,
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 75,
                                                              width: 75,
                                                              child: ClipRRect(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10)),
                                                                  child: ClipRRect(
                                                                      child: Image
                                                                          .network(
                                                                              song.image!))),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            (model.playlist!.contributers!
                                                    .contains(model.authService
                                                        .currentUser.id))
                                                ? TextButton(
                                                    child: Text("Leave"),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Delete Playlist'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      'Would you like to leave playlist: ${model.playlist!.name}'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'No'),
                                                                onPressed: () {
                                                                  model.navigateBack(
                                                                      context);
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                                onPressed: () {
                                                                  model.leavePlaylist(
                                                                      context);
                                                                  model.navigateBack(
                                                                      context);
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    })
                                                : TextButton(
                                                    child: Text("Join"),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Delete Playlist'),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: ListBody(
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                      'Would you like to join playlist: ${model.playlist!.name}'),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'No'),
                                                                onPressed: () {
                                                                  model.navigateBack(
                                                                      context);
                                                                },
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Yes'),
                                                                onPressed: () {
                                                                  model.joinPlaylist(
                                                                      context);

                                                                  model.navigateBack(
                                                                      context);
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Scaffold(
                    appBar: AppBar(),
                    body: Center(child: CircularProgressIndicator())),
        viewModelBuilder: () => EditPlaylistViewModel());
  }
}
