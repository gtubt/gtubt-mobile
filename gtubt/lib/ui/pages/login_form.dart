import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/login_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  BuildContext _context;

  LoginState _currentState;

  @override
  void initState() {
    context.read<LoginBloc>().emailController.addListener(_onEmailChanged);
    context
        .read<LoginBloc>()
        .passwordController
        .addListener(_onPasswordChanged);
    super.initState();
  }

  void _onEmailChanged() {
    context.read<LoginBloc>().add(EmailChanged());
  }

  void _onPasswordChanged() {
    context.read<LoginBloc>().add(PasswordChanged());
  }

  bool _isLoginButtonEnabled() {
    return _currentState.isFormValid && !_currentState.isSubmitting;
  }

  void _onFormSubmitted() {
    context.read<LoginBloc>().add(LoginWithCredentialsPressed());
  }

  void _onForgotPasswordPressed() {
    context.read<LoginBloc>().add(
          ForgotPasswordPressed(
            email: context.read<LoginBloc>().emailController.text.trim(),
          ),
        );
  }

  Widget _logoArea() {
    return Container(
      height: 200,
      width: 180,
      child: Image.asset('assets/logo.png'),
    );
  }

  Widget _buildTextFormFieldLabel(String labelName) {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      child: Text(
        labelName,
        textAlign: TextAlign.left,
        style: TextStyles.caption.copyWith(color: ColorSets.lightTextColor),
      ),
    );
  }

  Widget _emailTextFormField() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTextFormFieldLabel('Email'),
          TextFormField(
            controller: context.read<LoginBloc>().emailController,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            autofocus: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) =>
                !_currentState.isEmailValid ? 'Invalid email!' : null,
            decoration: InputDecoration(
//                hintText: 'Email',
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordTextFormField() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildTextFormFieldLabel('Password'),
          TextFormField(
            controller: context.read<LoginBloc>().passwordController,
            autocorrect: false,
            autofocus: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            validator: (val) =>
                !_currentState.isPasswordValid ? 'Invalid password!' : null,
            decoration: InputDecoration(
//                hintText: 'Password',
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return Container(
      width: 130,
      height: 40,
      margin: EdgeInsets.only(bottom: 32),
      child: RaisedButton(
        onPressed: () {
          if(_isLoginButtonEnabled()){
            Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Logging in...'),
                    Icon(Icons.hourglass_top)
                  ],
                ),
                backgroundColor: ColorSets.snackBarLoadingColor,
              ),
            );
            _onFormSubmitted();
          }
        },
        color: ColorSets.selectedBarItemColor,
        child: Text(
          'Login',
          style: TextStyles.subtitle1.copyWith(color: ColorSets.lightTextColor),
        ),
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return Container(
      alignment: Alignment.topRight,
      height: 15,
      width: 135,
      child: FlatButton(
        onPressed: () => (_currentState.isEmailValid &&
                context.read<LoginBloc>().emailController.text != '')
            ? _onForgotPasswordPressed()
            : null,
        color: ColorSets.barBackgroundColor,
        child: Text(
          'Forgot Password',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontFamily: 'Palanquin',
            letterSpacing: 0.5,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Container(
      height: 45,
      width: 135,
      child: RaisedButton(
        onPressed: () {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Signing up...'),
                    Icon(Icons.hourglass_top)
                  ],
                ),
                backgroundColor: ColorSets.snackBarLoadingColor,
              ),
            );
          context.read<PageBloc>().add(
                PageChanged(context: context, routeName: SIGN_UP_URL),
              );
        },
        color: ColorSets.barBackgroundColor,
        child: Text(
          'Not a Member?\nRegister!',
          textAlign: TextAlign.center,
          style: TextStyles.caption.copyWith(color: ColorSets.lightTextColor),
        ),
      ),
      decoration: BoxDecoration(
        color: ColorSets.barBackgroundColor,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }

  Widget _continueWithAnonymousButton() {
    return Container(
      height: 45,
      width: 135,
      child: RaisedButton(
        onPressed: () {
          context.read<PageBloc>().add(
                PageChanged(routeName: ROOT_URL, context: _context),
              );
        },
        color: ColorSets.barBackgroundColor,
        child: Text(
          'Continue Without Registration',
          textAlign: TextAlign.center,
          style: TextStyles.caption.copyWith(color: ColorSets.lightTextColor),
        ),
      ),
      decoration: BoxDecoration(
        color: ColorSets.barBackgroundColor,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.read<AuthenticationBloc>().add(LoggedIn(context: context));
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Success'),
                    Icon(Icons.verified)
                  ],
                ),
                backgroundColor: ColorSets.snackBarSuccessColor,
              ),
            );
          AuthenticationBloc _authBloc =
              BlocProvider.of<AuthenticationBloc>(context);
          if (_authBloc.isBroadcast)
            BlocProvider.of<AuthenticationBloc>(context)
                .add(LoggedIn(context: context));
        }
        if (state.isPwRequestSent) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Password Reset Mail Sent!'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: ColorSets.snackBarErrorColor,
              ),
            );
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(state.errorMessage),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: ColorSets.snackBarErrorColor,
              ),
            );
        }
      },
      builder: (context, state) {
        _currentState = state;
        _context = context;
        return Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 40.0, right: 40.0),
            children: <Widget>[
              _logoArea(),
              SizedBox(height: 32.0),
              _emailTextFormField(),
              SizedBox(height: 16.0),
              _passwordTextFormField(),
              SizedBox(height: 10.0),
              _forgotPasswordButton(),
              SizedBox(height: 32.0),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _signInButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _signUpButton(),
                        _continueWithAnonymousButton(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
