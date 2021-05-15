import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttify/ui/views/playlists_views/playlist_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:fluttify/services/api_service.dart';

class PlaylistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<ApiService>(context);

    return ViewModelBuilder<PlaylistViewModel>.reactive(
      builder: (BuildContext context, PlaylistViewModel model, Widget child) =>
          Scaffold(
              body: Center(
                  child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => auth.logoutBackend(),
            child: Text("Logout",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w900)),
          ),
        ],
      ))),
      viewModelBuilder: () => PlaylistViewModel(),
    );
  }
}
