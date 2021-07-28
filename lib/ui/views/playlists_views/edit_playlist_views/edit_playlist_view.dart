import 'dart:ui' as ui;

import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/models/song.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_bottom_sheet_field.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_chip_display.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_list_type.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:instant/instant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditPlaylistView extends StatelessWidget {
  const EditPlaylistView({this.playlist, this.playlistId});
  final Playlist? playlist;
  final String? playlistId;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (EditPlaylistViewModel model) {
          if (this.playlist == null) {
            model.getPlaylist(this.playlistId!);
          } else {
            model.getPlaylist(this.playlist!.dbID!);
          }
        },
        builder: (BuildContext context, EditPlaylistViewModel model,
                Widget? child) =>
            model.playlist != null
                ? Scaffold(
                    appBar: !model.playlist!.canEdit
                        ? AppBar(
                            leading: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                model.navigateBack(context);
                              },
                            ),
                            actions: [
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
                            title: Text(model.playlist!.name!,
                                style: Theme.of(context).textTheme.headline2),
                            centerTitle: true,
                            iconTheme: IconThemeData(
                              color: Colors.white, //change your color here
                            ),
                          )
                        : AppBar(
                            automaticallyImplyLeading: false,
                            title: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(40),
                                ],
                                controller: model.nameController,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline2),
                            centerTitle: true,
                            iconTheme: IconThemeData(
                              color: Colors.white, //change your color here
                            ),
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      launch(model.playlist!.href!);
                                    },
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Hero(
                                            tag: model.playlist!.id!,
                                            child: Image.network(
                                                model.playlist!.image!),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.launch,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.fromLTRB(25, 40, 0, 15),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text(AppLocalizations.of(context)!
                                      .description),
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
                                    padding:
                                        EdgeInsets.fromLTRB(13, 20, 13, 20),
                                    alignment: Alignment.centerLeft,
                                    child: model.playlist!.canEdit
                                        ? TextField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                            controller:
                                                model.descriptionController,
                                            maxLines: null)
                                        : Text(model.playlist!.description!),
                                  ),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: FractionallySizedBox(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 5, 0, 5),
                                        alignment: Alignment.centerLeft,
                                        child: MultiSelectBottomSheetField(
                                          canEdit: model.playlist!.canEdit,
                                          decoration: BoxDecoration(),
                                          initialValue: model.playlist!.genres,
                                          initialChildSize: 0.4,
                                          listType: MultiSelectListType.CHIP,
                                          selectedItemsTextStyle:
                                              Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                          selectedColor:
                                              Theme.of(context).accentColor,
                                          itemsTextStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                          searchable: true,
                                          buttonText: Text(
                                              AppLocalizations.of(context)!
                                                  .selectedgenres,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                          title: Text(
                                              AppLocalizations.of(context)!
                                                  .genres,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                          items: model.playlistGenre!,
                                          onConfirm: (values) {
                                            model.addGenre(values);
                                          },
                                          onSelectionChanged:
                                              (List<dynamic> values) =>
                                                  model.checkAllGenres(values),
                                          chipDisplay: MultiSelectChipDisplay(
                                            chipColor:
                                                Theme.of(context).accentColor,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            onTap: (dynamic value) =>
                                                model.removeGenre(value),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Container(
                                          padding: EdgeInsets.all(7),
                                          child: CheckboxListTile(
                                            title: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .keepAllTracks,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons
                                                      .info_outline_rounded),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return AlertDialog(
                                                          content:
                                                              SingleChildScrollView(
                                                            child: ListBody(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .infoDialog,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            FluttifyButton(
                                                                onPressed: () =>
                                                                    model.navigateBack(
                                                                        context),
                                                                text: 'Okay',
                                                                width: 80,
                                                                height: 35),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            checkColor: Colors.white,
                                            activeColor:
                                                Theme.of(context).accentColor,
                                            value:
                                                model.playlist!.keepAllTracks,
                                            onChanged: (value) {
                                              if (playlist!.canEdit)
                                                model.keepItFresh(value!);
                                              else
                                                showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .editKeepAllTracks,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        FluttifyButton(
                                                            onPressed: () => model
                                                                .navigateBack(
                                                                    context),
                                                            text: 'Okay',
                                                            width: 80,
                                                            height: 35),
                                                      ],
                                                    );
                                                  },
                                                );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .contributors),
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
                                              Icons.person_add,
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
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .contributors),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!,
                                      ),
                                    ),
                              model.playlist!.displayContributers != null
                                  ? FractionallySizedBox(
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
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 10, 0, 10),
                                                child: Card(
                                                  color: contributers['id'] !=
                                                          model.authService
                                                              .currentUser.id
                                                      ? Theme.of(context)
                                                          .accentColor
                                                      : Color(0xff8AAB21),
                                                  shape: StadiumBorder(
                                                    side: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            12, 5, 12, 5),
                                                    child: model.playlist!
                                                                .canEdit &&
                                                            !(contributers[
                                                                    'id'] ==
                                                                model
                                                                    .authService
                                                                    .currentUser
                                                                    .id)
                                                        ? Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                  contributers[
                                                                      'name'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .subtitle2),
                                                              SizedBox(
                                                                  width: 5),
                                                              GestureDetector(
                                                                child: Icon(
                                                                  Icons.close,
                                                                  size: 14,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onTap: () => {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (_) {
                                                                      return AlertDialog(
                                                                        title:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .removeuser,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headline1,
                                                                        ),
                                                                        content:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              ListBody(
                                                                            children: <Widget>[
                                                                              Text(
                                                                                AppLocalizations.of(context)!.removeusercheck + contributers['name'] + '?',
                                                                                style: Theme.of(context).textTheme.bodyText2,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: <
                                                                            Widget>[
                                                                          FluttifyButton(
                                                                              onPressed: () => model.navigateBack(context),
                                                                              text: AppLocalizations.of(context)!.no,
                                                                              width: 80,
                                                                              height: 35),
                                                                          FluttifyButton(
                                                                              onPressed: () => {
                                                                                    model.removeUser(contributers['id']),
                                                                                    model.navigateBack(context),
                                                                                  },
                                                                              text: AppLocalizations.of(context)!.yes,
                                                                              width: 80,
                                                                              height: 35),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                },
                                                              ),
                                                            ],
                                                          )
                                                        : Text(
                                                            contributers[
                                                                'name'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle2),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              model.playlist!.canEdit
                                  ? Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FluttifyButton(
                                            color: Color.fromARGB(
                                                255, 233, 30, 30),
                                            onPressed: () => model.canEdit(),
                                            text: AppLocalizations.of(context)!
                                                .cancel,
                                            width: 150,
                                          ),
                                          FluttifyButton(
                                            onPressed: () =>
                                                model.save(context),
                                            text: AppLocalizations.of(context)!
                                                .save,
                                            width: 150,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              !model.playlist!.canEdit
                                  ? model.playlist!.contributers!.contains(
                                          model.authService.currentUser.id)
                                      ? Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 25, 25, 0),
                                          child: Column(
                                            children: [
                                              FluttifyButton(
                                                  color: Color.fromARGB(
                                                      255, 233, 30, 30),
                                                  onPressed: () => {
                                                        showDialog(
                                                          context: context,
                                                          builder: (_) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .leaveplaylist,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline1,
                                                              ),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      AppLocalizations.of(context)!
                                                                              .leaveplaylistcheck +
                                                                          model
                                                                              .playlist!
                                                                              .name! +
                                                                          '?',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText2,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FluttifyButton(
                                                                    onPressed: () =>
                                                                        model.navigateBack(
                                                                            context),
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .no,
                                                                    width: 80,
                                                                    height: 35),
                                                                FluttifyButton(
                                                                    onPressed:
                                                                        () => {
                                                                              model.leavePlaylist(context),
                                                                              model.navigateBack(context)
                                                                            },
                                                                    text: AppLocalizations.of(
                                                                            context)!
                                                                        .yes,
                                                                    width: 80,
                                                                    height: 35),
                                                              ],
                                                            );
                                                          },
                                                        )
                                                      },
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .leaveplaylist),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 10, 25, 0),
                                          child: Column(
                                            children: [
                                              FluttifyButton(
                                                color: Color(0xff8AAB21),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .joinplaylist,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline1,
                                                        ),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: ListBody(
                                                            children: <Widget>[
                                                              Text(
                                                                AppLocalizations.of(
                                                                            context)!
                                                                        .joinplaylistcheck +
                                                                    model
                                                                        .playlist!
                                                                        .name! +
                                                                    '?',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          FluttifyButton(
                                                              onPressed: () => model
                                                                  .navigateBack(
                                                                      context),
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .no,
                                                              width: 80,
                                                              height: 35),
                                                          FluttifyButton(
                                                              onPressed: () => {
                                                                    model.joinPlaylist(
                                                                        context),
                                                                    model.navigateBack(
                                                                        context),
                                                                  },
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .yes,
                                                              width: 80,
                                                              height: 35),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                text: AppLocalizations.of(
                                                        context)!
                                                    .joinplaylist,
                                              ),
                                            ],
                                          ),
                                        )
                                  : Container(),
                              if (!model.playlist!.canEdit)
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(25, 20, 0, 15),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              DefaultTextStyle(
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .currentsongs),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!,
                                              ),
                                              SizedBox(height: 5),
                                              model.playlist!.lastUpdate != null
                                                  ? DefaultTextStyle(
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                    context)!
                                                                .lastupdate +
                                                            DateFormat(
                                                                    'dd.MM.yyyy HH:mm')
                                                                .format(
                                                              dateTimeToZone(
                                                                  zone: "GST",
                                                                  datetime: model
                                                                      .playlist!
                                                                      .lastUpdate!),
                                                            ),
                                                      ),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!,
                                                    )
                                                  : Container(),
                                              model.playlist!
                                                          .displayContributers !=
                                                      null
                                                  ? DefaultTextStyle(
                                                      child: Text(
                                                          AppLocalizations.of(
                                                                      context)!
                                                                  .createdby +
                                                              model
                                                                  .getCreator()),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1!,
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          !model.playlist!.updating!
                                              ? Container(
                                                  padding: EdgeInsets.only(
                                                      right: 15),
                                                  child: IconButton(
                                                    onPressed: () =>
                                                        model.updatePlaylist(
                                                            context),
                                                    icon: Icon(Icons.refresh),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    !model.playlist!.updating!
                                        ? model.playlist!.lastUpdate != null
                                            ? Container(
                                                child: FractionallySizedBox(
                                                  widthFactor: 0.95,
                                                  child: Column(
                                                    children: [
                                                      for (Song song in model
                                                          .playlist!.songs!)
                                                        GestureDetector(
                                                          onTap: () {
                                                            launch(song.link!);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              if (model
                                                                      .playlist!
                                                                      .currentTracks !=
                                                                  null)
                                                                model
                                                                    .getSongContributors(
                                                                        song),
                                                              Card(
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
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                MediaQuery.of(context).size.width - 110,
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                25,
                                                                                10,
                                                                                0,
                                                                                10),
                                                                            child:
                                                                                LayoutBuilder(
                                                                              builder: (_, constraints) => (TextPainter(
                                                                                        textDirection: ui.TextDirection.ltr,
                                                                                        text: TextSpan(text: song.name!),
                                                                                        maxLines: 1,
                                                                                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                                                                                      )..layout())
                                                                                          .size >=
                                                                                      Offset(constraints.widthConstraints().minWidth, 0)
                                                                                  ? ScrollingText(text: song.name!, textStyle: Theme.of(context).textTheme.bodyText2)
                                                                                  : Text(
                                                                                      song.name!,
                                                                                      style: Theme.of(context).textTheme.bodyText2,
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                25,
                                                                                0,
                                                                                0,
                                                                                10),
                                                                            child:
                                                                                Text(
                                                                              song.artist!,
                                                                              style: Theme.of(context).textTheme.subtitle1,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    song.image ==
                                                                            null
                                                                        ? Container(
                                                                            height:
                                                                                75,
                                                                            width:
                                                                                75,
                                                                            child:
                                                                                Icon(
                                                                              Icons.music_note,
                                                                              size: 30,
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            height:
                                                                                75,
                                                                            width:
                                                                                75,
                                                                            child:
                                                                                ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)), child: ClipRRect(child: Image.network(song.image!))),
                                                                          ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                              )
                                        : Container(
                                            padding: EdgeInsets.fromLTRB(
                                                25, 0, 25, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .playlistupdating,
                                                ),
                                                CircularProgressIndicator(
                                                    color: Theme.of(context)
                                                        .primaryColor)
                                              ],
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
                    appBar: AppBar(
                      iconTheme: IconThemeData(
                        color: Colors.white, //change your color here
                      ),
                    ),
                    body: Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
        viewModelBuilder: () {
          return EditPlaylistViewModel(this.playlist, this.playlistId);
        });
  }
}
