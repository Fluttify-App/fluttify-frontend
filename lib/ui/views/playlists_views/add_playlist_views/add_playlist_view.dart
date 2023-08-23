import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:fluttify/ui/views/playlists_views/add_playlist_views/add_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_bottom_sheet_field.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_chip_display.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_list_type.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class AddPlaylistView extends StatelessWidget {
  bool? _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPlaylistViewModel>.reactive(
      builder:
          (BuildContext context, AddPlaylistViewModel model, Widget? child) =>
              Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(AppLocalizations.of(context)!.addplaylist,
              style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: IconButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) =>
                        states.contains(MaterialState.disabled)
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.check,
                ),
                onPressed: model.selectedGenres.length != 0 &&
                        model.nameController.text.isNotEmpty
                    ? () => model.save(context)
                    : null, //
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Column(
                  children: [
                    // NAME
                    Container(
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                            ],
                            controller: model.nameController,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: 'Name',
                              border: InputBorder.none,
                            ),
                            /*
                            onSubmitted: (String value) {
                              model.saveName(value);
                            },
                            */
                          ),
                        ),
                      ),
                    ),
                    // DESCRIPTION
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            maxLines: null,
                            controller: model.descriptionController,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText:
                                  AppLocalizations.of(context)!.description,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // GENRES
                    Container(
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          alignment: Alignment.centerLeft,
                          child: MultiSelectBottomSheetField(
                            canEdit: true,
                            decoration: BoxDecoration(),
                            initialChildSize: 0.4,
                            listType: MultiSelectListType.CHIP,
                            selectedItemsTextStyle:
                                Theme.of(context).textTheme.subtitle2,
                            selectedColor: Theme.of(context).primaryColor,
                            itemsTextStyle:
                                Theme.of(context).textTheme.subtitle2,
                            searchable: true,
                            buttonText: Text(
                              AppLocalizations.of(context)!.genres,
                              style: TextStyle(
                                  //color: Theme.of(context).hintColor,
                                  fontSize: 18),
                            ),
                            title: Text(AppLocalizations.of(context)!.genres,
                                style: Theme.of(context).textTheme.bodyText1),
                            items: model.playlistGenre!,
                            onConfirm: (List<dynamic> values) {
                              model.addGenre(values);
                            },
                            onSelectionChanged: (List<dynamic> values) =>
                                model.checkAllGenres(values),
                            chipDisplay: MultiSelectChipDisplay(
                              chipColor: Theme.of(context).primaryColor,
                              textStyle: Theme.of(context).textTheme.subtitle2,
                              onTap: (dynamic value) {
                                model.removeGenre(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    // KEEP ALL TRACKS
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          padding: EdgeInsets.all(7),
                          child: CheckboxListTile(
                            title: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    AppLocalizations.of(context)!.keepAllTracks,
                                    style: TextStyle(
                                        //color: Theme.of(context).hintColor,
                                        fontSize: 18),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.info_outline_rounded,
                                      color: Theme.of(context).hintColor),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .infoDialog,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FluttifyButton(
                                                onPressed: () =>
                                                    model.navigateBack(context),
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
                            activeColor: Theme.of(context).primaryColor,
                            value: model.playlist.keepAllTracks,
                            onChanged: (value) {
                              model.keepItFresh(value!);
                            },
                          ),
                        ),
                      ),
                    ),
                    // ADVANCED SETTINGS
                    Container(
                        child: Card(
                      margin: const EdgeInsets.all(0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.all(0),
                          title: Text(
                            AppLocalizations.of(context)!.advanced,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          trailing: Icon(
                              _customTileExpanded!
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Theme.of(context).colorScheme.secondary),
                          children: <Widget>[
                            // Top Tracks Short
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .toptracksshort),
                                TouchSpin(
                                  value: model.playlist.countToptracksShort!,
                                  min: 0,
                                  max: 5,
                                  step: 1,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2!,
                                  iconSize: 25.0,
                                  addIcon: Icon(Icons.add_circle_outline),
                                  subtractIcon:
                                      Icon(Icons.remove_circle_outline),
                                  iconActiveColor:
                                      Theme.of(context).primaryColor,
                                  iconDisabledColor: Colors.grey,
                                  iconPadding: EdgeInsets.all(20),
                                  onChanged: (val) {
                                    model.playlist.countToptracksShort =
                                        val.toInt();
                                  },
                                  enabled: true,
                                ),
                              ],
                            ),
                            // Top Tracks Medium
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    AppLocalizations.of(context)!.toptracksmid),
                                TouchSpin(
                                  value: model.playlist.countToptracksMedium!,
                                  min: 0,
                                  max: 5,
                                  step: 1,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2!,
                                  iconSize: 25.0,
                                  addIcon: Icon(Icons.add_circle_outline),
                                  subtractIcon:
                                      Icon(Icons.remove_circle_outline),
                                  iconActiveColor:
                                      Theme.of(context).primaryColor,
                                  iconDisabledColor: Colors.grey,
                                  iconPadding: EdgeInsets.all(20),
                                  onChanged: (val) {
                                    model.playlist.countToptracksMedium =
                                        val.toInt();
                                  },
                                  enabled: true,
                                ),
                              ],
                            ),
                            // Top Tracks Long
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)!
                                    .toptrackslong),
                                TouchSpin(
                                  value: model.playlist.countToptracksLong!,
                                  min: 0,
                                  max: 5,
                                  step: 1,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2!,
                                  iconSize: 25.0,
                                  addIcon: Icon(Icons.add_circle_outline),
                                  subtractIcon:
                                      Icon(Icons.remove_circle_outline),
                                  iconActiveColor:
                                      Theme.of(context).primaryColor,
                                  iconDisabledColor: Colors.grey,
                                  iconPadding: EdgeInsets.all(20),
                                  onChanged: (val) {
                                    model.playlist.countToptracksLong =
                                        val.toInt();
                                  },
                                  enabled: true,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(AppLocalizations.of(context)!.libtracks),
                                TouchSpin(
                                  value: model.playlist.countLibtracks!,
                                  min: 0,
                                  max: 5,
                                  step: 1,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2!,
                                  iconSize: 25.0,
                                  addIcon: Icon(Icons.add_circle_outline),
                                  subtractIcon:
                                      Icon(Icons.remove_circle_outline),
                                  iconActiveColor:
                                      Theme.of(context).primaryColor,
                                  iconDisabledColor: Colors.grey,
                                  iconPadding: EdgeInsets.all(20),
                                  onChanged: (val) {
                                    model.playlist.countLibtracks = val.toInt();
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
                    ))
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FluttifyButton(
                                color: Theme.of(context).errorColor,
                                padding: const EdgeInsets.only(right: 10),
                                onPressed: () => model.navigateBack(context),
                                text: AppLocalizations.of(context)!.cancel,
                                width:
                                    (MediaQuery.of(context).size.width - 60) /
                                        2,
                              ),
                              FluttifyButton(
                                padding: const EdgeInsets.only(left: 10),
                                color: Theme.of(context).indicatorColor,
                                onPressed: () => model.save(context),
                                text: AppLocalizations.of(context)!.save,
                                width:
                                    (MediaQuery.of(context).size.width - 60) /
                                        2,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                    */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => AddPlaylistViewModel(),
    );
  }
}
