import 'package:bloc/bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  get initialState => UserState(user: null);

  UserState currentState;

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (currentState == null) {
      currentState = initialState;
    }

    if (event is PhotoChanged) {
      currentState.user.profilePhoto = event.url;
    } else if (event is LoggedIn) {
      currentState = UserState(user: event.user);
    } else if (event is PhoneChanged) {
      currentState.user.phone = event.phone;
    } else if (event is ToggleEditMode) {
      // TODO: Call updateUser endpoint here using currentState user if editMode was true. Update currentState user with results of the endpoint.
      currentState =
          UserState(user: currentState.user, editMode: !currentState.editMode);
    }

    yield currentState;
  }
}
