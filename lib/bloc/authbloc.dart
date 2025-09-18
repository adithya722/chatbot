import 'package:design/bloc/authevent.dart';
import 'package:design/bloc/authstate.dart';
import 'package:design/domain/loginusecase.dart';
import 'package:design/domain/signupusecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;

  AuthBloc(this._loginUseCase, this._signupUseCase) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await _loginUseCase.execute(event.email, event.password);
        if (success) {
          emit(AuthSuccess());
        } else {
          emit( AuthFailure('Invalid email or password'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await _signupUseCase.execute(
          event.name,
          event.email,
          event.password,
        );
        if (success) {
          emit(AuthSuccess());
        } else {
          emit( AuthFailure('Signup failed'));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}