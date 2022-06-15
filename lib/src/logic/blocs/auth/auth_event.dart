part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  final String username;
  final String password;

  AuthEvent(this.username, this.password);
  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}

class AuthLogin extends AuthEvent {
  AuthLogin(String username, String password) : super(username, password);
}

class AuthLogout extends AuthEvent {
  AuthLogout() : super("", "");
}

class AuthRegister extends AuthEvent {
  AuthRegister(String username, String password) : super(username, password);
}

class AuthChangeInfo extends AuthEvent {
  File? file;
  AuthChangeInfo(this.file) : super("", "");
}

class AuthRegisterSendNameSurname extends AuthEvent {
  final File? file;
  final name;
  final surname;
  AuthRegisterSendNameSurname(
      {required String username,
      required String password,
      required this.name,
      required this.surname,
      this.file})
      : super(username, password);
}

class AuthConfirmPassword extends AuthEvent {
  final code;
  AuthConfirmPassword(String username, String password, this.code)
      : super(username, password);
}