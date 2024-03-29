import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/time_ago_formatter.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/news.dart';
import 'package:GTUBT/models/view_models/news_view_arguments.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPage createState() => _NewsPage();
}

class _NewsPage extends State<NewsPage> {
  Widget buildBody(News news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            TimeAgoFormatter(news.startDate).toString(),
            style: TextStyles.subtitle2
                .copyWith(color: ColorSets.defaultTextColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            news.body!,
            style: TextStyles.subtitle2
                .copyWith(color: ColorSets.defaultTextColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    NewsViewArguments newsArgs =
        ModalRoute.of(context)!.settings.arguments as NewsViewArguments;
    var news = newsArgs.news;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(news.title!,
                        style: TextStyles.subtitle1
                            .copyWith(color: ColorSets.lightTextColor)),
                    background: Hero(
                      tag: newsArgs.heroTag,
                      child: Image.network(
                        news.coverImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stacktrace) {
                          return Image.asset(
                            "assets/dummy.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )),
              ),
            ];
          },
          body: buildBody(news),
        ),
      ),
    );
  }
}
