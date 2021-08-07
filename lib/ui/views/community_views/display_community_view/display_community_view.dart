import 'dart:ui' as ui;

import 'package:fluttify/models/song.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/community_views/display_community_view/display_community_viewmodel.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_bottom_sheet_field.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_chip_display.dart';
import 'package:fluttify/ui/widgets/multi_select_bottom_sheet_field/multi_select_list_type.dart';
import 'package:fluttify/ui/widgets/scrolling_text.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisplayCommunityView extends StatelessWidget {
  const DisplayCommunityView({required this.playlistId});
  final String playlistId;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (DisplayCommunityViewModel model) {
          model.getPlaylist(playlistId);
        },
        builder: (BuildContext context, DisplayCommunityViewModel model,
                Widget? child) =>
            model.playlist != null
                ? Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          model.navigateBack(context);
                        },
                      ),
                      title: Text(model.playlist!.name!,
                          style: Theme.of(context).textTheme.headline2),
                      centerTitle: true,
                      iconTheme: IconThemeData(color: Colors.white),
                    ),
                    body: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(top: 30, bottom: 30),
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              if (model.playlist!.image == null)
                                Container(
                                  height: 150,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.music_note,
                                    size: 50,
                                  ),
                                )
                              else
                                Container(
                                  height: 250,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 9,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ]),
                                  child: GestureDetector(
                                    onTap: () {
                                      launch(model.playlist!.href!);
                                    },
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: Image.network(
                                              model.playlist!.image!),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.launch,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              Container(
                                padding: EdgeInsets.fromLTRB(25, 40, 0, 15),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text(AppLocalizations.of(context)!
                                      .description),
                                  style: Theme.of(context).textTheme.bodyText1!,
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Container(
                                    padding: EdgeInsets.all(13),
                                    alignment: Alignment.centerLeft,
                                    child: Text(model.playlist!.description!),
                                  ),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: FractionallySizedBox(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 5, 0, 5),
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
                                              Theme.of(context).accentColor,
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
                                          chipDisplay: MultiSelectChipDisplay(
                                            chipColor:
                                                Theme.of(context).accentColor,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                          onConfirm: (dynamic value) {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(25, 25, 0, 15),
                                alignment: Alignment.topLeft,
                                child: DefaultTextStyle(
                                  child: Text(AppLocalizations.of(context)!
                                      .contributors),
                                  style: Theme.of(context).textTheme.bodyText1!,
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: [
                                      for (dynamic contributers in model
                                          .playlist!.displayContributers!)
                                        Container(
                                          padding: EdgeInsets.fromLTRB(
                                              15, 10, 0, 10),
                                          child: Card(
                                            color:
                                                Theme.of(context).accentColor,
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: Colors.transparent),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  12, 5, 12, 5),
                                              child: Text(contributers['name'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                child: (!model.playlist!.likes!.contains(
                                        model.authService.currentUser.id))
                                    ? FluttifyButton(
                                        onPressed: () {
                                          model.likePlaylist(context);
                                        },
                                        text: AppLocalizations.of(context)!
                                            .likeplaylist,
                                        icon: Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.white,
                                        ),
                                        //width: 200,
                                        color: Color(0xff8AAB21),
                                      )
                                    : FluttifyButton(
                                        onPressed: () {
                                          model.unlikePlaylist(context);
                                        },
                                        text: AppLocalizations.of(context)!
                                            .unlikeplaylist,
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        ),
                                        //width: 200,
                                      ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(25, 20, 0, 15),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DefaultTextStyle(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .currentsongs),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
                                        ),
                                        SizedBox(height: 5),
                                        DefaultTextStyle(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                    .lastupdate +
                                                DateFormat('dd.MM.yyyy HH:mm')
                                                    .format(
                                                  dateTimeToZone(
                                                      zone: "GST",
                                                      datetime: model.playlist!
                                                          .lastUpdate!),
                                                ),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!,
                                        ),
                                        DefaultTextStyle(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                      .createdby +
                                                  model.getCreator()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: FractionallySizedBox(
                                      widthFactor: 0.95,
                                      child: Column(
                                        children: [
                                          for (Song song
                                              in model.playlist!.songs!)
                                            GestureDetector(
                                              onTap: () {
                                                launch(song.link!);
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            height: 40,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                110,
                                                            padding: EdgeInsets
                                                                .fromLTRB(25,
                                                                    10, 0, 10),
                                                            child:
                                                                LayoutBuilder(
                                                              builder: (_,
                                                                      constraints) =>
                                                                  (TextPainter(
                                                                            textDirection:
                                                                                ui.TextDirection.ltr,
                                                                            text:
                                                                                TextSpan(text: song.name!),
                                                                            maxLines:
                                                                                1,
                                                                            textScaleFactor:
                                                                                MediaQuery.of(context).textScaleFactor,
                                                                          )
                                                                                ..layout())
                                                                              .size >=
                                                                          Offset(
                                                                              constraints
                                                                                  .widthConstraints()
                                                                                  .minWidth,
                                                                              0)
                                                                      ? ScrollingText(
                                                                          text: song
                                                                              .name!,
                                                                          textStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2)
                                                                      : Text(
                                                                          song.name!,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyText2,
                                                                        ),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(25, 0,
                                                                    0, 10),
                                                            child: Text(
                                                              song.artist!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    song.image == null
                                                        ? Container(
                                                            height: 75,
                                                            width: 75,
                                                            child: Icon(
                                                              Icons.music_note,
                                                              size: 30,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 75,
                                                            width: 75,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: ClipRRect(
                                                                child: Image
                                                                    .network(song
                                                                        .image!),
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Scaffold(
                    appBar: AppBar(),
                    body: Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
        viewModelBuilder: () => DisplayCommunityViewModel());
  }
}
