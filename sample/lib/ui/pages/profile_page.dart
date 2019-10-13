import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:GTUBT/main.dart';

class ProfilePage extends StatelessWidget {
  final String _fullname = "İsim Soyisim";
  final String _email = "adsoyad@eposta.com";
  final String _department = "Bilgisayar Mühendsliği";
  final String _year = "3. Sınıf";
  final String _studentnumber = "161044123";
  final String _phonenumber = "+90 5xx xxx xx xx";

  TextStyle _headerTextStyle = TextStyle(
    color: Color(0xFF4E72CB),
    fontSize: 16.0,
    backgroundColor: Colors.white,
    height: -2,
    fontWeight: FontWeight.w700,
  );

  TextStyle _nameTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    height: 1.4,
    fontWeight: FontWeight.w500,
  );

  Widget _Imagebackground() {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
        color: Color(0xFF4E72CB),
      ),
    );
  }

  Widget _ProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          // image: DecorationImage(
          //   image: AssetImage(
          //     "assets/images/as.jpg"
          //   ),
          // ),
          borderRadius: BorderRadius.circular(80),
          border: Border.all(
            color: Color(0xFF4E72CB),
            width: 5,
          ),
        ),
      ),
    );
  }

  Widget _FullName(String name) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 30.0,
          child: Text(
            name,
            style: _nameTextStyle,
          ),
        )
      )
    );
  }

  Widget _Email(String email){
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "  E-posta  ",
                style: _headerTextStyle,
              ),
            ),
            Padding(
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
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF4E72CB),
          width: 4.0,
        ),
      ),
    );
  }

  Widget _Department(String department){
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "  Bölüm  ",
                style: _headerTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
              department,
              style: _nameTextStyle,
              ),
            ),
          ]
        ),
      width: 350.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF4E72CB),
          width: 4.0,
        ),
      ),
    );
  }

    Widget _Year(String year){
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "  Sınıf  ",
                style: _headerTextStyle,
              ),
            ),
            Padding(
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
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF4E72CB),
          width: 4.0,
        ),
      ),
    );
  }

    Widget _StudentNumber(String studentnumber){
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "  Öğrenci No  ",
                style: _headerTextStyle,
              ),
            ),
            Padding(
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
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF4E72CB),
          width: 4.0,
        ),
      ),
    );
  }

    Widget _PhoneNumber(String phonenumber){
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "  Telefon No  ",
                style: _headerTextStyle,
              ),
            ),
            Padding(
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
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF4E72CB),
          width: 4.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      _Imagebackground(),
      SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
              _ProfileImage(),
              _FullName(_fullname),
              new Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _Email(_email),
                ),
              ),
            new Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _Department(_department),
              ),
            ),
            new Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _Year(_year),
              ),
            ),
            new Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _StudentNumber(_studentnumber),
              ),
            ),
            new Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _PhoneNumber(_phonenumber),
              ),
            ),
          ],
        ),
      ))
    ]));
  }
}
