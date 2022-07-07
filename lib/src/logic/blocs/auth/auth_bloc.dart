import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/provider/login_provider.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with HydratedMixin {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      // if (state.email != "") {
      //   emit(
      //     AuthSuccess(state.email)
      //   );
      // }
      emit(const AuthLoading(""));
      try {
        String token = await login(event.username, event.password);

        log("Debug: $token");

        if (token.isNotEmpty) {
          String email = event.username;

          // List<dynamic> nameSurname = await getNameSurname(event.username);
          // print("NAme and surname:");
          // print(nameSurname);

          emit(AuthSuccess(email, token));
        } else {
          emit(const AuthFailed());
        }
      } catch (e) {
        print(e);
        emit(const AuthError());
      }
    });

    on<AuthRegister>((event, emit) async {
      try {
        emit(const AuthLoading(""));
        bool success = await register(event.username, event.password);
        if (success) {
          emit(const AuthRegisterSuccess());
        } else {
          emit(const AuthError());
        }
      } catch (_) {
        emit(const AuthError());
      }
    });

    on<AuthConfirmPassword>((event, emit) async {
      try {
        emit(const AuthLoading(""));

        bool success = await confirmPassword(event.username, event.code);
        if (success) {
          emit(const AuthConfirmPasswordSucces());
        } else {
          emit(const AuthError());
        }
      } catch (_) {
        emit(const AuthError());
      }
    });

    on<AuthLogout>((event, emit) {
      emit(const AuthLoading(""));
      emit(const AuthInitial());
    });

    // on<AuthChangeInfo>(
    //   (event, emit) async {
    //     String email = state.email;
    //     String token = state.token;
    //     String name = state.name;
    //     String surname = state.surname;
    //     int id = state.id_info;
    //     emit(const AuthLoading(""));
    //     try {
    //       String imageLink = await putImage(event.file, id, token, name, surname);
    //       emit(AuthSuccess(email, token, name, surname, imageLink, id));
    //     } catch (e) {
    //       emit(const AuthError());
    //     }
    //   },
    // );
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    return state.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toMap();
  }
}
