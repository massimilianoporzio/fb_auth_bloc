import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/signup_usecase.dart';

import '../../../../../core/errors/failures.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;
  SignupCubit({required this.signupUseCase}) : super(SignupState.initial());

  FutureOr<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signupState: SignupStatus.submitting));
    SignUpParams params =
        SignUpParams(name: name, email: email, password: password);
    final response = await signupUseCase(params);
    response.fold(
      (failure) => emit(
          state.copyWith(signupState: SignupStatus.error, failure: failure)),
      (r) => emit(
          state.copyWith(signupState: SignupStatus.success, failure: null)),
    );
  }
}
