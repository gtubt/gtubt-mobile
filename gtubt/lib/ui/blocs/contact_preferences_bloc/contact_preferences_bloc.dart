import 'package:GTUBT/exceptions/authentication.dart';
import 'package:GTUBT/ui/blocs/contact_preferences_bloc/bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';
import 'package:bloc/bloc.dart';

class ContactPreferencesBloc extends Bloc<ContactPreferencesEvent, ContactPreferencesState> {

  ContactPreferencesBloc() : super(ContactPreferencesState.empty());

  @override
  Stream<ContactPreferencesState> mapEventToState(ContactPreferencesEvent event) async* {
    
  }

  Stream<ContactPreferencesState> _mapEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<ContactPreferencesState> _mapPasswordChangeToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<ContactPreferencesState> _mapContactPreferencesWithCredentialsPressedToState(
      String email, String password) async* {
    yield ContactPreferencesState.loading("Logging in...");
    try {
     
    } on AuthenticationException catch (error) {
      yield ContactPreferencesState.failure(error.message);
    }
  }

  Stream<ContactPreferencesState> _mapForgotPasswordPressedToState(String email) async* {
    if (Validators.isValidEmail(email)) {
      yield ContactPreferencesState.loading("Sending password reset email...");
      try {
      
      } on AuthenticationException catch (error) {
        yield state.update(
            errorMessage: error.message,
            isFailure: true,
            isPwRequestSent: false);
      }
    } else {
      yield ContactPreferencesState.failForgotPassword("Please enter a valid email");
    }
  }
}
