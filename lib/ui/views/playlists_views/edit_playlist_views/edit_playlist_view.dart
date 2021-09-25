import 'dart:ui' as ui;

import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/models/song.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/styles/colors.dart';
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
import 'package:flutter_touch_spin/flutter_touch_spin.dart';

class EditPlaylistView extends StatelessWidget {
  EditPlaylistView(
      {this.playlist,
      this.playlistId,
      this.communityview = false,
      this.editable = false});
  final Playlist? playlist;
  final String? playlistId;
  final bool? communityview;
  bool? editable;
  bool? _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (EditPlaylistViewModel model) async {
          if (this.playlist == null) {
            model.getPlaylist(this.playlistId!);
          } else {
            await model.getPlaylist(this.playlist!.dbID!);
            print("now");
            this.editable = true;
          }
        },
        builder: (BuildContext context, EditPlaylistViewModel model,
                Widget? child) =>
            model.playlist != null
                ? Scaffold(
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.white),
                      actions: [
                        model.playlist!.canEdit
                            ? Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) => states
                                              .contains(MaterialState.disabled)
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.white,
                                    ),
                                  ),
                                  child:
                                      Text(AppLocalizations.of(context)!.save),
                                  onPressed: model.selectedGenres.length != 0 &&
                                          model.nameController.text.isNotEmpty
                                      ? () => model.save(context)
                                      : null, //
                                ),
                              )
                            : model.playlist!.creator ==
                                    model.authService.currentUser.id
                                ? Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child: GestureDetector(
                                      child: Icon(Icons.edit),
                                      onTap: () => {
                                        if (this.editable!) model.canEdit(),
                                      },
                                    ),
                                  )
                                : Container()
                      ],
                      title: !model.playlist!.canEdit
                          ? Text(model.playlist!.name!,
                              style: Theme.of(context).textTheme.headline2)
                          : Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(40),
                                  ],
                                  controller: model.nameController,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline2),
                            ),
                      centerTitle: true,
                    ),
                    body: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              if (!model.playlist!.canEdit)
                                if (model.playlist!.image == null)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 30),
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
                                    margin: const EdgeInsets.only(bottom: 30),
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        launch(model.playlist!.href!);
                                      },
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          1), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: Image.network(
                                                      model.playlist!.image!,
                                                      height: 250,
                                                      width: 250),
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                              Icons.launch,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text(AppLocalizations.of(context)!
                                      .description),
                                  style: Theme.of(context).textTheme.bodyText1!,
                                ),
                              ),
                              Card(
                                margin: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(13, 20, 13, 20),
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
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text(
                                      AppLocalizations.of(context)!.genres),
                                  style: Theme.of(context).textTheme.bodyText1!,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Card(
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Container(
                                    height:
                                        model.playlist!.genres!.isNotEmpty ||
                                                model.playlist!.canEdit
                                            ? null
                                            : 50,
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: MultiSelectBottomSheetField(
                                      canEdit: model.playlist!.canEdit,
                                      decoration: BoxDecoration(),
                                      initialValue: model.playlist!.genres,
                                      initialChildSize: 0.4,
                                      listType: MultiSelectListType.CHIP,
                                      selectedItemsTextStyle:
                                          Theme.of(context).textTheme.subtitle2,
                                      selectedColor:
                                          Theme.of(context).primaryColor,
                                      itemsTextStyle:
                                          Theme.of(context).textTheme.subtitle2,
                                      searchable: true,
                                      buttonText: Text(
                                          AppLocalizations.of(context)!
                                              .selectedgenres,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      title: Text(
                                          AppLocalizations.of(context)!.genres,
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
                                        height: 65,
                                        chipColor:
                                            Theme.of(context).primaryColor,
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
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child:
                                      Text(AppLocalizations.of(context)!.songs),
                                  style: Theme.of(context).textTheme.bodyText1!,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    child: Card(
                                      margin: const EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Container(
                                        padding: EdgeInsets.all(7),
                                        child: CheckboxListTile(
                                          title: Row(
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .keepAllTracks,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!,
                                                ),
                                              ),
                                              if (model.playlist!.canEdit)
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
                                              Theme.of(context).primaryColor,
                                          value: model.playlist!.keepAllTracks,
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
                              model.playlist!.canEdit
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 15, 0, 10),
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
                                                0, 25, 0, 15),
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
                                          EdgeInsets.fromLTRB(0, 15, 0, 10),
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
                              // CONTRIBUTERS
                              model.playlist!.displayContributers != null
                                  ? FractionallySizedBox(
                                      widthFactor: 1,
                                      child: Card(
                                        margin: const EdgeInsets.all(0),
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
                                                height: 65,
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 10, 0, 10),
                                                child: Card(
                                                  color: contributers['id'] !=
                                                          model.authService
                                                              .currentUser.id
                                                      ? Theme.of(context)
                                                          .primaryColor
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
                                                                            AppLocalizations.of(context)!.removeuser,
                                                                            style:
                                                                                Theme.of(context).textTheme.headline1,
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
                                                          : Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: <
                                                                  Widget>[
                                                                  (contributers[
                                                                              'id'] ==
                                                                          model
                                                                              .playlist!
                                                                              .creator)
                                                                      ? Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 4.0),
                                                                          child: Icon(
                                                                              Icons.manage_accounts,
                                                                              color: Colors.white),
                                                                        )
                                                                      : Container(),
                                                                  Text(
                                                                      contributers[
                                                                          'name'],
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .subtitle2)
                                                                ])),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              // ADVANCED SETTINGS
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text(
                                      AppLocalizations.of(context)!.advanced),
                                  style: Theme.of(context).textTheme.bodyText1!,
                                ),
                              ),
                              Container(
                                //padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                child: Card(
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: ExpansionTile(
                                    childrenPadding:
                                        EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    tilePadding:
                                        EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    title: Text(
                                      AppLocalizations.of(context)!
                                          .songcountsettings,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    trailing: Icon(
                                      _customTileExpanded!
                                          ? Icons.arrow_drop_down_circle
                                          : Icons.arrow_drop_down,
                                    ),
                                    children: <Widget>[
                                      // Top Tracks Short
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(AppLocalizations.of(context)!
                                                  .toptracksshort),
                                              TouchSpin(
                                                value: model.playlist!
                                                    .countToptracksShort!,
                                                min: 0,
                                                max: 5,
                                                step: 1,
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!,
                                                iconSize: 25.0,
                                                addIcon: Icon(
                                                    Icons.add_circle_outline),
                                                subtractIcon: Icon(Icons
                                                    .remove_circle_outline),
                                                iconActiveColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                iconDisabledColor: Colors.grey,
                                                iconPadding: EdgeInsets.all(20),
                                                onChanged: (val) {
                                                  model.playlist!
                                                          .countToptracksShort =
                                                      val.toInt();
                                                },
                                                enabled: true,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Top Tracks Medium
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                              .toptracksmid),
                                          TouchSpin(
                                            value: model.playlist!
                                                .countToptracksMedium!,
                                            min: 0,
                                            max: 5,
                                            step: 1,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2!,
                                            iconSize: 25.0,
                                            addIcon:
                                                Icon(Icons.add_circle_outline),
                                            subtractIcon: Icon(
                                                Icons.remove_circle_outline),
                                            iconActiveColor:
                                                Theme.of(context).primaryColor,
                                            iconDisabledColor: Colors.grey,
                                            iconPadding: EdgeInsets.all(20),
                                            onChanged: (val) {
                                              model.playlist!
                                                      .countToptracksMedium =
                                                  val.toInt();
                                            },
                                            enabled: true,
                                          ),
                                        ],
                                      ),
                                      // Top Tracks Long
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                              .toptrackslong),
                                          TouchSpin(
                                            value: model
                                                .playlist!.countToptracksLong!,
                                            min: 0,
                                            max: 5,
                                            step: 1,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2!,
                                            iconSize: 25.0,
                                            addIcon:
                                                Icon(Icons.add_circle_outline),
                                            subtractIcon: Icon(
                                                Icons.remove_circle_outline),
                                            iconActiveColor:
                                                Theme.of(context).primaryColor,
                                            iconDisabledColor: Colors.grey,
                                            iconPadding: EdgeInsets.all(20),
                                            onChanged: (val) {
                                              model.playlist!
                                                      .countToptracksLong =
                                                  val.toInt();
                                            },
                                            enabled: true,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                              .libtracks),
                                          TouchSpin(
                                            value:
                                                model.playlist!.countLibtracks!,
                                            min: 0,
                                            max: 5,
                                            step: 1,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2!,
                                            iconSize: 25.0,
                                            addIcon:
                                                Icon(Icons.add_circle_outline),
                                            subtractIcon: Icon(
                                                Icons.remove_circle_outline),
                                            iconActiveColor:
                                                Theme.of(context).primaryColor,
                                            iconDisabledColor: Colors.grey,
                                            iconPadding: EdgeInsets.all(20),
                                            onChanged: (val) {
                                              model.playlist!.countLibtracks =
                                                  val.toInt();
                                            },
                                            enabled: true,
                                          ),
                                        ],
                                      )
                                    ],
                                    onExpansionChanged: (bool expanded) {
                                      _customTileExpanded = expanded;
                                    },
                                  ),
                                ),
                              ),
                              /*
                              model.playlist!.canEdit
                                  ? Container(
                                      padding: EdgeInsets.only(top: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FluttifyButton(
                                            color: Theme.of(context).errorColor,
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            onPressed: () => model.canEdit(),
                                            text: AppLocalizations.of(context)!
                                                .cancel,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    60) /
                                                2,
                                          ),
                                          FluttifyButton(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            onPressed: () =>
                                                model.save(context),
                                            text: AppLocalizations.of(context)!
                                                .save,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    60) /
                                                2,
                                            color: Theme.of(context)
                                                .indicatorColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                                  */
                              !model.playlist!.canEdit
                                  ? !this.communityview!
                                      ? model.playlist!.contributers!.contains(
                                              model.authService.currentUser.id)
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 25, 0, 0),
                                              child: Column(
                                                children: [
                                                  // LEAVE BUTTON
                                                  FluttifyButton(
                                                      color: Theme.of(context)
                                                          .errorColor,
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
                                                                    child:
                                                                        ListBody(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          AppLocalizations.of(context)!.leaveplaylistcheck +
                                                                              model.playlist!.name! +
                                                                              '?',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <
                                                                      Widget>[
                                                                    FluttifyButton(
                                                                        onPressed: () =>
                                                                            model.navigateBack(
                                                                                context),
                                                                        text: AppLocalizations.of(context)!
                                                                            .no,
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            35),
                                                                    FluttifyButton(
                                                                        onPressed:
                                                                            () =>
                                                                                {
                                                                                  model.leavePlaylist(context),
                                                                                  model.navigateBack(context)
                                                                                },
                                                                        text: AppLocalizations.of(context)!
                                                                            .yes,
                                                                        width:
                                                                            80,
                                                                        height:
                                                                            35),
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 10, 0, 0),
                                              child: Column(
                                                children: [
                                                  // JOIN BUTTON
                                                  FluttifyButton(
                                                    color: Theme.of(context)
                                                        .indicatorColor,
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .joinplaylist,
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
                                                                            model.joinPlaylist(context),
                                                                            model.navigateBack(context),
                                                                          },
                                                                  text: AppLocalizations.of(
                                                                          context)!
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
                                      : Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 25, 0, 0),
                                          child: (!model.playlist!.likes!
                                                  .contains(model.authService
                                                      .currentUser.id))
                                              ?
                                              // LIKE BUTTON
                                              FluttifyButton(
                                                  onPressed: () {
                                                    model.likePlaylist(context);
                                                  },
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .likeplaylist,
                                                  icon: Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  //width: 200,
                                                  color: Theme.of(context)
                                                      .indicatorColor,
                                                )
                                              : //UNLIKE BUTTON
                                              FluttifyButton(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  onPressed: () {
                                                    model.unlikePlaylist(
                                                        context);
                                                  },
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .unlikeplaylist,
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                  ),
                                                  //width: 200,
                                                ),
                                        )
                                  : Container(),
                              if (!model.playlist!.canEdit)
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 0, 15),
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
                                            ],
                                          ),
                                          !model.playlist!.updating! &&
                                                  model.playlist!.contributers!
                                                      .contains(model
                                                          .authService
                                                          .currentUser
                                                          .id)
                                              ? Container(
                                                  child: IconButton(
                                                    onPressed: () => model
                                                        .updatePlaylist(//HERE
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
                                                            if (model.playlist!
                                                                    .currentTracks !=
                                                                null)
                                                              if (!this
                                                                  .communityview!)
                                                                model
                                                                    .getSongContributors(
                                                                        song),
                                                            Card(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 0,
                                                                      right: 0,
                                                                      bottom:
                                                                          8),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
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
                                                                            style:
                                                                                Theme.of(context).textTheme.subtitle1,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  song.image ==
                                                                          null
                                                                      ? SizedBox(
                                                                          height:
                                                                              75,
                                                                          width:
                                                                              75,
                                                                          child:
                                                                              Icon(
                                                                            Icons.music_note,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                        )
                                                                      : SizedBox(
                                                                          height:
                                                                              75,
                                                                          width:
                                                                              75,
                                                                          child: ClipRRect(
                                                                              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                              child: ClipRRect(child: Image.network(song.image!))),
                                                                        ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Theme.of(context)
                                                            .accentColor),
                                              )
                                        : Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                                        .accentColor)
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
                      iconTheme: IconThemeData(color: Colors.white),
                    ),
                    body: Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).accentColor),
                    ),
                  ),
        viewModelBuilder: () {
          return EditPlaylistViewModel(this.playlist, this.playlistId);
        });
  }
}
