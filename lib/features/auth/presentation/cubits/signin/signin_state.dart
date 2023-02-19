part of 'signin_cubit.dart';

enum SigninStatus {
  initial,
  submitting,
  success,
  error;
}

class SigninState extends Equatable {
  final SigninStatus signinStatus;
  final Failure failure;

  const SigninState({
    required this.signinStatus,
    required this.failure,
  });

  factory SigninState.initial() {
    return SigninState(
      signinStatus: SigninStatus.initial,
      failure: Failure(message: ''),
    );
  }

  @override
  List<Object> get props => [signinStatus, failure];

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
