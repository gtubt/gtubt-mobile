import 'package:flutter/material.dart';

import '../../models/post.dart';
import 'package:GTUBT/models/view_models/post_view_arguments.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPage createState() => _PostPage();
}

class _PostPage extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    PostViewArguments postArgs = ModalRoute.of(context).settings.arguments;
    var post = postArgs.post;
    print(postArgs.post);
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
                    )
                ),
              ),
            ];
          },
          body: Text(post.body),
        ),
      ),
    );
  }
}
