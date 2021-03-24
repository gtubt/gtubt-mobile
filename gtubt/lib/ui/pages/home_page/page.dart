import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/models/view_models/post_view_arguments.dart';
import 'package:GTUBT/ui/blocs/post_bloc/post_bloc.dart';
import 'package:GTUBT/ui/blocs/post_bloc/post_event.dart';
import 'package:GTUBT/ui/blocs/post_bloc/post_state.dart';
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
     BlocProvider.of<PostBloc>(context).add(FetchPosts());
    super.initState();
  }

  void postTapEvent(BuildContext context, Post post, String heroTag) {
    Navigator.pushNamed(context, POST_URL,
        arguments: PostViewArguments(post, heroTag));
  }

  EdgeInsets calculatePostItemMargin(int index, List<Post> items) {
    EdgeInsets cardMargin;
    if (index > 0 && (items[index].startDate == items[index - 1].startDate)) {
      if (index == items.length - 1) {
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
      if (index == items.length - 1) {
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

  Widget getDayText(int index, List<Post> items) {
    Widget dayText;

    if (index == 0 || (items[index].startDate != items[index - 1].startDate)) {
      dayText = Text(
        TimeAgoFormatter(items[index].startDate).toString(),
        style: TextStyles.subtitle2.copyWith(color: ColorSets.defaultTextColor),
      );
    }

    return dayText;
  }

  Future<void> _refreshPosts() {
    // todo: Refresh Posts
    return Future.delayed(Duration(seconds: 1)); // Temp return
  }

  Widget buildHomePage(BuildContext context, List<Post> postItems) {
    return RefreshIndicator(
      onRefresh: _refreshPosts,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView.builder(
            itemCount: postItems.length,
            itemBuilder: (BuildContext ctxt, int index) {
              EdgeInsets cardMargin = calculatePostItemMargin(index, postItems);
              Widget dayText = getDayText(index, postItems);

              var heroTag = "post-" + index.toString();

              return Stack(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      height: 30,
                      child: dayText),
                  PostItem(
                    cardMargin: cardMargin,
                    heroTag: heroTag,
                    onTapEvent: postTapEvent,
                    item: postItems[index],
                  )
                ],
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
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
        Widget body;
        print(state);
        if (state.isInitial || state.isLoading) {
          body = Center(child: CircularProgressIndicator());
        } else if (state.isLoaded) {
          body = buildHomePage(context, state.postList);
        }
        return body;
      },
    );
  }
}
