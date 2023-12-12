import 'package:onco_connect/common/exceptions/base_app_exception.dart';

class UserAuthException extends AppException {
  Object cause;
  UserAuthException(this.cause)
      : super(
          codeInt: 401,
          codeString: "Auth Error",
          message: cause.toString(),
        );
}

class DuplicateUserException extends AppException {
  DuplicateUserException()
      : super(
          codeInt: 409,
          codeString: "Duplication Error",
          message: "User with the same email already exists",
        );
}

class UserNotFoundException extends AppException {
  UserNotFoundException()
      : super(
          codeInt: 401,
          codeString: "Auth Error",
          message: "User with the email does not exist",
        );
}
class WrongPasswordException extends AppException {
  WrongPasswordException()
      : super(
          codeInt: 401,
          codeString: "Auth Error",
          message: "Wrong password provided for that user",
        );
}
class InvalidCredentialException extends AppException {
  InvalidCredentialException()
      : super(
          codeInt: 401,
          codeString: "Auth Error",
          message: "Invalid Credentials",
        );
}
