import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  List<List<List<String>>> pageItems = [
    [['Bugün'], 
      ['Title1', 'Text1 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET']
    ],
    [['Dün'], 
      ['Title2', 'Text2 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET'],
      ['Title3', 'Text2 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET']
    ],
    [['16 Mayıs'],
      ['Title4', 'Text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET']
    ],
    [['15 Mayıs'],
      ['Title5', 'Text5 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET']
    ]
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
            child: Text(
              pageItems[index][0][0],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 20.0, left: 5.0, right: 5.9),
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
                      child: Stack(children: <Widget>[
                        Container(
                          child: Text(
                            pageItems[index][1][0],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                          pageItems[index][1][1]
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
