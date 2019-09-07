import 'package:GTUBT/models/user.dart';
import 'package:bloc/bloc.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  get initialState => UserState(user: User());

  UserState currentState;

  @override
  Stream<UserState> mapEventToState(event) async* {
    if (event is PhotoChanged) {
      currentState = UserState(user: currentState.user.rebuild((b) => b
      ..profilePhoto = event.url));
    }
    else if (event is LoggedIn) {
      currentState = UserState(user: event.user);
    }
    else if (event is PhoneChanged) {
      currentState = UserState(user: currentState.user.rebuild((b) => b
      ..phone = event.phone));
    }
    
    yield currentState;
  }
}