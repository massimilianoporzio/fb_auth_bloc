import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fb_auth_bloc/features/auth/domain/usecases/signin_usecase.dart';

import '../../../../../core/errors/failures.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninUseCase signinUseCase;

  SigninCubit({required this.signinUseCase}) : super(SigninState.initial());

  FutureOr<void> signin(
      {required String email, required String password}) async {
    //feedback che sto facendo il signin
    emit(state.copyWith(signinStatus: SigninStatus.submitting));
    //chiamo il caso d'uso
    final response =
        await signinUseCase(SignInParams(password: password, email: email));
    response.fold(
      (failure) => emit(
          state.copyWith(signinStatus: SigninStatus.error, failure: failure)),
      (r) {
        emit(state.copyWith(signinStatus: SigninStatus.success));
      },
    );
  }
}
