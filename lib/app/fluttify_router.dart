import 'package:fluttify/ui/views/home_view.dart';
import 'package:fluttify/ui/views/sign_in_views/sign_in_view.dart';
import 'package:stacked/stacked_annotations.dart';

// gr Datei wird automatisch neu gebuilded, falls nicht
// 'flutter packages pub run build_runner build' ausführen
// Fehler treten in der gr Datei bei den homeviewroutes auf, kein Plan wieso,
// einfach bei dem string nach dem '/' was hinschreiben (anscheinend egal was)

@StackedApp(
  routes: <StackedRoute<dynamic>>[
    MaterialRoute<dynamic>(page: SignInView, initial: true),
    MaterialRoute<dynamic>(page: HomeView)
  ],
)
class $FluttifyRouter {}