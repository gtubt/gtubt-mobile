import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/blocs/page_bloc/bloc.dart';
import 'ui/routes.dart';

void main()  {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PageBloc>(
        builder: (context) => PageBloc(),
        child: MaterialApp(
          title: 'GTU BT',
          theme: ThemeData(
            // These will be customized for general app design
            primarySwatch: Colors.blue,
          ),
          routes: Routes.routes,
          initialRoute: '/',
        )
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
