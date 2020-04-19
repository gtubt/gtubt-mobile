import 'package:GTUBT/ui/blocs/login_bloc/bloc.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginUninitialized();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) {
    if (event is EmailChanged) {
      _mapEmailChangeToState(event.email);
    } else if (event is PasswordChanged) {
    } else if (event is Submitted) {
    } else if (event is LoginWithCredentials) {}
  }

  Stream<LoginState> _mapEmailChangeToState(String email) async* {
    yield LoginUpdate(email);
  }


}
