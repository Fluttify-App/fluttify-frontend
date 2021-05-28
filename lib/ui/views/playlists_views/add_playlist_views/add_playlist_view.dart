import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/playlists_views/add_playlist_views/add_playlist_viewmodel.dart';
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
              style: Theme.of(context).textTheme.headline1),
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
                          //padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: FractionallySizedBox(
                            widthFactor: 0.95,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  
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
                                    TextStyle(color: Colors.white),
                                selectedColor: Theme.of(context).accentColor,
                                itemsTextStyle:
                                    Theme.of(context).textTheme.button,
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
                                  textStyle: Theme.of(context).textTheme.button,
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
                                          backgroundColor:
                                              Theme.of(context).accentColor,
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: Colors.transparent))),
                                      child: Text('Cancel',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      onPressed: () =>
                                          model.navigateBack(context)),
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
                                          backgroundColor:
                                              Theme.of(context).accentColor,
                                          shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: Colors.transparent))),
                                      child: Text('Save',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
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
      ),
      viewModelBuilder: () => AddPlaylistViewModel(),
    );
  }
}
