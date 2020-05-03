import 'package:GTUBT/ui/blocs/login_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginState _currentState;
  LoginBloc _loginBloc;
  String email = '';
  String password = '';

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text.trim()));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text.trim()));
  }

  bool _isLoginButtonEnabled() {
    return _currentState.isFormValid && !_currentState.isSubmitting;
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  Widget _logo() {
    return Container(
      height: 200,
      width: 180,
      child: Image.asset('assets/logo.png'),
    );
  }

  Widget _email() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 2),
            child: Text(
              'Email',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'Palanquin',
                letterSpacing: 0.5,
                fontSize: 12,
              ),
            ),
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            autofocus: false,
            autovalidate: true,
            validator: (val) =>
                !_currentState.isEmailValid ? 'Geçersiz email' : null,
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

  Widget _password() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 2),
            child: Text(
              'Şifre',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontFamily: 'Palanquin',
                letterSpacing: 0.5,
                fontSize: 12,
              ),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            autocorrect: false,
            autofocus: false,
            autovalidate: true,
            obscureText: true,
            validator: (val) =>
                !_currentState.isPasswordValid ? 'Şifre giriniz.' : null,
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

  Widget _signUpOrContinueButton() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 130,
            height: 40,
            margin: EdgeInsets.only(bottom: 32),
            child: RaisedButton(
              onPressed: _isLoginButtonEnabled() ? _onFormSubmitted : null,
              color: ColorSets.selectedBarItemColor,
              child: Text(
                'Giriş Yap',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Palanquin',
                  letterSpacing: 0.5,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 135,
                  child: RaisedButton(
                    onPressed: () {},
                    color: ColorSets.barBackgroundColor,
                    child: Text(
                      'Üye Değil Misin?\nKayıt Ol!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Palanquin',
                        letterSpacing: 0.5,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: ColorSets.barBackgroundColor,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 135,
                  child: RaisedButton(
                    onPressed: () {
                      BlocProvider.of<PageBloc>(context).add(
                        PageChanged(routeName: ROOT_URL, context: context),
                      );
                    },
                    color: ColorSets.barBackgroundColor,
                    child: Text(
                      'Üye Olmadan\nDevam Et',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Palanquin',
                        letterSpacing: 0.5,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: ColorSets.barBackgroundColor,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        _currentState = state;
        return Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 40.0, right: 40.0),
            children: <Widget>[
              _logo(),
              SizedBox(height: 32.0),
              _email(),
              SizedBox(height: 16.0),
              _password(),
              SizedBox(height: 32.0),
              _signUpOrContinueButton()
            ],
          ),
        );
      },
    );
  }
}
