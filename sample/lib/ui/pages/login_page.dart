import 'package:GTUBT/ui/blocs/login_bloc/bloc.dart';
import 'package:GTUBT/ui/pages/login_form.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorSets.barBackgroundColor,
      body: BlocProvider(
        create: (context) {
          return LoginBloc();
        },
        child: LoginForm(),
      ),
    );
  }
}
