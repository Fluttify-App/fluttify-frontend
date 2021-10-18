import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/fluttify_playlist_service.dart';
import 'package:fluttify/services/navigation_service.dart';
import 'package:fluttify/ui/views/playlists_views/edit_playlist_views/edit_playlist_view.dart';
import 'package:fluttify/ui/widgets/fluttify_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QrCodeImageReaderView extends StatefulWidget {
  @override
  _QrCodeImageReaderView createState() => _QrCodeImageReaderView();
}

class _QrCodeImageReaderView extends State<QrCodeImageReaderView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  QRViewController? controller;

  final FluttifyPlaylistService playlistService =
      locator<FluttifyPlaylistService>();
  final PlaylistNavigationService _navigationService =
      locator<PlaylistNavigationService>();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.qrCodeScanner,
            style: Theme.of(context).textTheme.headline2),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            cutOutSize: MediaQuery.of(context).size.width * 0.8,
            borderWidth: 10,
            borderLength: 20,
            borderRadius: 10,
            borderColor: Theme.of(context).primaryColor),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    this.controller!.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunch(scanData.code)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.qrLaunchUrlWarning,
                style: Theme.of(context).textTheme.headline1,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.qrLaunchUrlQuestion +
                          '${scanData.code}?',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FluttifyButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: AppLocalizations.of(context)!.no,
                    width: 80,
                    height: 35),
                FluttifyButton(
                    onPressed: () => launch(scanData.code),
                    text: AppLocalizations.of(context)!.yes,
                    width: 80,
                    height: 35),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.qrCodePlaylistSuccess,
                style: Theme.of(context).textTheme.headline1,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.qrCodePlaylistQuestion +
                          '${scanData.code}?',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                FluttifyButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: AppLocalizations.of(context)!.no,
                    width: 80,
                    height: 35),
                FluttifyButton(
                    onPressed: () => _navigationService.navigateTo(
                        '/edit-playlist',
                        EditPlaylistView(
                          playlistId: scanData.code,
                        ),
                        withNavBar: false),
                    text: AppLocalizations.of(context)!.yes,
                    width: 80,
                    height: 35),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
