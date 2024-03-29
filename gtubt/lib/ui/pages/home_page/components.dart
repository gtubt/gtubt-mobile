import 'package:GTUBT/models/news.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final EdgeInsets cardMargin;
  final BorderRadius _borderRadius = BorderRadius.circular(20);
  final News? item;
  final dynamic onTapEvent;
  final String heroTag;

  NewsItem({
    required this.cardMargin,
    required this.item,
    required this.onTapEvent,
    required this.heroTag,
  });

  Widget buildNewsItemPicturePart() {
    return Container(
      height: 160,
      width: 400,
      child: Hero(
        child: FadeInImage.assetNetwork(
          alignment: Alignment.topCenter,
          // add this
          placeholder: 'assets/logo.png',
          image: item!.coverImageUrl!,
          height: 150,
          fit: BoxFit.fill,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/dummy.png");
          },
        ),
        tag: heroTag,
      ),
    );
  }

  Widget buildNewsItemDescriptionPart() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 320,
      height: 80,
      child: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 10, top: 10),
              child: Text(
                item!.title!,
                style: TextStyles.subtitle1
                    .copyWith(color: ColorSets.defaultTextColor),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 2, top: 34, bottom: 10),
            child: Text(
              item!.summary!,
              style: TextStyles.bodyText2
                  .copyWith(color: ColorSets.defaultTextColor),
            ),
          ),
        ],
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
              blurRadius: 4.0, // has the effect of softening the shadow
              spreadRadius: 0.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                4.0, // vertical, move down 10
              ),
            )
          ],
          color: Colors.white,
        ),
        child: ClipRRect(
            borderRadius: _borderRadius,
            child: Column(
              children: [
                buildNewsItemPicturePart(),
                buildNewsItemDescriptionPart()
              ],
            )),
      ),
      onTap: () {
        onTapEvent(context, item, heroTag);
      },
    );
  }
}
