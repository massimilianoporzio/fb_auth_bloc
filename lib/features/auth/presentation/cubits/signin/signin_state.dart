part of 'signin_cubit.dart';

enum SigninStatus {
  initial,
  submitting,
  success,
  error;
}

class SigninState extends Equatable {
  final SigninStatus signinStatus;
  final Failure? failure;

  const SigninState({
    required this.signinStatus,
    this.failure,
  });

  factory SigninState.initial() {
    return const SigninState(
      signinStatus: SigninStatus.initial,
      failure: null,
    );
  }

  @override
  List<Object?> get props => [signinStatus, failure];

  @override
  String toString() =>
      'SigninState(signinStatus: $signinStatus, failure: $failure)';

  SigninState copyWith({
    SigninStatus? signinStatus,
    Failure? failure,
  }) {
    return SigninState(
      signinStatus: signinStatus ?? this.signinStatus,
      failure: failure ?? this.failure,
    );
  }
}
