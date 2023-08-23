import 'package:flutter/cupertino.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/models/playlist.dart';
import 'package:fluttify/services/dynamic_link_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class QrCodeImageView extends StatefulWidget {
  final Playlist? playlist;

  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

  QrCodeImageView({this.playlist});

  @override
  _QrCodeImageViewState createState() => _QrCodeImageViewState();
}

class _QrCodeImageViewState extends State<QrCodeImageView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('QR Code', style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Container(
                  child: QrImage(
                    data: widget.playlist!.id.toString(),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    errorStateBuilder: (cxt, error) {
                      return Container(
                          child: widget._dynamicLinkService.link!.isEmpty
                              ? Center(child: Text('Creating QR-Code failed'))
                              : null);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
