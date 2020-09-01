import 'package:GTUBT/service/authentication.dart';
import 'package:GTUBT/ui/blocs/register_bloc/bloc.dart';
import 'package:GTUBT/ui/utils/validators.dart';
import 'package:bloc/bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService = AuthService();

  RegisterBloc();

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EmailChanged) {
      yield state.update(isEmailValid: Validators.isValidEmail(event.email));
    } else if (event is NameChanged) {
      yield state.update(isNameValid: Validators.isValidString(event.name));
    } else if (event is SurnameChanged) {
      yield state.update(
          isSurnameValid: Validators.isValidString(event.surname));
    } else if (event is PasswordChanged) {
      yield state.update(
          isPasswordValid: Validators.isValidPassword(event.password));
    } else if (event is ClassChanged) {
      yield state.update(isGradeValid: Validators.isValidDigit(event.grade));
    } else if (event is PhoneNumberChanged) {
      yield state.update(
          isPhoneNumberValid: Validators.isValidPhoneNumber(event.phoneNumber));
    } else if (event is StudentNumberChanged) {
      yield state.update(
          isStudentNumberValid:
              Validators.isValidStudentNumber(event.studentNumber));
    } else if (event is DepartmentChanged) {
      yield state.update(
          isDepartmentValid: Validators.isValidString(event.department));
    } else if (event is Submitted) {
      yield* _mapSubmittedToState(event);
    }
  }

  Stream<RegisterState> _mapSubmittedToState(Submitted event) async* {
    yield RegisterState.loading();

    try {
//      TODO: make into model
      Map<String, dynamic> data = {
        'email': event.email,
        'password': event.password,
        'name': event.name,
        'surname': event.surname,
        'grade': event.grade,
        'department': event.department,
        'phoneNumber': event.phoneNumber,
        'studentNumber': event.studentNumber
      };

      await _authService.signUp(data);
      // TODO: create user if signUp is successful
      yield RegisterState.success();
    } catch (error) {
      yield RegisterState.failure();
    }
  }
}
