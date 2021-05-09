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
  final Map<String, bool> _aggrements = {
    'kvkk': false,
    'userAgreement': false,
  };

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
      _studentNumberController.text.isNotEmpty;

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
            isAcceptKVKK: _aggrements['kvkk'],
            isAcceptUserAgreement: _aggrements['userAgreement'],
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
          height: 160,
          width: 180,
          child: Image.asset('assets/logo.png'),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Text(
            'Create an Accout',
            style: TextStyle(
              fontSize: 18,
              color: ColorSets.lightTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }

  Widget _nameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormFieldLabel('Name'),
        Container(
          child: TextFormField(
            cursorColor: Colors.white,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _nameController,
            decoration: FormInputDecoration(),
            validator: (String value) {
              return !context.read<RegisterBloc>().state.isNameValid
                  ? 'Invalid format'
                  : null;
            },
          ),
        )
      ],
    );
  }

  Widget _lastnameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormFieldLabel('Surname'),
        Container(
          child: TextFormField(
            cursorColor: Colors.white,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _lastnameController,
            decoration: FormInputDecoration(),
            validator: (String value) {
              return !context.read<RegisterBloc>().state.isLastnameValid
                  ? 'Invalid format'
                  : null;
            },
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
        Container(
          child: TextFormField(
            cursorColor: Colors.white,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: FormInputDecoration(),
            validator: (String value) {
              return !context.read<RegisterBloc>().state.isEmailValid
                  ? 'Invalid Email Format'
                  : null;
            },
          ),
        ),
      ],
    );
  }

  Widget _studentNumberForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormFieldLabel('Student Number'),
        Container(
          child: TextFormField(
            cursorColor: Colors.white,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _studentNumberController,
            decoration: FormInputDecoration(),
            validator: (String value) {
              return !context.read<RegisterBloc>().state.isStudentNumberValid
                  ? 'Invalid Student Number'
                  : null;
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
        Container(
          child: TextFormField(
            cursorColor: Colors.white,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: _passwordController,
            decoration: FormInputDecoration(),
            validator: (String value) {
              return !context.read<RegisterBloc>().state.isPasswordValid
                  ? 'Invalid format'
                  : null;
            },
          ),
        ),
      ],
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

  Widget _buildSignUpButton() {
    return Container(
      width: 130,
      height: 40,
      margin: EdgeInsets.only(bottom: 32),
      child: ElevatedButton(
        onPressed: () => isSignUpButtonEnabled() ? _onFormSubmitted() : null,
        style: ButtonStyles.containedButton,
        child: Text(
          'Create Account',
          style: TextStyles.subtitle2.copyWith(color: ColorSets.lightTextColor),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: 130,
      height: 40,
      margin: EdgeInsets.only(bottom: 32),
      child: ElevatedButton(
        onPressed: () => isSignUpButtonEnabled() ? _onFormSubmitted() : null,
        style: ButtonStyles.outlinedButton,
        child: Text(
          'Have an Account? Login',
          style: TextStyles.subtitle2.copyWith(color: ColorSets.lightTextColor),
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
            onChanged: (bool value) {
              setState(() {
                _aggrements[type] = value;
              });
            },
            value: _aggrements[type],
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
            ),
            overflow: TextOverflow.fade,
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
          return NotificationFactory.errorFactory(message: state.errorMessage)
              .show(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorSets.appMainColor,
            body: Stack(
              children: <Widget>[
                SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                      child: Column(
                        children: <Widget>[
                          _logoArea(),
                          SizedBox(height: 20),
                          _nameForm(),
                          SizedBox(height: 32),
                          _lastnameForm(),
                          SizedBox(height: 32),
                          _emailForm(),
                          SizedBox(height: 32),
                          _studentNumberForm(),
                          SizedBox(height: 32),
                          _passwordForm(),
                          SizedBox(height: 32),
                          _buildCheckBox(
                              'KVKK Aydınlatma Metni’ni okudum ve kabul ediyorum.',
                              'kvkk'),
                          _buildCheckBox(
                              'Kullanıcı Sözleşmesi’ni okudum ve kabul ediyorum.',
                              'userAgreement'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 20, right: 10),
                                child: _buildLoginButton(),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10, top: 20, right: 10),
                                child: _buildSignUpButton(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
