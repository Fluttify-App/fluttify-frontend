import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttify/ui/styles/colors.dart';
import 'package:fluttify/ui/views/add_playlist_views/add_playlist_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AddPlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPlaylistViewModel>.reactive(
      builder:
          (BuildContext context, AddPlaylistViewModel model, Widget child) =>
              Scaffold(
        appBar: AppBar(
          title: Text("Add Playlist"),
          backgroundColor: appBar_red,
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: FractionallySizedBox(
              widthFactor: 0.95,
              child: Column(
                children: [
                  TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(13),
                    ],
                    controller: model.nameController,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Name',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      model.saveName(value);
                    },
                  ),
                  TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(13),
                    ],
                    controller: model.descriptionController,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Beschreibung',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      model.saveDescription(value);
                    },
                  ),
                  TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(13),
                    ],
                    controller: model.genreController,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Genres',
                      border: InputBorder.none,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 45,
                            width: 100,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: appBar_red,
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
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            height: 45,
                            width: 100,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: appBar_red,
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
      viewModelBuilder: () => AddPlaylistViewModel(),
    );
  }
}
