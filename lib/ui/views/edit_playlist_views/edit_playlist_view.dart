import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/edit_playlist_views/edit_playlist_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:stacked/stacked.dart';

class EditPlaylistView extends StatelessWidget {
  const EditPlaylistView({this.playlist});
  final Playlist playlist;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (BuildContext context, EditPlaylistViewModel model,
                Widget child) =>
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
                // TODO: Title wird nicht in der playlist view aktualisiert
                title: playlist.canEdit
                    ? TextField(
                        controller: model.nameController,
                        textAlign: TextAlign.center,
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 1.5),
                      )
                    : Text(playlist.name),
                backgroundColor: appBar_red,
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[gradientColor_1, gradientColor_2],
                    ),
                  ),
                ),
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
                          child: Text(
                            "Beschreibung",
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 1.3),
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
                                  : Text(playlist.description),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Genres",
                            style: DefaultTextStyle.of(context)
                                .style
                                .apply(fontSizeFactor: 1.3),
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
                                    // TODO: make readonly feld if possible
                                    MultiSelectBottomSheetField(
                                      decoration: BoxDecoration(),
                                      initialValue: playlist.genres,
                                      initialChildSize: 0.4,
                                      listType: MultiSelectListType.CHIP,
                                      selectedItemsTextStyle:
                                          TextStyle(color: Colors.white),
                                      selectedColor: appBar_red,
                                      itemsTextStyle:
                                          TextStyle(color: Colors.white),
                                      searchable: true,
                                      buttonText: Text("Genres"),
                                      title: Text("Genres"),
                                      items: model.playlistGenre,
                                      onConfirm: (values) {
                                        model.addGenre(values);
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.4),
                                        ),
                                        chipColor: appBar_red,
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                        onTap: (value) {
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
                                    child: Text(
                                      "Collaborators",
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .apply(fontSizeFactor: 1.3),
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
                                child: Text(
                                  "Collaborators",
                                  style: DefaultTextStyle.of(context)
                                      .style
                                      .apply(fontSizeFactor: 1.3),
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
                                for (String collaborator
                                    in playlist.collaborators)
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
                                          collaborator,
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
                                                backgroundColor: appBar_red,
                                                shape: StadiumBorder(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .transparent))),
                                            child: Text(
                                              'Cancel',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style
                                                      .apply(
                                                          fontSizeFactor: 1.3,
                                                          color: Colors.white),
                                            ),
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
                                                backgroundColor: appBar_red,
                                                shape: StadiumBorder(
                                                    side: BorderSide(
                                                        color: Colors
                                                            .transparent))),
                                            child: Text(
                                              'Save',
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style
                                                      .apply(
                                                          fontSizeFactor: 1.3,
                                                          color: Colors.white),
                                            ),
                                            onPressed: () => model.save()),
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
