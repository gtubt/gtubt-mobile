import 'package:GTUBT/models/news.dart';
import 'package:GTUBT/models/view_models/news_view_arguments.dart';
import 'package:GTUBT/ui/blocs/news_bloc/bloc.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/notification.dart';
import 'package:GTUBT/ui/utils/time_ago_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NewsBloc>().add(FetchNews());
    super.initState();
  }

  void newsTapEvent(BuildContext context, News news, String heroTag) {
    Navigator.pushNamed(context, POST_URL,
        arguments: NewsViewArguments(news, heroTag));
  }

  EdgeInsets calculateNewsItemMargin(int index, List<News?>? items) {
    EdgeInsets cardMargin;
    if (index > 0 &&
        (items?[index]?.startDate == items?[index - 1]?.startDate)) {
      if (index == items!.length - 1) {
        cardMargin = EdgeInsets.only(
          top: 20.0,
          bottom: 40.0,
          left: 5.0,
          right: 5.0,
        );
      } else {
        cardMargin = EdgeInsets.only(
          top: 20.0,
          bottom: 10.0,
          left: 5.0,
          right: 5.0,
        );
      }
    } else {
      if (index == items!.length - 1) {
        cardMargin = EdgeInsets.only(
          top: 50.0,
          bottom: 40.0,
          left: 5.0,
          right: 5.0,
        );
      } else {
        cardMargin = EdgeInsets.only(
          top: 50.0,
          bottom: 10.0,
          left: 5.0,
          right: 5.0,
        );
      }
    }
    return cardMargin;
  }

  Widget? getDayText(int index, List<News?>? items) {
    Widget? dayText;

    if (index == 0 ||
        (items?[index]?.startDate != items?[index - 1]?.startDate)) {
      dayText = Text(
        TimeAgoFormatter(items?[index]?.startDate).toString(),
        style: TextStyles.subtitle2.copyWith(color: ColorSets.defaultTextColor),
      );
    }

    return dayText;
  }

  Widget buildHomePage(BuildContext context, List<News?>? newsItems) {
    return RefreshIndicator(
      onRefresh: () async {
        newsItems = [];
        BlocProvider.of<NewsBloc>(context).add(
          FetchNews(),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView.builder(
            itemCount: newsItems!.length,
            itemBuilder: (BuildContext ctxt, int index) {
              EdgeInsets cardMargin = calculateNewsItemMargin(index, newsItems);
              Widget? dayText = getDayText(index, newsItems);

              var heroTag = "news-" + index.toString();

              return Stack(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(top: 20.0, left: 11),
                      height: 30,
                      child: dayText),
                  NewsItem(
                    cardMargin: cardMargin,
                    heroTag: heroTag,
                    onTapEvent: newsTapEvent,
                    item: newsItems?[index],
                  )
                ],
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state.isFailed) {
          NotificationFactory.errorFactory(message: state.errorMessage)
            ..show(context);
        }
      },
      buildWhen: (previous, current) {
        return !(previous.isLoaded && current.isFailed);
      },
      builder: (context, state) {
        Widget body = Container();

        if (state.isInitial || state.isLoading) {
          body = Center(child: CircularProgressIndicator());
        } else if (state.isLoaded) {
          body = buildHomePage(context, state.newsList);
        }
        return body;
      },
    );
  }
}
