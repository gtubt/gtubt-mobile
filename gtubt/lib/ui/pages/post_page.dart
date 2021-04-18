import 'package:GTUBT/ui/style/color_sets.dart';
import 'package:GTUBT/ui/style/text_styles.dart';
import 'package:GTUBT/ui/utils/time_ago_formatter.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/models/view_models/post_view_arguments.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPage createState() => _PostPage();
}

class _PostPage extends State<PostPage> {
  Widget buildBody(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            TimeAgoFormatter(post.startDate).toString(),
            style: TextStyles.subtitle2
                .copyWith(color: ColorSets.defaultTextColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            post.body,
            style: TextStyles.subtitle2
                .copyWith(color: ColorSets.defaultTextColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    PostViewArguments postArgs = ModalRoute.of(context).settings.arguments;
    var post = postArgs.post;
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
                    title: Text(post.title,
                        style: TextStyles.subtitle1
                            .copyWith(color: ColorSets.lightTextColor)),
                    background: Hero(
                      tag: postArgs.heroTag,
                      child: Image.network(
                        post.coverImageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stacktrace) {
                          return Image.asset(
                            "assets/error.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )),
              ),
            ];
          },
          body: buildBody(post),
        ),
      ),
    );
  }
}
