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
          automaticallyImplyLeading: false,
          title: Text(AppLocalizations.of(context)!.addplaylist,
              style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Column(
                      children: [
                        Container(
                          child: FractionallySizedBox(
                            widthFactor: 0.95,
                            child: Card(
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
                                  onSubmitted: (String value) {
                                    model.saveName(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: FractionallySizedBox(
                            widthFactor: 0.95,
                            child: Card(
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
                                    hintText: AppLocalizations.of(context)!
                                        .description,
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (String value) {
                                    model.saveDescription(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.symmetric(vertical: 10),
                          child: FractionallySizedBox(
                              widthFactor: 0.95,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Container(
                                      padding: EdgeInsets.all(7),
                                      child: CheckboxListTile(
                                          title: Text(
                                            AppLocalizations.of(context)!
                                                .allgenres,
                                            style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontSize: 20),
                                          ),
                                          checkColor: Colors.white,
                                          activeColor:
                                              Theme.of(context).accentColor,
                                          value: model.playlist.allgenres!,
                                          onChanged: (value) {
                                            model.setAllGenres(value!);
                                          })))),
                        ),
                        if (!model.playlist.allgenres)
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: FractionallySizedBox(
                              widthFactor: 0.95,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.centerLeft,
                                  child: MultiSelectBottomSheetField(
                                    canEdit: true,
                                    decoration: BoxDecoration(),
                                    initialChildSize: 0.4,
                                    listType: MultiSelectListType.CHIP,
                                    selectedItemsTextStyle:
                                        Theme.of(context).textTheme.subtitle2,
                                    selectedColor:
                                        Theme.of(context).accentColor,
                                    itemsTextStyle:
                                        Theme.of(context).textTheme.subtitle2,
                                    searchable: true,
                                    buttonText: Text(
                                      AppLocalizations.of(context)!.genres,
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor,
                                          fontSize: 20),
                                    ),
                                    title: Text(
                                        AppLocalizations.of(context)!.genres,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    items: model.playlistGenre!,
                                    onConfirm: (List<dynamic> values) {
                                      model.addGenre(values);
                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      chipColor: Theme.of(context).accentColor,
                                      textStyle:
                                          Theme.of(context).textTheme.subtitle2,
                                      onTap: (String value) {
                                        model.removeGenre(value);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FluttifyButton(
                                    onPressed: () =>
                                        model.navigateBack(context),
                                    text: AppLocalizations.of(context)!.cancel,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            50,
                                    color: Color.fromARGB(255, 233, 30, 30),
                                  ),
                                  FluttifyButton(
                                      onPressed: () => model.save(context),
                                      text: AppLocalizations.of(context)!.save,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          50,
                                      color: fluttify_gradient_2),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
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
