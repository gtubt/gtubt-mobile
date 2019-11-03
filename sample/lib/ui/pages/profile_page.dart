import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatelessWidget {
  final String _fullname = "İsim Soyisim";
  final String _email = "adsoyad@eposta.com";
  final String _department = "Bilgisayar Mühendsliği";
  final String _year = "3. Sınıf";
  final String _studentnumber = "161044123";
  final String _phonenumber = "+90 5xx xxx xx xx";

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
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30.0,
        child: Text(
          name,
          style: _nameTextStyle,
        ),
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
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              email,
              style: _nameTextStyle,
            ),
          ),
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
            Container(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                department,
                style: _nameTextStyle,
              ),
            ),
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
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              year,
              style: _nameTextStyle,
            ),
          ),
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
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              studentnumber,
              style: _nameTextStyle,
            ),
          ),
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
          Container(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              phonenumber,
              style: _nameTextStyle,
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
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
}
