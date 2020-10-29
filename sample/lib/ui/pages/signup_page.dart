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
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  Department _department;
  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _nameController.addListener(_onNameChanged);
    _lastnameController.addListener(_onLastnameChanged);
    _passwordController.addListener(_onPasswordChanged);
    _gradeController.addListener(_onGradeChanged);
    _studentNumberController.addListener(_onStudentNumberChanged);
    _phoneNumberController.addListener(_onPhoneNumberChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _gradeController.dispose();
    _studentNumberController.dispose();
    _phoneNumberController.dispose();
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

  void _onGradeChanged() {
    _registerBloc.add(ClassChanged(year: _gradeController.text.trim()));
  }

  void _onDepartmentChanged(Department newValue) {
    setState(() {
      _department = newValue;
    });
    _registerBloc.add(DepartmentChanged(department: newValue));
  }

  void _onStudentNumberChanged() {
    _registerBloc.add(StudentNumberChanged(
        studentNumber: _studentNumberController.text.trim()));
  }

  void _onPhoneNumberChanged() {
    _registerBloc.add(
        PhoneNumberChanged(phoneNumber: _phoneNumberController.text.trim()));
  }

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
      name: _nameController.text.trim(),
      lastname: _lastnameController.text.trim(),
      phoneNumber: _phoneNumberController.text.trim(),
      password: _passwordController.text.trim(),
      studentNumber: _studentNumberController.text.trim(),
      year: _gradeController.text.trim(),
      department: _department,
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
      height: 150.0,
      decoration: BoxDecoration(
        color: ColorSets.profilePageThemeColor,
      ),
    );
  }

  Widget _profileImage() {
    return Center(
      child: Container(
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
    );
  }

  Widget _nameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "  İsim  ",
            style: _headerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _nameController,
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
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "  Soyisim  ",
            style: _headerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _lastnameController,
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
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "  E-posta  ",
            style: _headerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
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

  Widget _departmentInfoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "  Bölüm  ",
            style: _headerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: DropdownButton<Department>(
            isExpanded: true,
            value: _department,
            icon: Icon(Icons.arrow_downward),
            onChanged: _onDepartmentChanged,
            items: Department.values
                .map<DropdownMenuItem<Department>>((Department value) {
              return DropdownMenuItem<Department>(
                value: value,
                child: Text(value.getString()),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _gradeInfoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "  Sınıf  ",
            style: _headerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _gradeController,
            validator: (String value) {
              return !_registerBloc.state.isGradeValid
                  ? 'Invalid format'
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
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "  Öğrenci No  ",
            style: _headerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _studentNumberController,
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

  Widget _phoneNumberForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "  Telefon No  ",
            style: _headerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            controller: _phoneNumberController,
            validator: (String value) {
              return !_registerBloc.state.isPhoneNumberValid
                  ? 'Invalid format'
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
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "  Parola  ",
            style: _headerTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: TextFormField(
            autovalidate: true,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: _passwordController,
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
      width: 150,
      height: 50,
      margin: EdgeInsets.only(bottom: 32),
      child: RaisedButton(
        onPressed: () => isSignUpButtonEnabled() ? _onFormSubmitted() : null,
        color: ColorSets.selectedBarItemColor,
        child: Text(
          'Hesap Oluştur',
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
                _imageBackground(),
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        _profileImage(),
                        FormBoxContainer(child: _nameForm()),
                        FormBoxContainer(child: _lastnameForm()),
                        FormBoxContainer(child: _emailForm()),
                        FormBoxContainer(child: _departmentInfoForm()),
                        FormBoxContainer(child: _gradeInfoForm()),
                        FormBoxContainer(child: _studentNumberForm()),
                        FormBoxContainer(child: _phoneNumberForm()),
                        FormBoxContainer(child: _passwordForm()),
                        Container(
                          padding: EdgeInsets.fromLTRB(205, 8, 8, 8),
                          child: _createProfileButton(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
