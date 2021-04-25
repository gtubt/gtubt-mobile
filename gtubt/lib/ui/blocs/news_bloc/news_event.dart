import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  NewsEvent() : super();
}

class FetchNews extends NewsEvent {
  FetchNews() : super();

  @override
  String toString() {
    return 'News are being refreshed';
  }

  @override
  List<Object> get props => [];
}