import 'package:GTUBT/service/authentication.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:GTUBT/ui/blocs/login_bloc/bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent) next,
  ) {
    final observableStream = events;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangeToState(emailController.text.trim());
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangeToState(passwordController.text.trim());
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          emailController.text.trim(), passwordController.text.trim());
    } else if (event is ForgotPasswordPressed) {
      yield* _mapForgotPasswordPressedToState(event.email);
    }
  }

  Stream<LoginState> _mapEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangeToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      String email, String password) async* {
    yield LoginState.loading();
    var result = await _authService.signInWithEmailAndPassword(email, password);
    if (result.isLeft()) {
      yield LoginState.success();
    } else {
      AuthFailure failure = result as AuthFailure;
      yield LoginState.failure(failure.toString());
    }
  }

  Stream<LoginState> _mapForgotPasswordPressedToState(String email) async* {
    yield LoginState.loading();
    try {
      await _authService.sendPasswordResetEmail(email);
      yield state.update(isPwRequestSent: true);
    } catch (_) {
      yield state.update(isPwRequestSent: false);
    }
  }
}
