import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/playlists_views/add_playlist_views/add_playlist_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_bottom_sheet_field.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_chip_display.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_list_type.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPlaylistView extends StatelessWidget {
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
            TextButton(
              child: Text(AppLocalizations.of(context)!.save),
              onPressed: model.selectedGenres.length != 0 &&
                      model.nameController.text.isNotEmpty
                  ? () => model.save(context)
                  : null, //
            ),
          ],
        ),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                            ],
                            controller: model.nameController,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            maxLines: null,
                            controller: model.descriptionController,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
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
                    Container(
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
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
                                  color: Theme.of(context).hintColor,
                                  fontSize: 20),
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
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
                                        color: Theme.of(context).hintColor,
                                        fontSize: 20),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.info_outline_rounded),
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
