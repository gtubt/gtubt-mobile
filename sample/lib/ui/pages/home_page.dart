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
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(children: <Widget>[
              Container( 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 3
                  ),
                  color: Colors.white,
                ),
                height: 200,
                child: FadeInImage.assetNetwork(
                    alignment: Alignment.topCenter, // add this
                    placeholder: 'assets/logo.png',
                    image: 'https://via.placeholder.com/320x110.png',
                    height: 300,
                  )
                ),
                Positioned(
                  top: 120,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: 350,
                    child: Text(
                      "LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET"
                    ),
                  ),
                ),
              ],
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 30,
            child: Text(
              "Dün"
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(children: <Widget>[
              Container( 
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 3
                  ),
                  color: Colors.white,
                ),
                child: FadeInImage.assetNetwork(
                    alignment: Alignment.topCenter, // add this
                    placeholder: 'assets/logo.png',
                    image: 'https://via.placeholder.com/350x120.png',
                    height: 300,
                  )
                ),
                Positioned(
                  top: 120,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: 350,
                    child: Text(
                      "LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET"
                    ),
                  ),
                ),
              ],
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 30,
            child: Text(
              ""
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(children: <Widget>[
              Container( 
                height: 200,
                color: Colors.white,
                child: FadeInImage.assetNetwork(
                    alignment: Alignment.topCenter, // add this
                    placeholder: 'assets/logo.png',
                    image: 'https://via.placeholder.com/350x120.png',
                    height: 300,
                  )
                ),
                Positioned(
                  top: 120,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: 350,
                    child: Text(
                      "LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET"
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
