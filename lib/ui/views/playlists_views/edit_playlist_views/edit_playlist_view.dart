import 'dart:ui' as ui;

import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/models/song.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_bottom_sheet_field.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_chip_display.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_list_type.dart';
import 'package:fluttify/ui/widgets/playlist_sliver_appbar.dart';
import 'package:fluttify/ui/widgets/playlist_sliver_headerbuttons.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:fluttify/ui/widgets/song_card.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:instant/instant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';

// ignore: must_be_immutable
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
          model.communityview = this.communityview;
          if (this.playlist == null) {
            await model.getPlaylist(this.playlistId!);
          } else {
            //model.playlist!.canEdit = false;
            await model.getPlaylist(this.playlist!.dbID!);
            this.editable = true;
          }
        },
        builder: (BuildContext context, EditPlaylistViewModel model,
                Widget? child) =>
            model.playlist != null
                ? Scaffold(
                    /*
                    appBar: 
                    AppBar(
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
                                ? this.editable!
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: GestureDetector(
                                          child: Icon(Icons.edit),
                                          onTap: () => {
                                            model.canEdit(),
                                          },
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Center(
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                                color: Colors.white),
                                          ),
                                        ))
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
                    */
                    body: Stack(children: <Widget>[
                      CustomScrollView(
                        controller: model.scrollController!,
                        slivers: [
                          SliverPersistentHeader(
                              delegate: PlaylistSliverAppBar(
                                  notchPadding:
                                      MediaQuery.of(context).padding.top,
                                  expandedHeight: 400,
                                  model: model),
                              pinned: true),
                          SliverToBoxAdapter(
                            child: Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 50, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: DefaultTextStyle(
                                      child: Text(AppLocalizations.of(context)!
                                          .description),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!,
                                    ),
                                  ),
                                  Card(
                                    margin: const EdgeInsets.only(bottom: 8),
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

                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: DefaultTextStyle(
                                      child: Text(
                                          AppLocalizations.of(context)!.genres),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!,
                                    ),
                                  ),

                                  Card(
                                    margin: const EdgeInsets.only(bottom: 8),
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
                                            Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                        selectedColor:
                                            Theme.of(context).primaryColor,
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

                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(010, 15, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: DefaultTextStyle(
                                      child: Text(
                                          AppLocalizations.of(context)!.songs),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!,
                                    ),
                                  ),

                                  Card(
                                    margin: const EdgeInsets.only(bottom: 8),
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
                                            IconButton(
                                              icon: Icon(
                                                  Icons.info_outline_rounded),
                                              onPressed: () {
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
                                          ],
                                        ),
                                        checkColor: Colors.white,
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        value: model.playlist!.keepAllTracks,
                                        onChanged: (value) {
                                          if (model.playlist!.canEdit)
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
                                                          style:
                                                              Theme.of(context)
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
                                    ),
                                  ),
                                  // CONTRIBUTERS
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: DefaultTextStyle(
                                      child: Text(AppLocalizations.of(context)!
                                          .contributors),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!,
                                    ),
                                  ),
                                  model.playlist!.displayContributers != null
                                      ? FractionallySizedBox(
                                          widthFactor: 1,
                                          child: Card(
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Wrap(
                                              alignment: WrapAlignment.start,
                                              direction: Axis.horizontal,
                                              children: [
                                                for (dynamic contributers
                                                    in model.playlist!
                                                        .displayContributers!)
                                                  Container(
                                                    height: 65,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            15, 10, 0, 10),
                                                    child: Card(
                                                      color: contributers[
                                                                  'id'] !=
                                                              model
                                                                  .authService
                                                                  .currentUser
                                                                  .id
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Theme.of(context)
                                                              .indicatorColor,
                                                      shape: StadiumBorder(
                                                        side: BorderSide(
                                                            color: Colors
                                                                .transparent),
                                                      ),
                                                      child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
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
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .subtitle2),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    GestureDetector(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .close,
                                                                        size:
                                                                            14,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      onTap:
                                                                          () =>
                                                                              {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (_) {
                                                                            return AlertDialog(
                                                                              title: Text(
                                                                                AppLocalizations.of(context)!.removeuser,
                                                                                style: Theme.of(context).textTheme.headline1,
                                                                              ),
                                                                              content: SingleChildScrollView(
                                                                                child: ListBody(
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      AppLocalizations.of(context)!.removeusercheck + contributers['name'] + '?',
                                                                                      style: Theme.of(context).textTheme.bodyText2,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              actions: <Widget>[
                                                                                FluttifyButton(onPressed: () => model.navigateBack(context), text: AppLocalizations.of(context)!.no, width: 80, height: 35),
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
                                                                      (contributers['id'] ==
                                                                              model.playlist!.creator)
                                                                          ? Padding(
                                                                              padding: const EdgeInsets.only(right: 4.0),
                                                                              child: Icon(Icons.manage_accounts, color: Colors.white),
                                                                            )
                                                                          : Container(),
                                                                      Text(
                                                                          contributers[
                                                                              'name'],
                                                                          style: Theme.of(context)
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
                                    padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
                                    alignment: Alignment.topLeft,
                                    child: DefaultTextStyle(
                                      child: Text(AppLocalizations.of(context)!
                                          .advanced),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!,
                                    ),
                                  ),

                                  Container(
                                    //padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    child: Card(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      child: ExpansionTile(
                                        childrenPadding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        tilePadding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        title: Text(
                                          AppLocalizations.of(context)!
                                              .songcountsettings,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(AppLocalizations.of(
                                                          context)!
                                                      .toptracksshort),
                                                  TouchSpin(
                                                      value: model.playlist!
                                                          .countToptracksShort!,
                                                      min: 0,
                                                      max: 5,
                                                      step: 1,
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText2!,
                                                      iconSize: 25.0,
                                                      addIcon: Icon(Icons
                                                          .add_circle_outline),
                                                      subtractIcon: Icon(Icons
                                                          .remove_circle_outline),
                                                      iconActiveColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                      iconDisabledColor:
                                                          Colors.grey,
                                                      iconPadding:
                                                          EdgeInsets.all(20),
                                                      onChanged: (val) {
                                                        model.playlist!
                                                                .countToptracksShort =
                                                            val.toInt();
                                                      },
                                                      enabled: model
                                                          .playlist!.canEdit),
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
                                                          .countToptracksMedium =
                                                      val.toInt();
                                                },
                                                enabled:
                                                    model.playlist!.canEdit,
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
                                                value: model.playlist!
                                                    .countToptracksLong!,
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
                                                          .countToptracksLong =
                                                      val.toInt();
                                                },
                                                enabled:
                                                    model.playlist!.canEdit,
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
                                                value: model
                                                    .playlist!.countLibtracks!,
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
                                                          .countLibtracks =
                                                      val.toInt();
                                                },
                                                enabled:
                                                    model.playlist!.canEdit,
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

                                  if (!model.playlist!.canEdit)
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              15, 20, 15, 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  DefaultTextStyle(
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .currentsongs),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!,
                                                  ),
                                                  SizedBox(height: 5),
                                                  model.playlist!.lastUpdate !=
                                                          null
                                                      ? DefaultTextStyle(
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                        context)!
                                                                    .lastupdate +
                                                                DateFormat(
                                                                        'dd.MM.yyyy HH:mm')
                                                                    .format(
                                                                  dateTimeToZone(
                                                                      zone:
                                                                          "GST",
                                                                      datetime: model
                                                                          .playlist!
                                                                          .lastUpdate!),
                                                                ),
                                                          ),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .subtitle1!,
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                              !model.playlist!.updating! &&
                                                      model.playlist!
                                                          .contributers!
                                                          .contains(model
                                                              .authService
                                                              .currentUser
                                                              .id)
                                                  ? Container(
                                                      child: IconButton(
                                                        onPressed: () => model
                                                            .updatePlaylist(
                                                                //HERE
                                                                context),
                                                        icon:
                                                            Icon(Icons.refresh),
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
                                                        if (model.playlist!
                                                                    .currentTracks !=
                                                                null &&
                                                            model
                                                                    .playlist!
                                                                    .songs!
                                                                    .length !=
                                                                0)
                                                          for (Song song in model
                                                              .playlistSongs!)
                                                            Column(
                                                              children: [
                                                                if (model
                                                                    .playlist!
                                                                    .contributers!
                                                                    .contains(model
                                                                        .authService
                                                                        .currentUser
                                                                        .id))
                                                                  model
                                                                      .getSongContributors(
                                                                          song),
                                                                Container(
                                                                  /*
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          15),*/
                                                                  child: SongCard(
                                                                      song:
                                                                          song),
                                                                ),
                                                              ],
                                                            ),
                                                        if (model.playlist!.songs!
                                                                    .length !=
                                                                0 &&
                                                            model.playlistSongs!
                                                                    .length !=
                                                                model
                                                                    .playlist!
                                                                    .songs!
                                                                    .length)
                                                          Container(
                                                            child:
                                                                FluttifyButton(
                                                              height: 50,
                                                              width: 200,
                                                              text: AppLocalizations
                                                                      .of(context)!
                                                                  .loadAllSongs,
                                                              onPressed: () => model
                                                                  .setPlaylistSongs(),
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary),
                                                  )
                                            : Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 0, 15, 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .playlistupdating,
                                                    ),
                                                    CircularProgressIndicator(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary)
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
                        ],
                      ),
                      if (!model.playlist!.canEdit)
                        PlaylistSliverHeaderButtons(
                            top: 45 + MediaQuery.of(context).padding.top,
                            model: model,
                            show: model.showHeader),
                    ]),
                  )
                : Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
        viewModelBuilder: () {
          return EditPlaylistViewModel(this.playlist, this.playlistId,
              MediaQuery.of(context).padding.top);
        });
  }
}
