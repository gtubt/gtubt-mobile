import 'dart:async';

import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_bloc.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/calendar_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/news_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/register_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:uni_links/uni_links.dart';
import 'ui/blocs/page_bloc/bloc.dart';
import 'ui/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocDelegate();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorSets.appMainColor,
      statusBarBrightness: Brightness.dark));

  runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late StreamSubscription _sub;

  @override
  initState() {
    super.initState();

    initUniLinks();
  }

  @override
  dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc()..add(AppStarted()),
        ),
        BlocProvider<PageBloc>(
          create: (context) => PageBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(),
        ),
        BlocProvider<AppbarBloc>(
          create: (context) => AppbarBloc(),
        ),
        BlocProvider<CalendarPageBloc>(
          create: (context) => CalendarPageBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'GTU BT',
        theme: ThemeData(
          // These will be customized for general app design
          primarySwatch: Colors.blue,
          primaryColor: ColorSets.lightTextColor,
        ),
        routes: Routes.routes,
        initialRoute: ROOT_URL,
      ),
    );
  }

  Future<void> setLink(Uri? uri, String link) async {
    print('initial uri: ${uri!.path} ${uri.queryParametersAll} $link');
    // TODO: Push with custom link
    // Navigator.push()
  }

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) async {
      if (!mounted) return;
      await setLink(uri, uri.toString());
    }, onError: (err) async {
      if (!mounted) return;
      await setLink(Uri(), 'Failed to get latest link: $err.');
    });

    // Get the latest Uri
    Uri initialUri = Uri();
    String initialLink;

    try {
      initialUri = (await getInitialUri())!;
      initialLink = initialUri.toString();
    } on PlatformException {
      initialLink = 'Failed to get initial uri.';
    } on FormatException {
      initialLink = 'Bad parse the initial link as Uri.';
    }

    if (!mounted) return;
    await setLink(initialUri, initialLink);
  }
}

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
