import 'package:GTUBT/service/user.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_event.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:bloc/bloc.dart';

class AppbarBloc extends Bloc<AppbarEvent, AppbarState> {
  UserService userService = UserService();
  @override
  AppbarState get initialState => AppbarState();

  @override
  Stream<AppbarState> mapEventToState(AppbarEvent event) async* {
    if (event is UserEditButtonPressed) {
      if (this.state.editMode) {
        userService.patch(userService.currentUser);
      }

      yield AppbarState(editMode: !getCurrentEditButtonState());
    } else if (event is PageChangedAppbarEvent) {
      yield AppbarState();
    }
  }

  bool getCurrentEditButtonState() {
    bool isEditMode = false;

    isEditMode = this.state.editMode;

    return isEditMode;
  }
}
