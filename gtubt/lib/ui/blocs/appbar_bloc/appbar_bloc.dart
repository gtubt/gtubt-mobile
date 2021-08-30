import 'package:GTUBT/exceptions/user.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/user.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_event.dart';
import 'package:GTUBT/ui/blocs/appbar_bloc/appbar_state.dart';
import 'package:bloc/bloc.dart';
import 'package:kiwi/kiwi.dart';

class AppbarBloc extends Bloc<AppbarEvent, AppbarState> {
  UserService userService = UserService();
  KiwiContainer container = KiwiContainer();
  AppbarBloc() : super(AppbarState());
  bool isLoading = false;

  @override
  Stream<AppbarState> mapEventToState(AppbarEvent event) async* {
    if (event is UserEditButtonPressed) {
      var editMode = this.state.editMode;
      if (editMode) {
        try {
          yield AppbarLoadingState();
          await userService.patch(userService.currentUser!);
          yield AppbarState(editMode: !editMode);
        } on UserException catch (_) {
          yield AppbarErrorState();
        }
      } else {
        userService.userBackup = User.clone(userService.currentUser!);
        yield AppbarState(editMode: !editMode);
      }
    } else if (event is UserEditCancelled) {
      // User might have edited email.
      userService.currentUser = User.clone(userService.userBackup!);
      yield AppbarState();
    } else if (event is PageChangedAppbarEvent) {
      yield AppbarState();
    }
    else if (event is ShowLoading) {
      yield AppbarLoadingState();
      isLoading = true;
    }
    else if (event is HideLoading){
      if (isLoading) {
        yield AppbarState();
        isLoading = false;
      }
    }
  }
}
