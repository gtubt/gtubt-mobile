import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PostEvent extends Equatable {
  PostEvent() : super();
}

class LoadAllPosts extends PostEvent {
  LoadAllPosts() : super();

  @override
  String toString() {
    return 'Posts are being refreshed';
  }

  @override
  List<Object> get props => [];
}