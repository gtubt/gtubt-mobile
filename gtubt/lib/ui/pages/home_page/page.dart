import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/models/view_models/post_view_arguments.dart';
import 'package:GTUBT/ui/blocs/post_bloc/post_bloc.dart';
import 'package:GTUBT/ui/blocs/post_bloc/post_event.dart';
import 'package:GTUBT/ui/blocs/post_bloc/post_state.dart';
import 'package:GTUBT/ui/routes.dart';
import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/time_ago_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components.dart';

class HomePage extends StatelessWidget {
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
    List<Post> pageItems = [];
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        //todo Single event loading will be handled here
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.isInitial) {
            BlocProvider.of<PostBloc>(context).add(
              LoadAllPosts(),
            );
            return Center(child: CircularProgressIndicator());
          } else if (state.isSuccess) {
            pageItems = state.postList;
            return buildHomePage(context, pageItems);
          }
          //todo burada hata sayfası görünecek veya popup basılacak
          return Text("POST RECEIVE ERROR");
        },
      ),
    );
    //return buildHomePage(context, pageItems);
  }
}
