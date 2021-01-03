import 'package:GTUBT/ui/blocs/user_bloc/bloc.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  final String _fullname = "İsim Soyisim";
  final String _email = "adsoyad@eposta.com";
  final String _department = "Bilgisayar Mühendsliği";
  final String _year = "3. Sınıf";
  final String _studentnumber = "161044123";
  final String _phonenumber = "+90 5xx xxx xx xx";

  bool _editMode = false;

  final TextStyle _headerTextStyle = TextStyles.subtitle1.copyWith(height: -2, color: ColorSets.profilePageThemeColor);
  final TextStyle _nameTextStyle = TextStyles.subtitle2.copyWith(height: 1.4, color: ColorSets.defaultTextColor);

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
    if (_editMode) {
      var controller = TextEditingController();
      controller.text = name;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
      });
      form = TextFormField(controller: controller, textAlign: TextAlign.center,);
    } else {
      form = Text(
        name,
        style: _nameTextStyle,
      );
    }

    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 32.0, right: 32.0),
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
          formWidget(email),
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
            formWidget(department),
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
          formWidget(year),
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
          formWidget(studentnumber),
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
          formWidget(phonenumber),
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

  Widget formWidget(formData) {
    Widget form;
    if (_editMode) {
      var controller = TextEditingController();
      controller.text = formData;
      controller.addListener(() {
        final text = controller.text;
        controller.value = controller.value.copyWith(text: text);
        // TODO: Update related field with this data in every change.
      });
      form = TextFormField(controller: controller, );
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
    _editMode = state.editMode;
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
                  _fullName(_fullname),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _eMail(_email),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _deparmentInfo(_department),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _yearInfo(_year),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _studentNumber(_studentnumber),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: _phoneNumber(_phonenumber),
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
          _editMode = state.editMode;
          return buildAll(context, state);
        },
        listener: (context, state) {});
  }
}
