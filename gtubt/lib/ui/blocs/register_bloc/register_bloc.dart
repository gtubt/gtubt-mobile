import 'package:GTUBT/exceptions/authentication.dart';
import 'package:GTUBT/exceptions/user.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/ui/blocs/register_bloc/bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';
import 'package:bloc/bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService = AuthService();

  RegisterBloc() : super(RegisterState.empty());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EmailChanged) {
      yield state.update(isEmailValid: Validators.isValidEmail(event.email));
    } else if (event is NameChanged) {
      yield state.update(isNameValid: Validators.isValidString(event.name));
    } else if (event is LastnameChanged) {
      yield state.update(
          isLastnameValid: Validators.isValidString(event.lastname));
    } else if (event is PasswordChanged) {
      yield state.update(
          isPasswordValid: Validators.isValidPassword(event.password));
    } else if (event is StudentNumberChanged) {
      yield state.update(
          isStudentNumberValid:
              Validators.isValidStudentNumber(event.studentNumber));
    } else if (event is Submitted) {
      yield* _mapSubmittedToState(event);
    }
  }

  Stream<RegisterState> _mapSubmittedToState(Submitted event) async* {
    yield RegisterState.loading();

    User user = User(
        email: event.email,
        first_name: event.name,
        last_name: event.lastname,
        department: Department.cse,
        student_id: event.studentNumber,
        year: 1,
        is_accept_kvkk: event.isAcceptKVKK,
        is_accept_user_agreement: event.isAcceptUserAgreement);
    try {
      String message = await _authService.signUp(user, event.password);
      yield RegisterState.success(message);
    } on AuthenticationException catch (error) {
      yield RegisterState.failure(error.message);
    } on UserException catch (error) {
      await _authService.deleteUser();
      yield RegisterState.failure(error.message);
    }
  }
}
