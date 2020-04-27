import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  List<List<String>> pageItems = [
    ['Yarın','title1','text1 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET','https://via.placeholder.com/350x120.png'],
    ['Yarın','title2','text2 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET','https://via.placeholder.com/350x120.png'],
    ['Bugün','title3','text3 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET','https://via.placeholder.com/350x120.png'],
    ['Dün','title4','text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET','https://via.placeholder.com/350x120.png'],
    ['25 Nisan','title4','text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET','https://via.placeholder.com/350x120.png'],
    ['25 Nisan','title4','text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET','https://via.placeholder.com/350x120.png']
  ];
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: new ListView.builder(
        itemCount: pageItems.length,
        itemBuilder: (BuildContext ctxt, int index) {
        return new Stack(
          children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 30,
            child: (index > 0 && (pageItems[index][0] == pageItems[index - 1][0])) ?
            null
            :
            Text(
                pageItems[index][0],
                style: TextStyle(fontWeight: FontWeight.bold),
              )
          ),
          Container(
            margin: (index > 0 && (pageItems[index][0] == pageItems[index - 1][0])) ?
            const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 5.0, right: 5.0)
            :
            const EdgeInsets.only(top: 50.0, bottom: 10.0, left: 5.0, right: 5.0),
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
                    image: pageItems[index][3],
                    height: 300,
                    fit: BoxFit.fitWidth
                  )
                  ),
                  Positioned(
                    top: 120,
                    child: Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      width: 320,
                      child: Stack(children: <Widget>[
                        Container(
                          child: Text(
                            pageItems[index][1],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                          pageItems[index][2]
                          ),
                        ),
                        ]
                      )
                    ),
                  ),
                ],
              )
            ),
          ),
        ],
      );
        }
      ),
    );
  }
}
