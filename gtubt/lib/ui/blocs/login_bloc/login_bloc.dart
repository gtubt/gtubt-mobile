import 'package:GTUBT/exceptions/authentication.dart';
import 'package:GTUBT/service/authentication.dart';
import 'package:flutter/widgets.dart';
import 'package:GTUBT/ui/blocs/login_bloc/bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginBloc() : super(LoginState.empty());

  // @override
  // Stream<LoginState> transformEvents(
  //   Stream<LoginEvent> events,
  //   Stream<LoginState> Function(LoginEvent) next,
  // ) {
  //   final observableStream = events;
  //   final nonDebounceStream = observableStream.where((event) {
  //     return (event is! EmailChanged && event is! PasswordChanged);
  //   });
  //   final debounceStream = observableStream.where((event) {
  //     return (event is EmailChanged || event is PasswordChanged);
  //   }).debounceTime(Duration(milliseconds: 300));
  //   return super
  //       .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  // }

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
    yield LoginState.loading("Logging in...");
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      yield LoginState.success();
    } on AuthenticationException catch (error) {
      yield LoginState.failure(error.message);
    }
  }

  Stream<LoginState> _mapForgotPasswordPressedToState(String email) async* {
    if (Validators.isValidEmail(email)) {
      yield LoginState.loading("Sending password reset email...");
      try {
        await _authService.sendPasswordResetEmail(email);
        yield state.update(isPwRequestSent: true);
      } on AuthenticationException catch (error) {
        yield state.update(
            errorMessage: error.message,
            isFailure: true,
            isPwRequestSent: false);
      }
    } else {
      yield LoginState.failForgotPassword("Please enter a valid email");
    }
  }
}
