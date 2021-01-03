import 'package:GTUBT/models/post.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final EdgeInsets cardMargin;
  final BorderRadius _borderRadius = BorderRadius.circular(20);
  final Post item;
  final dynamic onTapEvent;
  final String heroTag;

  PostItem({
    @required this.cardMargin,
    @required this.item,
    @required this.onTapEvent,
    @required this.heroTag,
  });

  Widget buildPostItemPicturePart() {
    return Container(
      height: 200,
      child: Hero(
        child: FadeInImage.assetNetwork(
            alignment: Alignment.topCenter,
            // add this
            placeholder: 'assets/logo.png',
            image: item.coverImageUrl,
            height: 300,
            fit: BoxFit.fitWidth),
        tag: heroTag,
      ),
    );
  }

  Widget buildPostItemDescriptionPart() {
    return Positioned(
      top: 130,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        width: 320,
        child: Stack(
          children: <Widget>[
            Container(
              child: Text(
                item.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(item.summary),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: cardMargin,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
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
            borderRadius: _borderRadius,
            child: Stack(
              children: <Widget>[
                buildPostItemPicturePart(),
                buildPostItemDescriptionPart()
              ],
            )),
      ),
      onTap: () {
        onTapEvent(context, item, heroTag);
      },
    );
  }
}
