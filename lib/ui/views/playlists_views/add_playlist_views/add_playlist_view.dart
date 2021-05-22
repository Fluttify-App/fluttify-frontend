import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/playlists_views/add_playlist_views/add_playlist_viewmodel.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:stacked/stacked.dart';

class AddPlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPlaylistViewModel>.reactive(
      builder:
          (BuildContext context, AddPlaylistViewModel model, Widget? child) =>
              Scaffold(
        appBar: AppBar(
          title: Text("Add Playlist"),
          backgroundColor: fluttify_Red,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[fluttify_gradient_1, fluttify_gradient_2],
              ),
            ),
          ),
        ),
        body: Center(
          child: FractionallySizedBox(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: FractionallySizedBox(
                  widthFactor: 0.95,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                  LengthLimitingTextInputFormatter(13),
                                ],
                                controller: model.nameController,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
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
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(13),
                                ],
                                maxLines: null,
                                controller: model.descriptionController,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
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
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: MultiSelectBottomSheetField(
                              decoration: BoxDecoration(),
                              initialChildSize: 0.4,
                              listType: MultiSelectListType.CHIP,
                              selectedItemsTextStyle:
                                  TextStyle(color: Colors.white),
                              selectedColor: fluttify_Red,
                              itemsTextStyle: TextStyle(color: Colors.white),
                              searchable: true,
                              buttonText: Text("Genres"),
                              title: Text("Genres"),
                              items: model.playlistGenre!,
                              onConfirm: (List<dynamic> values) {
                                model.addGenre(values);
                              },
                              chipDisplay: MultiSelectChipDisplay(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.4),
                                ),
                                chipColor: fluttify_Red,
                                textStyle: TextStyle(color: Colors.white),
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
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                height: 45,
                                width: 100,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: fluttify_Red,
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Colors.transparent))),
                                    child: Text('Cancel',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    onPressed: () {}),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                height: 45,
                                width: 100,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: fluttify_Red,
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Colors.transparent))),
                                    child: Text('Save',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    onPressed: () => model.save(context)),
                              ),
                            ),
                          ),
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
      viewModelBuilder: () => AddPlaylistViewModel(),
    );
  }
}
