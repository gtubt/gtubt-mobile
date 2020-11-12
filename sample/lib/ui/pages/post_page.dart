import 'package:GTUBT/ui/utils/time_ago_formatter.dart';
import 'package:flutter/material.dart';
import 'package:GTUBT/models/post.dart';
import 'package:GTUBT/models/view_models/post_view_arguments.dart';
import '../utils/time_ago_formatter.dart';

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
          child: Text(TimeAgoFormatter(post.startDate).toString()),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(post.body),
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Hero(
                      tag: postArgs.heroTag,
                      child: Image.network(
                        post.coverImageUrl,
                        fit: BoxFit.cover,
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
