import 'package:flutter/material.dart';
import 'package:fluttify/app/fluttify_router.router.dart';

import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

Future main() async {
  await DotEnv.load(fileName: "assets/.env");
  setupLocator();
  runApp(Fluttify());
}

class Fluttify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApiService>(
      create: (_) => ApiService(),
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiService _api = locator<ApiService>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<ApiService>(context, listen: false);
    auth.addListener(() {
      if (auth.loggedIn) {
        //   _navigationService.clearStackAndShow(Routes.homeView);
      }
    });

    return FutureBuilder<bool>(
        future: _api.initializeAuthentication(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return MaterialApp(
                title: 'Fluttify',
                theme: ThemeData(
                  //primarySwatch: Colors.grey,
                  //primaryColor: Colors.black,
                  brightness: Brightness.dark,
                  //backgroundColor: const Color.fromARGB(255, 89, 89, 89),
                  //accentColor: Colors.white,
                  //accentIconTheme: IconThemeData(color: Colors.black),
                  //dividerColor: Colors.black12,
                ),
                navigatorKey: StackedService.navigatorKey,
                onGenerateRoute: StackedRouter().onGenerateRoute,
              );
            default:
              return CircularProgressIndicator();
          }
        });
  }
}
