import 'package:flutter/material.dart';
import 'package:fluttify/app/locator.dart';
import 'package:fluttify/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:provider/provider.dart';
import 'app/fluttify_router.gr.dart';
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: FluttifyRouter(),
    );
  }
}
