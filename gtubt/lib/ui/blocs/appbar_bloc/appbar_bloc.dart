import 'package:GTUBT/exceptions/user.dart';
import 'package:GTUBT/service/user.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_event.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:bloc/bloc.dart';

class AppbarBloc extends Bloc<AppbarEvent, AppbarState> {
  UserService userService = UserService();

  AppbarBloc() : super(AppbarState());

  @override
  Stream<AppbarState> mapEventToState(AppbarEvent event) async* {
    if (event is UserEditButtonPressed) {
      if (this.state.editMode) {
        try {
          userService.patch(userService.currentUser);
          yield AppbarState(editMode: !this.state.editMode);
        } on UserException catch (_) {
          yield AppbarErrorState();
        }
      }
    } else if (event is PageChangedAppbarEvent) {
      yield AppbarState();
    }
  }
}
