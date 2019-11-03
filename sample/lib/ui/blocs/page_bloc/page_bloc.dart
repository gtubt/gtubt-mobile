import 'package:bloc/bloc.dart';
import 'page_event.dart';
import 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  get initialState => PageState(currentPage: 0);

  @override
  Stream<PageState> mapEventToState(event) async* {
    if (event is PageChanged) {
      yield PageState(currentPage: event.page);
    }
  }
}
