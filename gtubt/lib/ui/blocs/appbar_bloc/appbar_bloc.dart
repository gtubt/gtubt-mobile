import 'package:GTUBT/models/user.dart';
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
    var result;
    if (event is UserEditButtonPressed) {
      if (this.state.editMode) {
        result = userService.patch(userService.currentUser);
        if (result.isLeft()) {
          var user = result as User; //not used ?
          yield AppbarState(editMode: !this.state.editMode);
        } else {
          //error state
        }
      }
    } else if (event is PageChangedAppbarEvent) {
      yield AppbarState();
    }
  }
}
