import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  UserState userState;
  final TextStyle _headerTextStyle = TextStyle(
    color: ColorSets.profilePageThemeColor,
    fontSize: 16.0,
    backgroundColor: Colors.white,
    height: -2,
    fontWeight: FontWeight.w700,
  );

  final TextStyle _nameTextStyle = TextStyle(
    color: ColorSets.defaultTextColor,
    fontSize: 16.0,
    height: 1.4,
    fontWeight: FontWeight.w500,
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

  Widget _fullName(String name) {
    Widget form;
    if (userState.editMode) {
      var controller = TextEditingController();
      controller.text = name;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
        userState.user.name = controller.value.text;
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
          formWidget(email, 'email'),
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
            formWidget(department, 'department'),
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
          formWidget(year, 'year'),
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

  Widget _studentNumber(String studentnumber) {
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
          formWidget(studentnumber, 'id'),
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

  Widget _phoneNumber(String phonenumber) {
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
          formWidget(phonenumber, 'phone'),
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

  Widget formWidget(formData, String type) {
    Widget form;
    if (userState.editMode) {
      var controller = TextEditingController();
      controller.text = formData;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
        if (type == 'email') {
          userState.user.email = controller.value.text;
        } else if (type == 'department') {
          userState.user.department = Department.cse;
        } else if (type == 'year') {
          userState.user.year = int.parse(controller.value.text);
        } else if (type == 'id') {
          userState.user.studentId = controller.value.text;
        } else if (type == 'phone') {
          userState.user.phone = controller.value.text;
        }
        // TODO: Update related field with this data in every change.
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
                  _fullName(state.user.fullName),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _eMail(state.user.email),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _deparmentInfo(state.user.department.toString()),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _yearInfo(state.user.year.toString()),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _studentNumber(state.user.studentId.toString()),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _phoneNumber(state.user.phone.toString()),
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
    return BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          userState = state;
          if (state is UserUpdate) {
            BlocProvider.of<UserBloc>(context).add(UserUpdate(state.user));
          }
          return buildAll(context, state);
        },
        listener: (context, state) {});
  }
}
