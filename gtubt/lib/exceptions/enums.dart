enum AuthenticationExceptionEnum {
  generic,
  email_already_in_use,
  invalid_email,
  operation_not_allowed,
  weak_password,
  user_disabled,
  user_not_found,
  wrong_password
}

extension ErrorCodeExt on AuthenticationExceptionEnum {
  String getString() {
    return this.toString().replaceAll(RegExp('_'), '-');
  }

  String getMessage() {
    switch (this) {
      case AuthenticationExceptionEnum.email_already_in_use:
        return "This email is in use. If you forget password, try to forget password!";
      case AuthenticationExceptionEnum.invalid_email:
        return "Invalid email.";
      case AuthenticationExceptionEnum.operation_not_allowed:
        return "Operation not allowed";
      case AuthenticationExceptionEnum.weak_password:
        return "Weak password";
      case AuthenticationExceptionEnum.wrong_password:
        return "Password or email is wrong";
      default:
        return "Something went wrong!";
    }
  }
}

