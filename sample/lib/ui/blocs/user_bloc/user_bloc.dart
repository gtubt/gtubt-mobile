import 'package:GTUBT/models/user.dart';
import 'package:bloc/bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  get initialState => UserState.nullState();

  UserState currentState = UserState.loggedOut();

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (currentState == null) {
      currentState = initialState;
    }

    if (event is PhotoChanged) {
      currentState.user.profilePhoto = event.url;
    } else if (event is UserLoggedIn) {
      currentState = UserState(user: event.user);
    } else if (event is PhoneChanged) {
      currentState.user.phone = event.phone;
    } else if (event is ToggleEditMode) {
      // TODO: Call updateUser endpoint here using currentState user if editMode was true. Update currentState user with results of the endpoint.
      if (currentState.editMode == true) {
        UserUpdate(currentState.user);
      }
      currentState =
          UserState(user: currentState.user, editMode: !currentState.editMode);
    } else if (event is GetUser) {
      currentState.user = User(
        name: 'name',
        id: 'id',
        department: Department.cse,
        lastname: 'lastname',
        email: 'email',
        phone: '123',
        studentId: '1231',
        year: 1292,
      );
      //TODO: GET USER FROM ENDPOİNT
    }
    yield currentState;
  }
}
