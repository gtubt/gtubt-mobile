import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_bloc.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTUBT/ui/style/form_box_container.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  UserBloc _userBloc;
  final GlobalKey<FormState> _passwordFieldKey = GlobalKey<FormState>();
  AppbarBloc _appbarBloc;
  double _width;

  final TextStyle _headerTextStyle = TextStyles.subtitle1
      .copyWith(height: -2, color: ColorSets.profilePageThemeColor);
  final TextStyle _nameTextStyle = TextStyles.subtitle1.copyWith(
      height: 1.4,
      color: ColorSets.defaultTextColor,
      letterSpacing: 0,
      fontWeight: FontWeight.w500);

  Widget _imageBackground() {
    return Container(
      height: 120.0,
      decoration: BoxDecoration(
        color: ColorSets.profilePageThemeColor,
      ),
    );
  }

  Widget _profileImage() {
    double _iconSize = 140;
    return Positioned(
      top: 50,
      child: Card(
        elevation: 8.0,
        child: Icon(
          Icons.account_circle,
          color: ColorSets.profilePageThemeColor,
          size: _iconSize,
        ),
      ),
    );
  }

  Widget _fullName(String name) {
    Widget form;
    if (_appbarBloc.state.editMode) {
      var controller = TextEditingController();
      controller.text = name;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
      });
      form = TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
      );
    } else {
      form = Text(
        name,
        textAlign: TextAlign.center,
        style: _nameTextStyle,
      );
    }

    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 50.0, right: 50.0),
      child: Container(
        height: 30.0,
        child: form,
      ),
    );
  }

  Widget _eMail(String email) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: formWidget(EmailChanged(), email, "E-mail"),
          ),
        ],
      ),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _deparmentInfo(String department) {
    //TODO: must be dropdown
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: formWidget(DepartmentChanged(), department, "Department"),
            ),
          ]),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _yearInfo(String year) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: formWidget(YearChanged(), year, "Year"),
          ),
        ],
      ),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _studentNumber(String studentId) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: formWidget(StudentNumberChanged(), studentId, "Student ID"),
          ),
        ],
      ),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget _phoneNumber(String phone) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: formWidget(PhoneChanged(), phone, "Phone"),
          ),
        ],
      ),
      width: 350.0,
      height: 60.0,
    );
  }

  Widget formWidget(UserEvent field, formData, fieldName) {
    Widget form;
    if (_appbarBloc.state.editMode) {
      TextEditingController controller = _userBloc.textEditingController(field);
      controller.text = formData;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
        _userBloc.add(field);
      });
      form = TextFormField(
        controller: controller,
        readOnly: !_userBloc.state.editMode,
        decoration: FormBoxContainer.textFieldStyle(
            labelTextStr: "  " + fieldName + "  "),
      );
    } else {
      form = TextFormField(
        controller: null,
        readOnly: !_userBloc.state.editMode,
        enabled: false,
        initialValue: formData,
        decoration: FormBoxContainer.textFieldStyle(
            labelTextStr: "  " + fieldName + "  "),
      );
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: form,
      ),
    );
  }

  Widget accountDeletionDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: ColorSets.popUpColor,
      elevation: 40,
      child: Container(
          height: 236,
          width: 600,
          padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
          child: Column(
            children: [
              Text("To delete your account please enter your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
              SizedBox(height: 15),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Form(
                      key: _passwordFieldKey,
                      child: TextFormField(
                        controller: _userBloc.passwordController,
                        obscureText: true,
                        validator: (value) {
                          return !_userBloc.state.passwordsMatch
                              ? 'Passwords doesn\'t match'
                              : null;
                        },
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15.0),
                          enabledBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: ColorSets.barBackgroundColor,
                    textColor: ColorSets.lightTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text("Cancel"),
                  ),
                  SizedBox(width: 20),
                  RaisedButton(
                    onPressed: () {
                      _userBloc.add(OnAccountDeletion(context: context));
                      _passwordFieldKey.currentState.validate();
                    },
                    color: ColorSets.profilePageThemeColor,
                    textColor: ColorSets.lightTextColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: ColorSets.lightTextColor)),
                    child: const Text("Delete Account"),
                  )
                ]),
              )
            ],
          )),
    );
  }

  Widget buildAll(BuildContext context, UserState state) {
    User user = _userBloc.userService.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            _imageBackground(),
            _profileImage(),
            SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                  ),
                  _fullName(user.fullName),
                  Container(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 5.0),
                    child: _eMail(user.email),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: _deparmentInfo(user.department.toString()),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: _yearInfo(user.year.toString()),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: _studentNumber(user.studentId),
                  ),
                  Container(
                    child: _phoneNumber(user.phone),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.only(bottom: 5.0, right: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 32,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              _userBloc.passwordController.clear();
                              return accountDeletionDialog(context);
                            });
                        //_userBloc.userService.delete(user.email);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _appbarBloc = BlocProvider.of<AppbarBloc>(context);
    _width = MediaQuery.of(context).size.width;
    return BlocBuilder<AppbarBloc, AppbarState>(
      builder: (context, state) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return buildAll(context, state);
          },
        );
      },
    );
  }
}
