part of 'profile_cubit.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error;
}

class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final User user;
  final Failure? failure;

  const ProfileState({
    required this.profileStatus,
    required this.user,
    this.failure,
  });

  factory ProfileState.initial() {
    return ProfileState(
        profileStatus: ProfileStatus.initial, user: UserModel.initial());
  }

  @override
  List<Object?> get props => [profileStatus, user, failure];

  @override
  String toString() =>
      'ProfileState(profileStatus: $profileStatus, user: $user, failure: $failure)';

  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    Failure? failure,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }
}
