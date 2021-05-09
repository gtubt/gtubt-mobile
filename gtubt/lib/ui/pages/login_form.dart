import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/login_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/page_bloc/bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/decorations.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/style/button_styles.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  BuildContext _context;
  final _formKey = GlobalKey<FormState>();
  LoginState _currentState;
  bool _obscureText = true;
  Flushbar _notification = NotificationFactory.informationFactory(message: '');

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
    if (_formKey.currentState.validate()) {
      context.read<LoginBloc>().add(
            ForgotPasswordPressed(
              email: context.read<LoginBloc>().emailController.text.trim(),
            ),
          );
    }
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
      margin: EdgeInsets.only(bottom: 6, left: 16),
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
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(15.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: WidgetsBinding.instance.window.platformBrightness,
              style: TextStyles.caption,
              controller: context.read<LoginBloc>().emailController,
              autocorrect: false,
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: FormBoxContainer.loginPageTextFieldDecoration,
              cursorColor: ColorSets.cursorColor,
              textInputAction: TextInputAction.next,
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
          Stack(
            children: <Widget>[
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  keyboardAppearance: WidgetsBinding.instance.window.platformBrightness,
                  style: TextStyles.caption,
                  controller: context.read<LoginBloc>().passwordController,
                  autocorrect: false,
                  autofocus: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: FormBoxContainer.loginPageTextFieldDecoration,
                  cursorColor: ColorSets.cursorColor,
                  obscureText: _obscureText,
                  onEditingComplete: () => {
                    _isLoginButtonEnabled()
                        ? _onFormSubmitted()
                        : FocusScope.of(context).unfocus(),
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: ColorSets.appMainColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return Container(
      width: 150,
      height: 50,
      margin: EdgeInsets.only(bottom: 24),
      child: Material(
        color: Colors.transparent,
        elevation: _isLoginButtonEnabled() ? 10 : 0,
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
          onPressed: _isLoginButtonEnabled()
              ? () => _isLoginButtonEnabled() ? _onFormSubmitted() : null
              : null,
          style: _isLoginButtonEnabled()
              ? ButtonStyles.containedButton
              : ButtonStyles.containedButton.copyWith(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.black.withOpacity(0.2))),
          child: Text(
            'Login',
            style: _isLoginButtonEnabled()
                ? TextStyles.subtitle1.copyWith(color: ColorSets.lightTextColor)
                : TextStyles.subtitle1
                    .copyWith(color: ColorSets.lightTextColor.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordButton() {
    return Container(
      alignment: Alignment.topRight,
      height: 30,
      width: 135,
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        onPressed: _onForgotPasswordPressed,
        style: ButtonStyles.textButton,
        child: Text(
          'Forgot Password',
          textAlign: TextAlign.right,
          style: TextStyles.caption.copyWith(color: ColorSets.lightTextColor),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Container(
      height: 50,
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          context.read<PageBloc>().add(
                PageChanged(context: context, routeName: SIGN_UP_URL),
              );
        },
        style: ButtonStyles.outlinedButton,
        child: Text(
          'Not a Member?\nSign up',
          textAlign: TextAlign.center,
          style: TextStyles.caption.copyWith(color: ColorSets.lightTextColor),
        ),
      ),
    );
  }

  Widget _continueWithAnonymousButton() {
    return Container(
      height: 50,
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              _context, MAIN_URL, (route) => false);
        },
        style: ButtonStyles.outlinedButton,
        child: Text(
          'Continue without signing in',
          textAlign: TextAlign.center,
          style: TextStyles.caption.copyWith(color: ColorSets.lightTextColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state.isSubmitting) {
        _notification.dismiss();
        _notification =
            NotificationFactory.loadingFactory(message: state.loadingMessage);
        _notification.show(context);
      }
      if (state.isSuccess) {
        _notification.dismiss();
        _notification =
            NotificationFactory.successFactory(message: "Login successful");
        _notification.show(context);
        context.read<AuthenticationBloc>().add(LoggedIn(context: context));
      }
      if (state.isPwRequestSent) {
        _notification.dismiss();
        _notification = NotificationFactory.successFactory(
            message: "Password reset mail sent!");
        _notification.show(context);
      }
      if (state.isFailure) {
        _notification.dismiss();
        _notification =
            NotificationFactory.errorFactory(message: state.errorMessage);
        _notification.show(context);
      }
    }, builder: (context, state) {
      _currentState = state;
      _context = context;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              padding: EdgeInsets.only(
                  top: 200, left: 40.0, right: 40.0, bottom: 20),
              children: <Widget>[
                _logoArea(),
                SizedBox(height: 32.0),
                _emailTextFormField(),
                SizedBox(height: 16.0),
                _passwordTextFormField(),
                SizedBox(height: 10.0),
                _forgotPasswordButton(),
                SizedBox(height: 24.0),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _signInButton(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _continueWithAnonymousButton(),
                          _signUpButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
