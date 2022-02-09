import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/auth/models/auth_response_model.dart';
import 'package:ecommerce/auth/models/login_register_response_model.dart';
import 'package:ecommerce/auth/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is InitialEvent) {
        emit(AuthInitial());
      } else if (event is GetAuthUserEvent) {
        try {
          final AuthResponseModel model = await repository.authUser();
          if (model.status == 200) {
            emit(AuthLoaded(model: model));
          } else {
            emit(AuthError(message: model.error));
          }
        } catch (e) {
          log(e.toString());

          emit(AuthError(message: e.toString()));
        }
      } else if (event is LoginEvent) {
        emit(AuthLoading());
        try {
          Map<String, String> jsonBody = {
            'email': event.email,
            'password': event.password
          };

          final LoginRegisterResponseModel model =
              await repository.login(jsonPostdata: jsonBody);

          if (model.status == 200) {
            log(model.success.toString());
            emit(LoginRegisterLoaded(model: model));
          } else {
            emit(AuthError(message: model.error));
          }
        } catch (e) {
          log(e.toString());

          emit(AuthError(message: e.toString()));
        }
      } else if (event is RegisterEvent) {
        emit(AuthLoading());

        try {
          Map<String, String> jsonBody = {
            'email': event.email,
            'password': event.password,
            'name': event.name,
            'mobileNumber': event.mobileNumber
          };

          final LoginRegisterResponseModel model =
              await repository.register(jsonPostdata: jsonBody);

          if (model.status == 200) {
            emit(LoginRegisterLoaded(model: model));
          } else {
            emit(AuthError(message: model.error));
          }
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      } else if (event is LogoutEvent) {
        emit(AuthLoading());
        try {
          await repository.logout();
          emit(LogoutLoaded());
        } catch (e) {
          emit(AuthError(message: e.toString()));
        }
      }
    });
  }
}
