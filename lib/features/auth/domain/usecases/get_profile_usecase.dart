import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fb_auth_bloc/core/domain/usecases/base_usecase.dart';
import 'package:fb_auth_bloc/core/errors/failures.dart';
import 'package:fb_auth_bloc/features/auth/domain/repositories/profile_repository.dart';

import '../entities/user.dart';

class UidParams extends Equatable {
  final String uid;
  const UidParams({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];

  @override
  String toString() => 'UidParams(uid: $uid)';
}

class GetProfileUseCase extends BaseUseCase<User, UidParams> {
  final ProfileRepository profileRepository;
  GetProfileUseCase({
    required this.profileRepository,
  });
  @override
  Future<Either<Failure, User>> call(UidParams parameters) async {
    return await profileRepository.getProfile(uid: parameters.uid);
  }
}
