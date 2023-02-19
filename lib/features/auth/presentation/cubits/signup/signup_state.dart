part of 'signup_cubit.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error;
}

class SignupState extends Equatable {
  final SignupStatus signupState;
  final Failure? failure;

  const SignupState({
    required this.signupState,
    this.failure,
  });

  factory SignupState.initial() =>
      const SignupState(signupState: SignupStatus.initial, failure: null);

  @override
  List<Object?> get props => [signupState, failure];

  @override
  String toString() =>
      'SignupState(signupState: $signupState, failure: $failure)';

  SignupState copyWith({
    SignupStatus? signupState,
    Failure? failure,
  }) {
    return SignupState(
      signupState: signupState ?? this.signupState,
      failure: failure ?? this.failure,
    );
  }
}
