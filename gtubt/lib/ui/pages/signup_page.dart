import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/register_bloc/bloc.dart';
import 'package:GTUBT/ui/style/button_styles.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/decorations.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _studentNumberController =
      TextEditingController();
  Map<String, bool?> _agreements = {
    'kvkk': false,
    'userAgreement': false,
  };
  bool _obscureText = true;
  bool _showPasswordHint = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onEmailChanged);
    _nameController.addListener(_onNameChanged);
    _lastnameController.addListener(_onLastnameChanged);
    _passwordController.addListener(_onPasswordChanged);
    _studentNumberController.addListener(_onStudentNumberChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _studentNumberController.dispose();
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      !_agreements.containsValue(false);

  void _onEmailChanged() {
    context
        .read<RegisterBloc>()
        .add(EmailChanged(email: _emailController.text.trim()));
  }

  void _onPasswordChanged() {
    context
        .read<RegisterBloc>()
        .add(PasswordChanged(password: _passwordController.text.trim()));
  }

  void _onNameChanged() {
    context
        .read<RegisterBloc>()
        .add(NameChanged(name: _nameController.text.trim()));
  }

  void _onLastnameChanged() {
    context
        .read<RegisterBloc>()
        .add(LastnameChanged(lastname: _lastnameController.text.trim()));
  }

  void _onStudentNumberChanged() {
    context.read<RegisterBloc>().add(StudentNumberChanged(
        studentNumber: _studentNumberController.text.trim()));
  }

  void _onFormSubmitted() {
    context.read<RegisterBloc>().add(
          Submitted(
            name: _nameController.text.trim(),
            lastname: _lastnameController.text.trim(),
            password: _passwordController.text.trim(),
            studentNumber: _studentNumberController.text.trim(),
            email: _emailController.text.trim(),
            isAcceptKVKK: _agreements['kvkk'],
            isAcceptUserAgreement: _agreements['userAgreement'],
          ),
        );
  }

  bool isSignUpButtonEnabled() {
    final state = context.read<RegisterBloc>().state;
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  Widget _logoArea() {
    return Column(
      children: [
        Container(
          height: 130,
          width: 130,
          child: Image.asset('assets/logo.png'),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(
            'Become a Member',
            style: TextStyle(
              fontSize: 20,
              color: ColorSets.lightTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _nameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormFieldLabel('Name'),
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(15.0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            keyboardAppearance:
                WidgetsBinding.instance?.window.platformBrightness,
            style: TextStyles.caption,
            controller: _nameController,
            autocorrect: false,
            autofocus: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: FormBoxContainer.loginPageTextFieldDecoration,
            cursorColor: ColorSets.cursorColor,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  Widget _lastnameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormFieldLabel('Surname'),
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(15.0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            keyboardAppearance:
                WidgetsBinding.instance?.window.platformBrightness,
            style: TextStyles.caption,
            controller: _lastnameController,
            autocorrect: false,
            autofocus: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: FormBoxContainer.loginPageTextFieldDecoration,
            cursorColor: ColorSets.cursorColor,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  Widget _emailForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormFieldLabel('Email'),
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(15.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            keyboardAppearance:
                WidgetsBinding.instance?.window.platformBrightness,
            style: TextStyles.caption,
            controller: _emailController,
            autocorrect: false,
            autofocus: false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: FormBoxContainer.loginPageTextFieldDecoration,
            cursorColor: ColorSets.cursorColor,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              Future.delayed(
                  const Duration(milliseconds: 100),
                  () => _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(seconds: 1),
                      curve: Curves.ease));
              FocusScope.of(context).nextFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _passwordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormFieldLabel('Password'),
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    keyboardAppearance:
                        WidgetsBinding.instance?.window.platformBrightness,
                    style: TextStyles.caption,
                    controller: _passwordController,
                    autocorrect: false,
                    autofocus: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: FormBoxContainer.loginPageTextFieldDecoration,
                    cursorColor: ColorSets.cursorColor,
                    obscureText: _obscureText,
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      Future.delayed(
                          const Duration(milliseconds: 100),
                          () => _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(seconds: 1),
                              curve: Curves.ease));
                    },
                    onEditingComplete: () => {
                      context.read<RegisterBloc>().state.isPasswordValid
                          ? FocusScope.of(context).unfocus()
                          : {
                              FocusScope.of(context).unfocus(),
                              setState(() => _showPasswordHint = true),
                            }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, minimumSize: Size(30, 20)),
                      onPressed: () {
                        setState(() => _obscureText = !_obscureText);
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: ColorSets.appMainColor,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, minimumSize: Size(30, 20)),
                      onPressed: !context
                              .read<RegisterBloc>()
                              .state
                              .isPasswordValid
                          ? () {
                              setState(
                                  () => _showPasswordHint = !_showPasswordHint);
                            }
                          : null,
                      child: Icon(
                        context.read<RegisterBloc>().state.isPasswordValid
                            ? Icons.check
                            : Icons.info_outline,
                        color: _passwordController.text.isEmpty
                            ? ColorSets.appMainColor
                            : context.read<RegisterBloc>().state.isPasswordValid
                                ? Colors.green
                                : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _passwordHint() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: _showPasswordHint
          ? !context.read<RegisterBloc>().state.isPasswordValid
              ? Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Requires at least 8 characters with a mixture of upper & lowercase letters, numbers, and special characters.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 12, color: ColorSets.lightTextColor),
                  ),
                )
              : SizedBox(
                  height: 28.0,
                )
          : SizedBox(
              height: 28.0,
            ),
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

  Widget _buildSignUpButton() {
    return Container(
      width: 140,
      height: 50,
      margin: EdgeInsets.only(bottom: 32),
      child: Material(
        color: Colors.transparent,
        elevation: isSignUpButtonEnabled() ? 10 : 0,
        child: ElevatedButton(
          onPressed: isSignUpButtonEnabled() ? () => _onFormSubmitted() : null,
          style: isSignUpButtonEnabled()
              ? ButtonStyles.containedButton
              : ButtonStyles.containedButton.copyWith(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.black.withOpacity(0.2))),
          child: Text(
            'Sign up',
            style: isSignUpButtonEnabled()
                ? TextStyles.subtitle2.copyWith(color: ColorSets.lightTextColor)
                : TextStyles.subtitle2
                    .copyWith(color: ColorSets.lightTextColor.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: 140,
      height: 50,
      margin: EdgeInsets.only(bottom: 32),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyles.outlinedButton,
        child: Text(
          'Already a member? Login',
          style: TextStyles.caption.copyWith(color: ColorSets.lightTextColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCheckBox(String message, type) {
    return Row(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: ColorSets.appMainColor,
            onChanged: (bool? value) {
              setState(() {
                _agreements[type] = value;
              });
            },
            value: _agreements[type],
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(text: 'I have read and agree to the terms of the '),
                TextSpan(
                    text: message,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //Pop-up for corresponding agreements
                      }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          NotificationFactory.loadingFactory(message: 'Registering...')
              .show(context);
        }
        if (state.isSuccess) {
          NotificationFactory.successFactory(message: 'Sign Up Successful')
              .show(context);
          context.read<AuthenticationBloc>().add(LoggedIn(context: context));
        }
        if (state.isFailure) {
          NotificationFactory.errorFactory(message: state.errorMessage)
              .show(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorSets.appMainColor,
            body: SafeArea(
              child: GestureDetector(
                onTap: () {
                  _scrollController.animateTo(
                      _scrollController.position.minScrollExtent,
                      duration: Duration(seconds: 1),
                      curve: Curves.ease);
                  Future.delayed(const Duration(milliseconds: 300),
                      () => FocusScope.of(context).unfocus());
                },
                child: Column(
                  children: [
                    Container(
                      child: _logoArea(),
                      alignment: Alignment.center,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 40.0,
                            right: 40.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _nameForm(),
                              SizedBox(height: 20),
                              _lastnameForm(),
                              SizedBox(height: 20),
                              _emailForm(),
                              SizedBox(height: 20),
                              _passwordForm(),
                              SizedBox(height: 6),
                              _passwordHint(),
                              _buildCheckBox(
                                  'PDPL (KVKK) Information Text', 'kvkk'),
                              _buildCheckBox('User Agreement', 'userAgreement'),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildLoginButton(),
                                  _buildSignUpButton(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
