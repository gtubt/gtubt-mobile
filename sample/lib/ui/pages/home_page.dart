import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/models/view_models/post_view_arguments.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class HomePage extends StatelessWidget {
  Post post1 = new Post(
      title: "title1",
      summary:
          "text1 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      body:
        "text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      coverImageUrl: "https://via.placeholder.com/350x120.png",
      startDate: "05-05-2020");
  Post post2 = new Post(
      title: "title2",
      summary:
          "text2 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      body:
      "text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      coverImageUrl: "https://via.placeholder.com/350x120.png",
      startDate: "04-05-2020");
  Post post3 = new Post(
      title: "title3",
      summary:
          "text3 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      body:
      "text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      coverImageUrl: "https://via.placeholder.com/350x120.png",
      startDate: "04-05-2020");
  Post post4 = new Post(
      title: "title4",
      summary:
          "text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      body:
      "text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      coverImageUrl: "https://via.placeholder.com/350x120.png",
      startDate: "03-05-2020");
  Post post5 = new Post(
      title: "title5",
      summary:
          "text5 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      body:
      "text4 LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET LOREM IPSUM DOLOR SIT AMET",
      coverImageUrl: "https://via.placeholder.com/350x120.png",
      startDate: "02-05-2020");

  void postTapEvent(BuildContext context, Post post, String heroTag) {
    print(post);
    Navigator.pushNamed(context, POST_URL, arguments: PostViewArguments(post, heroTag));
  }

  @override
  Widget build(BuildContext context) {
    List<Post> pageItems = [post1, post2, post3, post4, post5];
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: new ListView.builder(
          itemCount: pageItems.length,
          itemBuilder: (BuildContext ctxt, int index) {
            EdgeInsets cardMargin;
            Widget dayText;
            if (index > 0 &&
                (pageItems[index].startDate ==
                    pageItems[index - 1].startDate)) {
              if (index == pageItems.length - 1)
                cardMargin = EdgeInsets.only(
                    top: 20.0, bottom: 40.0, left: 5.0, right: 5.0);
              else
                cardMargin = EdgeInsets.only(
                    top: 20.0, bottom: 10.0, left: 5.0, right: 5.0);
              dayText = null;
            } else {
              if (index == pageItems.length - 1)
                cardMargin = EdgeInsets.only(
                    top: 50.0, bottom: 40.0, left: 5.0, right: 5.0);
              else
                cardMargin = EdgeInsets.only(
                    top: 50.0, bottom: 10.0, left: 5.0, right: 5.0);
              dayText = Text(
                pageItems[index].startDate,
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            }
            var heroTag = "post-" + index.toString();
            return new Stack(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    height: 30,
                    child: dayText),
                InkWell(
                  child: Container(
                    margin: cardMargin,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius:
                          3.0, // has the effect of softening the shadow
                          spreadRadius:
                          1.0, // has the effect of extending the shadow
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
                        child: Stack(
                          children: <Widget>[
                            Container(
                                height: 200,
                                child: Hero(
                                  child: FadeInImage.assetNetwork(
                                      alignment: Alignment.topCenter, // add this
                                      placeholder: 'assets/logo.png',
                                      image: pageItems[index].coverImageUrl,
                                      height: 300,
                                      fit: BoxFit.fitWidth),
                                  tag: heroTag,
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
                                        pageItems[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(pageItems[index].summary),
                                    ),
                                  ])),
                            ),
                          ],
                        )),
                  ),
                  onTap: () {
                    postTapEvent(context, pageItems[index], heroTag);
                  },
                )
              ],
            );
          }),
    );
  }
}
