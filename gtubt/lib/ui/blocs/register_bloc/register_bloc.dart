import 'package:GTUBT/exceptions/authentication.dart';
import 'package:GTUBT/exceptions/user.dart';
import 'package:GTUBT/models/user.dart';
import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/service/user.dart';
import 'package:GTUBT/ui/blocs/register_bloc/bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';
import 'package:bloc/bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

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
        name: event.name,
        lastname: event.lastname,
        department: Department.cse,
        studentId: event.studentNumber);
    try {
      await _authService.signUp({
        'email': user.email,
        'password': event.password,
      });
      await _userService.post(user);
      yield RegisterState.success();
    } on AuthenticationException catch (error) {
      yield RegisterState.failure(error.message);
    } on UserException catch (error) {
      yield RegisterState.failure(error.message);
    }
  }
}
