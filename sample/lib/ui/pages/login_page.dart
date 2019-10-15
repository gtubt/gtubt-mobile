import 'package:flutter/material.dart';
import 'package:GTUBT/resources/colors.dart';

class LoginPage extends StatefulWidget {
    static String tag = 'login-page';

    @override
    _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    @override
    Widget build(BuildContext context) {
        final logo = Container(
            height: 192,
            width: 192,
            child: Image.asset('assets/logo.png'),
        );

        final email = Container(
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
                                fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: 14,
                            ),
                        ),
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            fillColor: Colors.white,
                            filled: true,
                        ),
                    ),
                ],
            ),
        );

        final password = Container(
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
                                fontFamily: 'Roboto',
                                letterSpacing: 0.5,
                                fontSize: 14,
                            ),
                        ),
                    ),
                    TextFormField(
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                        ),
                    ),
                ],
            ),
        );

        final SignUpOrContinueButton = new Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                    Container(
                        width: 144,
                        height: 56,
                        margin: EdgeInsets.only(bottom: 32),
                        child: RaisedButton(
                            onPressed: () {},
                            color: Color(0xFF7986CB),
                            child: Text('Giriş Yap', style: TextStyle(color: Colors.white)),
                        ),
                    ),
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Container(
                                height: 56,
                                width: 144,
                                child: RaisedButton(
                                    onPressed: () {},
                                    color: Color(0xFF1A237E),
                                    child: Text('Üye Değil Misin?\nKayıt Ol!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white)),
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xFF1A237E),
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                    ),
                                ),
                            ),
                            Container(
                                height: 56,
                                width: 144,
                                child: RaisedButton(
                                    onPressed: () {},
                                    color: Color(0xFF1A237E),
                                    child: Text('Üye Olmadan\nDevam Et',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white)),
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xFF1A237E),
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

        return Scaffold(
            backgroundColor: Color(0xFF1A237E),
            body: Center(
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                        logo,
                        SizedBox(height: 32.0),
                        email,
                        SizedBox(height: 16.0),
                        password,
                        SizedBox(height: 32.0),
                        SignUpOrContinueButton
                    ],
                ),
            ),
        );
    }
}
