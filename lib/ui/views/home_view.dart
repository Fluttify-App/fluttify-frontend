import 'package:flutter/material.dart';
import 'package:fluttify/app/fluttify_router.gr.dart';
import 'package:fluttify/ui/views/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:auto_route/auto_route.dart' as router;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (BuildContext context, HomeViewModel model, Widget child) =>
      Scaffold(
        body: router.ExtendedNavigator<HomeViewRouter>(
            router: HomeViewRouter(),
            navigatorKey: StackedService.nestedNavigationKey(1)),
        bottomNavigationBar: Theme(
          data: ThemeData(primaryColor: Colors.black),
          child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 20, 20, 20),
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            fixedColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                label: 'Playlists',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Add Playlist',
                icon: Icon(Icons.add),
              ),
              BottomNavigationBarItem(
                  label: 'Friends',
                  icon: Icon(Icons.favorite)
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}