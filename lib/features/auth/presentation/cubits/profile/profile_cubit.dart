import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fb_auth_bloc/features/auth/data/models/user_model.dart';
import 'package:fb_auth_bloc/features/auth/domain/usecases/get_profile_usecase.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  ProfileCubit({required this.getProfileUseCase})
      : super(ProfileState.initial());

  FutureOr<void> getProfile({required String uid}) async {
    emit(state.copyWith(failure: null, profileStatus: ProfileStatus.initial));
    final response = await getProfileUseCase(UidParams(uid: uid));
    response.fold(
      (failure) {
        emit(state.copyWith(
            failure: failure, profileStatus: ProfileStatus.error));
      },
      (user) {
        emit(state.copyWith(
          failure: null,
          profileStatus: ProfileStatus.loaded,
          user: user,
        ));
      },
    );
  }
}
