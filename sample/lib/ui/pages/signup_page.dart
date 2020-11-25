import 'dart:ui';

import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/authentication_bloc/bloc.dart';
import 'package:GTUBT/ui/blocs/register_bloc/bloc.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/form_box_container.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _studentNumberController = TextEditingController();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
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
    _registerBloc.add(EmailChanged(email: _emailController.text.trim()));
  }

  void _onPasswordChanged() {
    _registerBloc
        .add(PasswordChanged(password: _passwordController.text.trim()));
  }

  void _onNameChanged() {
    _registerBloc.add(NameChanged(name: _nameController.text.trim()));
  }

  void _onLastnameChanged() {
    _registerBloc
        .add(LastnameChanged(lastname: _lastnameController.text.trim()));
  }

  void _onStudentNumberChanged() {
    _registerBloc.add(StudentNumberChanged(
        studentNumber: _studentNumberController.text.trim()));
  }

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
      name: _nameController.text.trim(),
      lastname: _lastnameController.text.trim(),
      password: _passwordController.text.trim(),
      studentNumber: _studentNumberController.text.trim(),
      email: _emailController.text.trim(),
    ));
  }

  bool isSignUpButtonEnabled() {
    return _registerBloc.state.isFormValid &&
        isPopulated &&
        !_registerBloc.state.isSubmitting;
  }

  final TextStyle _headerTextStyle = TextStyle(
    color: ColorSets.profilePageThemeColor,
    fontSize: 16.0,
    backgroundColor: Colors.white,
    height: -2,
    fontWeight: FontWeight.w700,
  );

  Widget _imageBackground() {
    return Container(
      height: 120.0,
      decoration: BoxDecoration(
        color: ColorSets.profilePageThemeColor,
      ),
    );
  }

  Widget _profileImage() {
    return Stack(
      children: <Widget>[
        Positioned(
            child: _imageBackground(),
        ),
        Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:50),
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // image: DecorationImage(
                    //   image: AssetImage(
                    //     "assets/images/as.jpg"
                    //   ),
                    // ),
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(
                      color: ColorSets.profilePageThemeColor,
                      width: 5,
                    ),
                  ),
                ),
              ]
          ),
        )
      ],
    );
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              color: Colors.white,
              // image: DecorationImage(
              //   image: AssetImage(
              //     "assets/images/as.jpg"
              //   ),
              // ),
              borderRadius: BorderRadius.circular(80),
              border: Border.all(
                color: ColorSets.profilePageThemeColor,
                width: 5,
              ),
            ),
          ),
        ]
      )
    );
  }

  Widget _nameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 25, right:25),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _nameController,
            decoration: FormBoxContainer.textFieldStyle(labelTextStr: "   Name   "),
            validator: (String value) {
              return !_registerBloc.state.isNameValid ? 'Invalid format' : null;
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
        Container(
          padding: EdgeInsets.only(left: 25, right:25, top: 20),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _lastnameController,
            decoration: FormBoxContainer.textFieldStyle(labelTextStr: "   Surname   "),
            validator: (String value) {
              return !_registerBloc.state.isLastnameValid
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
        Container(
          padding: EdgeInsets.only(left: 25, right:25, top: 20),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: FormBoxContainer.textFieldStyle(labelTextStr: "   E-mail   "),
            validator: (String value) {
              return !_registerBloc.state.isEmailValid
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
        Container(
          padding: EdgeInsets.only(left: 25, right:25, top: 20),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _studentNumberController,
            decoration: FormBoxContainer.textFieldStyle(labelTextStr: "   Student Number   "),
            validator: (String value) {
              return !_registerBloc.state.isStudentNumberValid
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
        Container(
          padding: EdgeInsets.only(left: 25, right:25, top: 20),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: _passwordController,
            decoration: FormBoxContainer.textFieldStyle(labelTextStr: "   Password   "),
            validator: (String value) {
              return !_registerBloc.state.isPasswordValid
                  ? 'Invalid format'
                  : null;
            },
          ),
        ),
      ],
    );
  }

  Widget _createProfileButton() {
    return Container(
      width: 200,
      height: 50,
      margin: EdgeInsets.only(bottom: 32),
      child: RaisedButton(
        onPressed: () => isSignUpButtonEnabled() ? _onFormSubmitted() : null,
        color: ColorSets.selectedBarItemColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontFamily: 'Palanquin',
            letterSpacing: 0.5,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registering...'),
                    CircularProgressIndicator()
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(LoggedIn(context: context));
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registration Failure...'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: ColorSets.snackBarErrorColor,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Scaffold(

            body: Stack(
              children: <Widget>[

                SafeArea(

                  child: SingleChildScrollView(

                    child: Column(
                      children: <Widget>[
                         _profileImage(),
                        _nameForm(),
                        _lastnameForm(),
                        _emailForm(),
                        _studentNumberForm(),
                        _passwordForm(),
                        Container(
                          padding: EdgeInsets.only(left: 205, top: 20, right: 25),
                          child: _createProfileButton(),
                        ),
                      ],
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
