part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  final String username;
  final String password;

  const AuthEvent(this.username, this.password);
  @override
  List<Object?> get props => [username, password];
}

class AuthLogin extends AuthEvent {
  const AuthLogin(String username, String password) : super(username, password);
}

class AuthLogout extends AuthEvent {
  const AuthLogout() : super("", "");
}

class AuthRegister extends AuthEvent {
  const AuthRegister(String username, String password) : super(username, password);
}

class AuthChangeInfo extends AuthEvent {
  final File? file;
  const AuthChangeInfo(this.file) : super("", "");
}

class AuthRegisterSendNameSurname extends AuthEvent {
  final File? file;
  final String name;
  final String surname;
  const AuthRegisterSendNameSurname(
      {required String username,
      required String password,
      required this.name,
      required this.surname,
      this.file})
      : super(username, password);
}

class AuthConfirmPassword extends AuthEvent {
  final String code;
  const AuthConfirmPassword(String username, String password, this.code)
      : super(username, password);
}
