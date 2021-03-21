import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_bloc.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  UserBloc _userBloc;
  AppbarBloc _appbarBloc;

  final TextStyle _headerTextStyle = TextStyles.subtitle1
      .copyWith(height: -2, color: ColorSets.profilePageThemeColor);
  final TextStyle _nameTextStyle = TextStyles.subtitle2
      .copyWith(height: 1.4, color: ColorSets.defaultTextColor);

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
        style: _nameTextStyle,
      );
    }

    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 32.0, right: 32.0),
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
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "  E-posta  ",
              style: _headerTextStyle,
            ),
          ),
          formWidget(EmailChanged(), email),
        ],
      ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _deparmentInfo(String department) {
    //TODO: must be dropdown
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "  Bölüm  ",
                style: _headerTextStyle,
              ),
            ),
            formWidget(DepartmentChanged(), department),
          ]),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _yearInfo(String year) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "  Sınıf  ",
              style: _headerTextStyle,
            ),
          ),
          formWidget(YearChanged(), year),
        ],
      ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _studentNumber(String studentId) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "  Öğrenci No  ",
              style: _headerTextStyle,
            ),
          ),
          formWidget(StudentNumberChanged(), studentId),
        ],
      ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget _phoneNumber(String phone) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              "  Telefon No  ",
              style: _headerTextStyle,
            ),
          ),
          formWidget(PhoneChanged(), phone),
        ],
      ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: ColorSets.defaultBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorSets.profilePageThemeColor,
          width: 4.0,
        ),
      ),
    );
  }

  Widget formWidget(UserEvent field, formData) {
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
      );
    } else {
      form = Text(formData, style: _nameTextStyle);
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 25),
        child: form,
      ),
    );
  }

  Widget buildAll(BuildContext context, UserState state) {
    User user = _userBloc.userService.currentUser;
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
                  _fullName(user.fullName),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _eMail(user.email),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _deparmentInfo(user.department.toString()),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _yearInfo(user.year.toString()),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _studentNumber(user.studentId),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _phoneNumber(user.phone),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _userBloc = BlocProvider.of<UserBloc>(context);
    _appbarBloc = BlocProvider.of<AppbarBloc>(context);
    return BlocBuilder<AppbarBloc, AppbarState>(
      builder: (context, state) {
        return BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state.isFailure) {
              NotificationFactory.errorFactory(message: state.errorMessage)
                  .show(context);
            }
          },
          builder: (context, state) {
            if (!state.isFailure) {
              return buildAll(context, state);
            } else {
              return Scaffold();
            }
          },
        );
      },
    );
  }
}
