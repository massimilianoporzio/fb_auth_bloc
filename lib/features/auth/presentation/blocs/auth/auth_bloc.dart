import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fb_auth_bloc/core/domain/usecases/base_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/signout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUserUseCase getUserUseCase;
  final SignoutUseCase signOutUseCase;
  late StreamSubscription authSubscription;
  AuthBloc({
    required this.getUserUseCase,
    required this.signOutUseCase,
  }) : super(AuthState.unknown()) {
    authSubscription =
        getUserUseCase(const NoParameters()).listen((fbAuth.User? user) {
      add(AuthStateChangedEvent(user: user)); //lo espongo come evento
    });
    on<AuthStateChangedEvent>(
      (event, emit) {
        if (event.user != null) {
          //*AUTENTICATO!
          emit(
            state.copyWith(
                authStatus: AuthStatus.authenticated, user: event.user),
          );
        } else {
          //NULLO = LOGOUT
          emit(
            state.copyWith(authStatus: AuthStatus.unauthenticated, user: null),
          );
        }
      },
    );
    on<SignoutRequestedEvent>(
      (event, emit) async {
        await signOutUseCase(const NoParameters());
      },
    );
  }
}
