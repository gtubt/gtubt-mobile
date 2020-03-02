import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: ListView(
        padding: const EdgeInsets.all(5),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 30,
            child: Text(
              "Bugün"
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.0),
              child: Stack(children: <Widget>[
                Container( 
                  height: 200,
                  child: FadeInImage.assetNetwork(
                    alignment: Alignment.topCenter, // add this
                    placeholder: 'assets/logo.png',
                    image: 'https://via.placeholder.com/350x120.png',
                    height: 300,
                    fit: BoxFit.fitWidth
                  )
                  ),
                  Positioned(
                    top: 120,
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 320,
                      child: Text(
                        "LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET"
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 30,
            child: Text(
              "Dün"
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.0),
              child: Stack(children: <Widget>[
                Container( 
                  height: 200,
                  child: FadeInImage.assetNetwork(
                    alignment: Alignment.topCenter, // add this
                    placeholder: 'assets/logo.png',
                    image: 'https://via.placeholder.com/350x120.png',
                    height: 300,
                    fit: BoxFit.fitWidth
                  )
                  ),
                  Positioned(
                    top: 120,
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 320,
                      child: Text(
                        "LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET"
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.0),
              child: Stack(children: <Widget>[
                Container( 
                  height: 200,
                  child: FadeInImage.assetNetwork(
                    alignment: Alignment.topCenter, // add this
                    placeholder: 'assets/logo.png',
                    image: 'https://via.placeholder.com/350x120.png',
                    height: 300,
                    fit: BoxFit.fitWidth
                  )
                  ),
                  Positioned(
                    top: 120,
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 320,
                      child: Text(
                        "LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET"
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
