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

class AddPlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPlaylistViewModel>.reactive(
      builder:
          (BuildContext context, AddPlaylistViewModel model, Widget? child) =>
              Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Add Playlist",
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
                                    hintText: 'Beschreibung',
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
                        FractionallySizedBox(
                          widthFactor: 0.95,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: MultiSelectBottomSheetField(
                                canEdit: true,
                                decoration: BoxDecoration(),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                selectedItemsTextStyle:
                                    Theme.of(context).textTheme.subtitle2,
                                selectedColor: Theme.of(context).accentColor,
                                itemsTextStyle: 
                                    Theme.of(context).textTheme.subtitle2,
                                searchable: true,
                                buttonText: Text("Genres",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                title: Text("Genres",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
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
                                    text: 'Cancel',
                                    width: MediaQuery.of(context).size.width / 2 - 50,
                                    color: Color.fromARGB(255, 233, 30, 30),
                                  ),
                                  FluttifyButton(
                                    onPressed: () => model.save(context),
                                    text: 'Save',
                                    width: MediaQuery.of(context).size.width / 2 - 50,
                                    // TODO: think about which color it should have
                                    color: fluttify_gradient_2
                                    //color: Color(0xff8AAB21),
                                  ),
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
