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
    return this.toString().replaceAll(RegExp('_'), '-').split('.')[1];
  }

  String getMessage() {
    switch (this) {
      case AuthenticationExceptionEnum.email_already_in_use:
        return "This email is in use. If you forgot your password, click \"Forgot Password\" on login screen.";
      case AuthenticationExceptionEnum.invalid_email:
        return "Invalid email!";
      case AuthenticationExceptionEnum.operation_not_allowed:
        return "Operation not allowed!";
      case AuthenticationExceptionEnum.weak_password:
        return "Weak password!";
      case AuthenticationExceptionEnum.wrong_password:
        return "No user found to match with given credentials!";
      case AuthenticationExceptionEnum.user_not_found:
        return "No user found to match with given credentials!";
      default:
        return "Something went wrong!";
    }
  }
}
