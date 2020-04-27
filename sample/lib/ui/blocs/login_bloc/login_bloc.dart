import 'package:GTUBT/ui/blocs/login_bloc/bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.empty();


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangeToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangeToState(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          event.email, event.password);
    }
  }

  Stream<LoginState> _mapEmailChangeToState(String email) async* {
    yield currentState.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangeToState(String password) async* {
    yield currentState.update(
        isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      String email, String password) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
      isPasswordValid: Validators.isValidPassword(password),
    );
  }
}
