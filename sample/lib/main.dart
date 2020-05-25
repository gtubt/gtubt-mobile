import 'package:GTUBT/service/authentication/authentication.dart';
import 'package:GTUBT/ui/blocs/register_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'ui/blocs/page_bloc/bloc.dart';
import 'ui/routes.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    OneSignal.shared.init("3f4bf8af-bd07-4353-bdb9-ed92a96908aa", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: true
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageBloc>(
          create: (context) => PageBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authService: _authService),
        )
      ],
      child: MaterialApp(
        title: 'GTU BT',
        theme: ThemeData(
          // These will be customized for general app design
          primarySwatch: Colors.blue,
        ),
        routes: Routes.routes,
        initialRoute: '/',
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
