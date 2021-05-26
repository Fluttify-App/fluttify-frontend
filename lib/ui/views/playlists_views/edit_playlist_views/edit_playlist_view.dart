import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/models/song.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_bottom_sheet_field.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_chip_display.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_list_type.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class EditPlaylistView extends StatelessWidget {
  const EditPlaylistView({required this.playlistId});
  final String playlistId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (BuildContext context, EditPlaylistViewModel model,
                Widget? child) =>
            FutureBuilder<Playlist>(
              future: model.getPlaylist(playlistId),
              builder: (context, AsyncSnapshot<Playlist> playlistSnapshot) {
                if (playlistSnapshot.connectionState != ConnectionState.done ||
                    !playlistSnapshot.hasData) {
                  return Scaffold(
                      appBar: AppBar(),
                      body: Center(child: CircularProgressIndicator()));
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      // back button is only visible when you're not editing the playlist
                      automaticallyImplyLeading:
                          !playlistSnapshot.data!.canEdit,
                      actions: [
                        !playlistSnapshot.data!.canEdit
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
                      title: playlistSnapshot.data!.canEdit
                          ? TextField(
                              inputFormatters: [
                                  LengthLimitingTextInputFormatter(13),
                                ],
                              controller: model.nameController,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))
                          : Text(playlistSnapshot.data!.name!),
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                      centerTitle: true,
                      /*
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[fluttify_gradient_1, fluttify_gradient_2],
                      ),
                    ),
                  ),
                  */
                    ),
                    body: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              playlistSnapshot.data!.image == null
                                  ? Container(
                                      height: 150,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.music_note,
                                        size: 50,
                                      ),
                                    )
                                  : Container(
                                      // padding: EdgeInsets.fromLTRB(25, 40, 0, 15),
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
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 9,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ]),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Image.network(
                                            playlistSnapshot.data!.image!),
                                      )),
                              Container(
                                padding: EdgeInsets.fromLTRB(25, 40, 0, 15),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text("Beschreibung"),
                                  style: TextStyle(fontSize: 20),
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
                                    child: playlistSnapshot.data!.canEdit
                                        ? TextField(
                                            controller:
                                                model.descriptionController,
                                            maxLines: null)
                                        : Text(playlistSnapshot
                                            .data!.description!),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
                                alignment: Alignment.centerLeft,
                                child: DefaultTextStyle(
                                  child: Text("Genres"),
                                  style: TextStyle(fontSize: 20),
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
                                            canEdit:
                                                playlistSnapshot.data!.canEdit,
                                            decoration: BoxDecoration(),
                                            initialValue:
                                                playlistSnapshot.data!.genres,
                                            initialChildSize: 0.4,
                                            listType: MultiSelectListType.CHIP,
                                            selectedItemsTextStyle:
                                                TextStyle(color: Colors.white),
                                            selectedColor:
                                                Theme.of(context).primaryColor,
                                            itemsTextStyle:
                                                TextStyle(color: Colors.white),
                                            searchable: true,
                                            buttonText: Text("Genres",
                                                style: TextStyle(fontSize: 20)),
                                            title: Text("Genres",
                                                style: TextStyle(fontSize: 20)),
                                            items: model.playlistGenre!,
                                            onConfirm: (values) {
                                              model.addGenre(values);
                                            },
                                            chipDisplay: MultiSelectChipDisplay(
                                              chipColor: Theme.of(context)
                                                  .primaryColor,
                                              textStyle: TextStyle(
                                                  color: Colors.white),
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
                              playlistSnapshot.data!.canEdit
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
                                            style: TextStyle(fontSize: 20),
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
                                            onPressed: () {},
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
                                        style: TextStyle(fontSize: 20),
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
                                      for (String contributers
                                          in playlistSnapshot
                                              .data!.contributers!)
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 5, 0, 5),
                                          child: Card(
                                            color:
                                                Color.fromARGB(255, 94, 8, 28),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  12, 5, 12, 5),
                                              child: Text(
                                                contributers,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              playlistSnapshot.data!.canEdit
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
                                                              .primaryColor,
                                                      shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent))),
                                                  child: Text('Cancel',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white)),
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
                                                              .primaryColor,
                                                      shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent))),
                                                  child: Text('Save',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white)),
                                                  onPressed: () =>
                                                      model.save(context)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              !playlistSnapshot.data!.canEdit
                                  ? Column(
                                      children: [
                                        Divider(
                                            color:
                                                Theme.of(context).dividerColor,
                                            height: 50),
                                        Container(
                                          child: FractionallySizedBox(
                                            widthFactor: 0.95,
                                            child: Column(
                                              children: [
                                                for (Song song in model.songs!)
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10)),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image: DecorationImage(
                                                                          image: AssetImage(song
                                                                              .image!),
                                                                          fit: BoxFit
                                                                              .contain),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
        viewModelBuilder: () => EditPlaylistViewModel());
  }
}
