import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Container(
        height: 200,
        width: 180,
        child: Image.asset('assets/logo.png'),
      );
    }

    Widget _email() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 2),
              child: Text(
                'Email',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Palanquin',
                  letterSpacing: 0.5,
                  fontSize: 12,
                ),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
//                hintText: 'Email',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ],
        ),
      );
    }

    Widget _password() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 2),
              child: Text(
                'Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Palanquin',
                  letterSpacing: 0.5,
                  fontSize: 12,
                ),
              ),
            ),
            TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
//                hintText: 'Password',
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ],
        ),
      );
    }

    Widget _SignUpOrContinueButton() {
      return Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 130,
              height: 40,
              margin: EdgeInsets.only(bottom: 32),
              child: RaisedButton(
                onPressed: () {},
                color: ColorSets.selectedBarItemColor,
                child: Text(
                  'Giriş Yap',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Palanquin',
                    letterSpacing: 0.5,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 135,
                    child: RaisedButton(
                      onPressed: () {},
                      color: ColorSets.barBackgroundColor,
                      child: Text(
                        'Üye Değil Misin?\nKayıt Ol!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Palanquin',
                          letterSpacing: 0.5,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: ColorSets.barBackgroundColor,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 135,
                    child: RaisedButton(
                      onPressed: () {},
                      color: ColorSets.barBackgroundColor,
                      child: Text(
                        'Üye Olmadan\nDevam Et',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Palanquin',
                          letterSpacing: 0.5,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: ColorSets.barBackgroundColor,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                ]),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorSets.barBackgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            _logo(),
            SizedBox(height: 32.0),
            _email(),
            SizedBox(height: 16.0),
            _password(),
            SizedBox(height: 32.0),
            _SignUpOrContinueButton()
          ],
        ),
      ),
    );
  }
}
