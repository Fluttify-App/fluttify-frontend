import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/services.dart';

class EditPlaylistView extends StatelessWidget {
  const EditPlaylistView({required this.playlist});
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (BuildContext context, EditPlaylistViewModel model,
                Widget? child) =>
            Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      child: Icon(Icons.edit),
                      onTap: () => {
                        model.canEdit(),
                      },
                    ),
                  ),
                ],
                title: playlist.canEdit
                    ? TextField(
                        inputFormatters: [
                            LengthLimitingTextInputFormatter(13),
                          ],
                        controller: model.nameController,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20))
                    : Text(playlist.name!),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                child: FractionallySizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 15),
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
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              padding: EdgeInsets.all(13),
                              alignment: Alignment.centerLeft,
                              child: playlist.canEdit
                                  ? TextField(
                                      controller: model.descriptionController,
                                      maxLines: null)
                                  : Text(playlist.description!),
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
                                borderRadius: BorderRadius.circular(10.0)),
                            child: FractionallySizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.4),
                                    border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  children: <Widget>[
                                    // TODO: download files and edit, first null safety for project
                                    MultiSelectBottomSheetField(
                                      decoration: BoxDecoration(),
                                      initialValue: playlist.genres,
                                      initialChildSize: 0.4,
                                      listType: MultiSelectListType.CHIP,
                                      selectedItemsTextStyle:
                                          TextStyle(color: Colors.white),
                                      selectedColor:
                                          Theme.of(context).primaryColor,
                                      itemsTextStyle:
                                          TextStyle(color: Colors.white),
                                      searchable: true,
                                      buttonText: Text("Genres"),
                                      title: Text("Genres"),
                                      items: model.playlistGenre!,
                                      onConfirm: (values) {
                                        model.addGenre(values);
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.4),
                                        ),
                                        chipColor:
                                            Theme.of(context).primaryColor,
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                        onTap: (String value) {
                                          model.removeGenre(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // TODO: Delete if not needed anymore
                            /*
                            Wrap(
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                playlist.canEdit
                                    ? FractionallySizedBox(
                                        widthFactor: 0.95,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(.4),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            children: <Widget>[
                                              MultiSelectBottomSheetField(
                                                initialValue: playlist.genres,
                                                initialChildSize: 0.4,
                                                listType:
                                                    MultiSelectListType.CHIP,
                                                searchable: true,
                                                buttonText: Text("Genres"),
                                                title: Text("Genres"),
                                                items: model.playlistGenre,
                                                onConfirm: (values) {
                                                  model.addGenre(values);
                                                },
                                                chipDisplay:
                                                    MultiSelectChipDisplay(
                                                  onTap: (value) {
                                                    model.removeGenre(value);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      
                                    : playlist.genres.map<Widget>(
                                        (genre) => Container(
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
                                                genre,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ).toList(),
                              ],
                            ),*/
                          ),
                        ),
                        playlist.canEdit
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
                                    alignment: Alignment.topLeft,
                                    child: DefaultTextStyle(
                                      child: Text("Contributers"),
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
                                padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text("Contributers"),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                        FractionallySizedBox(
                          widthFactor: 0.95,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                for (String contributers
                                    in playlist.contributers!)
                                  Container(
                                    padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                                    child: Card(
                                      color: Color.fromARGB(255, 94, 8, 28),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(12, 5, 12, 5),
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
                        playlist.canEdit
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
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
                                            onPressed: () => model.canEdit()),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => EditPlaylistViewModel(playlist));
  }
}
